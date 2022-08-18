import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:testproject/Providers/UserProvider/user_data_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final userData = ref.watch(userProvider);
    return Scaffold(
      body: Center(child: Text(userData!.email)),
    );
  }
}
