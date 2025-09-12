import 'package:flutter_roadmap/features/auth/domain/repository/auth_repository.dart';

class ResetPasswordByEmailUsecase {
  final AuthRepository authRepository;

  ResetPasswordByEmailUsecase({required this.authRepository});

  Future<String> call(String email) async {
    return await authRepository.resetPasswordByEmail(email);
  }
}
