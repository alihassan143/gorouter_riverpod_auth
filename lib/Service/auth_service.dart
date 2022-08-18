import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:testproject/Model/user_model.dart';
import 'package:testproject/Providers/Satates/user_states.dart';

final userCollection = FirebaseFirestore.instance.collection("User");
final auth = FirebaseAuth.instance;

class AuthService {
  Future<UserModel> login(
      {required String email, required String password}) async {
    try {
      UserCredential user = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      final DocumentSnapshot documentSnapshot =
          await userCollection.doc(user.user!.uid).get();
      return UserModel.fromJson(
          documentSnapshot.data() as Map<String, dynamic>);
    } catch (e) {
      log(e.toString());
      throw LoginStateError(e.toString());
    }
  }

  Future<UserModel> signUp(
      {required String email, required String password}) async {
    try {
      UserCredential user = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      UserModel userModel = UserModel(email: email, userid: user.user!.uid);
      await userCollection.doc(user.user!.uid).set(userModel.toJson());
      return userModel;
    } catch (e) {
      throw LoginStateError(e.toString());
    }
  }
}

final authServiceProvider = Provider<AuthService>((ref) => AuthService());
