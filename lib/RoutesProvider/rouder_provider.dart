import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:testproject/Home%20Screen/home_screen.dart';
import 'package:testproject/Model/user_model.dart';
import 'package:testproject/Providers/UserProvider/user_data_provider.dart';
import 'package:testproject/Screens/login_screen.dart';
import 'package:testproject/Screens/sign_up.dart';
import 'package:testproject/Service/auth_service.dart';

import '../Providers/Satates/user_states.dart';
import '../Providers/UserProvider/user_state_provider.dart';

class MyRoutes extends ChangeNotifier {
  final Ref ref;
  MyRoutes(this.ref) {
    ref.listen<LoginState>(
        userStateprovider, (previous, next) => notifyListeners());
  }

  List<GoRoute> get _routes => [
        GoRoute(
          name: "Login",
          path: "/login",
          builder: (context, state) => SigninPage(),
        ),
        GoRoute(
          name: "Home",
          path: "/home",
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          name: "Signup",
          path: "/signup",
          builder: (context, state) => const SignUpScreen(),
        ),
      ];

  String? _redirectLogic(GoRouterState state) {
    final loginState = ref.read(userStateprovider);
    final user = ref.read(userProvider.state);
    if (loginState is LoginStateInitial && auth.currentUser != null) {
      log("message");
      Future.delayed(const Duration(seconds: 0), () {
        user.state = UserModel(
            email: auth.currentUser!.email!, userid: auth.currentUser!.uid);
        ref.read(userStateprovider.notifier).newstate = LoginStateSuccess(
            UserModel(
                email: auth.currentUser!.email!,
                userid: auth.currentUser!.uid));
      });
    }
    log(state.location);
    log(auth.currentUser.toString());
    final areWeLoggingIn = state.location == '/home';
    log(areWeLoggingIn.toString());
    if (areWeLoggingIn) {
      return loginState is LoginStateSuccess ? null : "/login";
    }

    return null;
  }
}

final routeProvider = Provider<GoRouter>((ref) {
  final routeRef = MyRoutes(ref);
  return GoRouter(
      urlPathStrategy: UrlPathStrategy.path,
      initialLocation: "/login",
      refreshListenable: routeRef,
      redirect: routeRef._redirectLogic,
      routes: routeRef._routes);
});
