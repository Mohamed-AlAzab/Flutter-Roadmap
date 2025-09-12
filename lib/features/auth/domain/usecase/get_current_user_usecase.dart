import 'package:flutter_roadmap/features/auth/domain/entity/user.dart';
import 'package:flutter_roadmap/features/auth/domain/repository/auth_repository.dart';

class GetCurrentUserUsecase {
  final AuthRepository authRepository;

  GetCurrentUserUsecase({required this.authRepository});

  Future<User?> call() async {
    return authRepository.getCurrentUser();
  }
}
