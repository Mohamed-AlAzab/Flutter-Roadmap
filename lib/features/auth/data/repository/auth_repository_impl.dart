import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_roadmap/core/constant/collection_name.dart';
import 'package:flutter_roadmap/core/constant/string.dart';
import 'package:flutter_roadmap/features/auth/domain/entity/user.dart';
import 'package:flutter_roadmap/features/auth/domain/repository/auth_repository.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepositoryImpl extends AuthRepository {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final firebaseFirestore = FirebaseFirestore.instance.collection(
    usersCollectionName,
  );

  @override
  Future<AppUser?> loginWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      if (userCredential.user == null) throw Exception('Login failed');

      await createUserinFirestore(userCredential.user!);

      if (userCredential.user!.emailVerified) {
        AppUser user = AppUser(uid: userCredential.user!.uid, email: email);
        return user;
      } else {
        throw Exception('Please check your email to verify your account');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<AppUser?> registerWithEmailAndPassword(
    String name,
    String email,
    String password,
  ) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      userCredential.user!.sendEmailVerification();

      await userCredential.user!.updateDisplayName(name);
      await userCredential.user?.reload();

      await createUserinFirestore(userCredential.user!);

      return AppUser(uid: userCredential.user!.uid, email: email);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<AppUser?> getCurrentUser() async {
    final currentUser = firebaseAuth.currentUser;

    if (currentUser == null) return null;

    return AppUser(uid: currentUser.uid, email: currentUser.email!);
  }

  @override
  Future<String> resetPasswordByEmail(String email) async {
    try {
      // Todo: add verify validation
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
  Future<AppUser?> signInWithGoogle() async {
    await _googleSignIn.initialize(serverClientId: clientId);
    try {
      final account = await _googleSignIn.authenticate();
      // ignore: unnecessary_null_comparison
      if (account == null) throw Exception('Login with Google is canceled');

      final auth = account.authentication;

      final credential = GoogleAuthProvider.credential(idToken: auth.idToken);

      final userCredential = await firebaseAuth.signInWithCredential(
        credential,
      );

      final user = userCredential.user;
      if (user == null) throw Exception('User not found');

      await createUserinFirestore(user);

      return AppUser(uid: user.uid, email: user.email ?? '');
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<AppUser> signInWithGitHub() async {
    try {
      GithubAuthProvider githubProvider = GithubAuthProvider();
      final firebaseUser = await FirebaseAuth.instance.signInWithProvider(
        githubProvider,
      );

      if (firebaseUser.user == null) throw Exception('GitHub sign-in failed');

      await createUserinFirestore(firebaseUser.user!);

      return AppUser(
        uid: firebaseUser.user!.uid,
        email: firebaseUser.user!.email!,
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // Create User in firestore
  Future createUserinFirestore(User user) async {
    try {
      final ref = firebaseFirestore.doc(user.uid);
      final doc = await ref.get();
      if (!doc.exists) {
        await ref.set({
          userRoleDocName: 'user',
          userNameDocName: user.displayName ?? 'Username',
          userEmailDocName: user.email,
          userLevelDocName: 0,
          userCreatedAtDocName: FieldValue.serverTimestamp(),
        });
      }
    } catch (e) {
      throw Exception('Field to create user');
    }
  }
}
