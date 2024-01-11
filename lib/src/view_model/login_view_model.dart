import 'package:auto_route/auto_route.dart';
import 'package:e_commerce_project/src/common/toast.dart';
import 'package:e_commerce_project/src/services/firebase_auth_services.dart';
import 'package:e_commerce_project/src/utils/navigation/router/app_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginViewModel with ChangeNotifier {
  final FirebaseAuthService _auth = FirebaseAuthService();

  void signIn(BuildContext context, String email, String password) async {
    try {
      User? user = await _auth.signInWithEmailAndPassword(
        email,
        password,
      );
      if (user != null) {
        showToast(message: "Giriş Yapıldı");
        context.router.replace(const ProfilRoute());
      } else {
        showToast(message: "Email veya parolanızı lütfen kontrol ediniz.");
      }
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
  }
}
