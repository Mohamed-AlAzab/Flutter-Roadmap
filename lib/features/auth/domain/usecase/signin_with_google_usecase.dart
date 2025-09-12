import 'package:flutter_roadmap/features/auth/domain/entity/user.dart';
import 'package:flutter_roadmap/features/auth/domain/repository/auth_repository.dart';

class SigninWithGoogleUsecase {
  final AuthRepository authRepository;
  SigninWithGoogleUsecase({required this.authRepository});

  Future<User?> call() async {
    return await authRepository.signInWithGoogle();
  }
}
