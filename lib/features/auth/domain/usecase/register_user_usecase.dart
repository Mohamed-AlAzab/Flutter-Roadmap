import 'package:flutter_roadmap/features/auth/domain/entity/user.dart';
import 'package:flutter_roadmap/features/auth/domain/repository/auth_repository.dart';

class RegisterUserUsecase {
  final AuthRepository authRepository;

  RegisterUserUsecase({required this.authRepository});

  Future<AppUser?> call(String name, String email, String password) async {
    return authRepository.registerWithEmailAndPassword(name, email, password);
  }
}
