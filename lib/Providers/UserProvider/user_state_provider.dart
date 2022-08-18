import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:testproject/Model/user_model.dart';
import 'package:testproject/Providers/UserProvider/user_data_provider.dart';
import 'package:testproject/Repository/auth_repository.dart';
import '../Satates/user_states.dart';

final userStateprovider =
    StateNotifierProvider<UserCurrentState, LoginState>((ref) {
  final userdata = ref.watch(userProvider);

  return UserCurrentState(
      ref: ref,
      newstate: userdata != null
          ? LoginStateSuccess(userdata)
          : const LoginStateInitial());
});

class UserCurrentState extends StateNotifier<LoginState> {
  UserCurrentState({required this.ref, required this.newstate})
      : super(newstate);
  final Ref ref;

  LoginState newstate;
  Future<void> login(String email, String password) async {
    state = const LoginStateLoading();

    try {
      UserModel userdata = await ref
          .read(authrepositoryProvider)
          .login(email: email, password: password);

      final userDataProvider = ref.read(userProvider.state);
      state = LoginStateSuccess(userdata);
      userDataProvider.state = userdata;

    } catch (e) {
      log(e.toString());
      state = LoginStateError(e.toString());
      throw LoginStateError(e.toString());
    }
  }

  Future<void> signUp(String email, String password) async {
    state = const LoginStateLoading();

    try {
      UserModel userdata = await ref
          .read(authrepositoryProvider)
          .signUp(email: email, password: password);
      state = LoginStateSuccess(userdata);
      final userDataProvider = ref.read(userProvider.state);
      state = LoginStateSuccess(userdata);
      userDataProvider.state = userdata;
 
    } catch (e) {
      log(e.toString());
      state = LoginStateError(e.toString());
      throw LoginStateError(e.toString());
    }
  }
}
