import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:login_register_app/utils/extensions.dart';

import '../pages/homepage.dart';
import '../values/app_routes.dart';
import 'AuthExceptionHandler.dart';


class AuthService {
  final userCollection = FirebaseFirestore.instance.collection("users");
  final firebaseAuth = FirebaseAuth.instance;

  Future<void> signUp({required String name, required String username, required String email, required String password}) async{
    try {
      final UserCredential userCredential = await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null )  {
        _registerUser(name: name, email: email, password: password, username: username);
      }
    } on FirebaseAuthException catch(e) {
      Fluttertoast.showToast(msg: e.message!);
    }
  }
  late AuthStatus _status;
  Future<void> signIn(BuildContext context,{required String email, required String password}) async{
    try {
      final UserCredential userCredential = await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null )  {
        Navigator.push(context,MaterialPageRoute(builder: (context) => const HomePage()),);
      }
    } on FirebaseAuthException catch(e) {
      if(e.code=="wrong-password"){
        Fluttertoast.showToast(msg: 'Şifre Yanlış');
      }
    }
  }

  Future<void> signOut() async {
    await firebaseAuth.signOut().then((_){
      if(firebaseAuth.currentUser == null)
      {
        AppRoutes.loginScreen.pushName();
      }
    });
  }

  Future<void> _registerUser({required String name, required String username, required String email, required String password}) async{
    await userCollection.doc(
      firebaseAuth.currentUser?.uid.toString()
    ).set({
      "email":email,
      "name":name,
      "username":username,


    });

  }
  Future<AuthStatus> resetPassword({required String email}) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
      _status = AuthStatus.successful;
    } catch (e) {
      if (e is FirebaseAuthException) {
        _status = AuthExceptionHandler.handleAuthException(e) as AuthStatus;
      } else {
        // FirebaseAuthException türünden farklı bir hata varsa, uygun şekilde ele alabilirsiniz.
        print("Beklenmeyen bir hata oluştu: $e");
        _status = AuthStatus.unknown;
      }
    }
    return _status;
  }

}