import 'package:flutter_roadmap/features/auth/domain/repository/auth_repository.dart';

class LogoutUserUsecase {
  final AuthRepository authRepository;

  LogoutUserUsecase({required this.authRepository});

  Future<void> call() async {
    return await authRepository.logout();
  }
}
