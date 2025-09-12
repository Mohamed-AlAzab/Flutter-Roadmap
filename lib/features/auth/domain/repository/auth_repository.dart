import 'package:flutter_roadmap/features/auth/domain/entity/user.dart';

abstract class AuthRepository {
  Future<User?> loginWithEmailAndPassword(String email, String password);

  Future<User?> registerWithEmailAndPassword(
    String name,
    String email,
    String password,
  );

  Future<User?> getCurrentUser();

  Future<String> resetPasswordByEmail(String email);

  Future<void> logout();

  Future<void> deleteAccount();

  Future<User?> signInWithGoogle();

  Future<User> signInWithGitHub();
}
