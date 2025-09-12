import 'package:flutter_roadmap/features/auth/domain/repository/auth_repository.dart';

class DeleteAccountUsecase {
  final AuthRepository authRepository;

  DeleteAccountUsecase({required this.authRepository});

  Future<void> call() async {
    return await authRepository.deleteAccount();
  }
}