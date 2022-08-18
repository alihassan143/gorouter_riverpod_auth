import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:testproject/Model/user_model.dart';
import 'package:testproject/Service/auth_service.dart';

class AuthRepository {
  AuthService authService;
  AuthRepository({
    required this.authService,
  });
  Future<UserModel> login(
      {required String email, required String password}) async {
    return await authService.login(email: email, password: password);
  }

  Future<UserModel> signUp(
      {required String email, required String password}) async {
    return await authService.signUp(email: email, password: password);
  }
}

final authrepositoryProvider = Provider<AuthRepository>((ref) {
  final reference = ref.watch(authServiceProvider);
  return AuthRepository(authService: reference);
});
