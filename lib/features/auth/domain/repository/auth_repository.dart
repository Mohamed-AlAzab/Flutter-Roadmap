import 'package:flutter_roadmap/features/auth/domain/entity/user.dart';

abstract class AuthRepository {
  Future<AppUser?> loginWithEmailAndPassword(String email, String password);

  Future<AppUser?> registerWithEmailAndPassword(
    String name,
    String email,
    String password,
  );

  Future<AppUser?> getCurrentUser();

  Future<String> resetPasswordByEmail(String email);

  Future<void> logout();

  Future<void> deleteAccount();

  Future<AppUser?> signInWithGoogle();

  Future<AppUser> signInWithGitHub();
}
