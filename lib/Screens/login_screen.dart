import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../Providers/UserProvider/user_state_provider.dart';

class SigninPage extends ConsumerStatefulWidget {
  @override
  ConsumerState<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends ConsumerState<SigninPage> {
  final TextEditingController _etEmail = TextEditingController();
  final TextEditingController _etPassword = TextEditingController();
  bool _obscureText = true;
  IconData _iconVisible = Icons.visibility_off;
  String? token;
  bool state = false;
  final _formKey = GlobalKey<FormState>();

  final kPrimaryColor = Colors.blue;

  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
      if (_obscureText == true) {
        _iconVisible = Icons.visibility_off;
      } else {
        _iconVisible = Icons.visibility;
      }
    });
  }

  @override
  void dispose() {
    _etEmail.dispose();
    _etPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(30, 120, 30, 30),
        children: <Widget>[
          // Center(
          //     child: SizedBox(
          //         width: 100,
          //         height: 90,
          //         child: Image.asset(
          //           'assets/appicon/CHATAPP.gif',
          //           fit: BoxFit.fill,
          //         ))),
          const SizedBox(
            height: 40,
          ),
          const Text(
            'Sign In',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 30,
                color: Colors.black,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5),
          ),
          const SizedBox(
            height: 45,
          ),
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            controller: _etEmail,
            style: const TextStyle(color: Colors.black),
            validator: (value) {
              if (value == null && value!.contains("@") == false) {
                return 'Please Enter Correct Email';
              }
              return null;
            },
            onChanged: (textValue) {
              setState(() {});
            },
            decoration: InputDecoration(
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: kPrimaryColor, width: 2.0)),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFCCCCCC)),
              ),
              labelText: 'Email',
              labelStyle: const TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please Enter Your Password';
              }
              return null;
            },
            controller: _etPassword,
            obscureText: _obscureText,
            style: const TextStyle(color: Colors.black),
            decoration: InputDecoration(
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: kPrimaryColor, width: 2.0)),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFCCCCCC)),
              ),
              labelText: 'Password',
              labelStyle: const TextStyle(
                color: Colors.black,
              ),
              suffixIcon: IconButton(
                  icon: Icon(_iconVisible, color: Colors.grey[400], size: 20),
                  onPressed: () {
                    _toggleObscureText();
                  }),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Align(
              alignment: Alignment.centerRight,
              child: Container(
                child: GestureDetector(
                  onTap: () {},
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(color: Colors.blue, fontSize: 15),
                  ),
                ),
              )),
          const SizedBox(
            height: 40,
          ),
          Container(
            child: TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) => Colors.blue,
                  ),
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3.0),
                  )),
                ),
                onPressed: () async {
                  try {
                    
                    log("message");
                    await ref
                        .read(userStateprovider.notifier)
                        .login(_etEmail.text.trim(), _etPassword.text.trim());
                    GoRouter.of(context).goNamed("Home");
                  } catch (e) {}
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.0),
                  child: Text(
                    'Login',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                )),
          ),
          const SizedBox(
            height: 40,
          ),

          // Container(
          //   margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //     children: <Widget>[
          //       GestureDetector(
          //         onTap: () {},
          //         child: const Image(
          //           image: AssetImage("assets/images/google.png"),
          //           width: 40,
          //         ),
          //       ),
          //       GestureDetector(
          //         onTap: () {},
          //         child: const Image(
          //           image: AssetImage("assets/images/facebook.png"),
          //           width: 40,
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: GestureDetector(
              onTap: () {
                log("message");
                context.go("/signup");
                FocusScope.of(context).unfocus();
              },
              child: Wrap(
                children: [
                  const Text(
                    'No account yet? ',
                    style: TextStyle(fontSize: 15),
                  ),
                  Text(
                    'Create one',
                    style: TextStyle(fontSize: 15, color: kPrimaryColor),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    ));
  }
}
