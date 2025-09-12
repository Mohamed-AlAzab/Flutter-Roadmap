import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:flutter/material.dart';
import 'package:flutter_roadmap/core/constant/string.dart';
import 'package:flutter_roadmap/features/auth/domain/entity/user.dart';
import 'package:flutter_roadmap/features/auth/domain/repository/auth_repository.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepositoryImpl extends AuthRepository {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  // ignore: body_might_complete_normally_nullable
  Future<User?> loginWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      User user = User(uid: userCredential.user!.uid, email: email);

      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw Exception('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        throw Exception('Wrong password provided for that user.');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  // ignore: body_might_complete_normally_nullable
  Future<User?> registerWithEmailAndPassword(
    String name,
    String email,
    String password,
  ) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      User user = User(uid: userCredential.user!.uid, email: email);

      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw Exception('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw Exception('The account already exists for that email.');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<User?> getCurrentUser() async {
    final currentUser = firebaseAuth.currentUser;

    if (currentUser == null) return null;

    return User(uid: currentUser.uid, email: currentUser.email!);
  }

  @override
  Future<String> resetPasswordByEmail(String email) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
      return resetPasswordByEmailString;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> logout() async {
    await firebaseAuth.signOut();
  }

  @override
  Future<void> deleteAccount() async {
    try {
      final user = firebaseAuth.currentUser;

      if (user == null) throw Exception('No user logged in');

      await user.delete();

      await logout();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  @override
  Future<User?> signInWithGoogle() async {
    await _googleSignIn.initialize(serverClientId: clientId);

    try {
      final account = await _googleSignIn.authenticate();
      // ignore: unnecessary_null_comparison
      if (account == null) return null;

      final auth = account.authentication;

      final credential = GoogleAuthProvider.credential(idToken: auth.idToken);

      final userCredential = await firebaseAuth.signInWithCredential(
        credential,
      );

      final user = userCredential.user;
      if (user == null) return null;

      return User(uid: user.uid, email: user.email ?? '');
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  @override
  Future<User> signInWithGitHub() async {
    GithubAuthProvider githubProvider = GithubAuthProvider();
    final firebaseUser = await FirebaseAuth.instance.signInWithProvider(
      githubProvider,
    );
    return User(uid: firebaseUser.user!.uid, email: firebaseUser.user!.email!);
  }
}
