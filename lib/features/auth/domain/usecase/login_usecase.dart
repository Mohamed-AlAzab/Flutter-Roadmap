import 'package:flutter_roadmap/features/auth/domain/entity/user.dart';
import 'package:flutter_roadmap/features/auth/domain/repository/auth_repository.dart';

class LoginUserUsecase {
  final AuthRepository authRepository;

  LoginUserUsecase({required this.authRepository});

  Future<User?> call(String email, String password) async {
    return await authRepository.loginWithEmailAndPassword(email, password);
  }
}
