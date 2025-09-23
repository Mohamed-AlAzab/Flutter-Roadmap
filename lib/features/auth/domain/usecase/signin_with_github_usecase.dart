import 'package:flutter_roadmap/features/auth/domain/entity/user.dart';
import 'package:flutter_roadmap/features/auth/domain/repository/auth_repository.dart';

class SigninWithGithubUsecase {
  final AuthRepository authRepository;
  SigninWithGithubUsecase({required this.authRepository});

  Future<AppUser?> call() async {
    return await authRepository.signInWithGitHub();
  }
}
