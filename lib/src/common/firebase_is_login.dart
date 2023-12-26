// import 'package:e_commerce_project/src/common/toast.dart';
// import 'package:e_commerce_project/src/services/firebase_auth_services.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// void signIn() async {
//   final FirebaseAuthService auth = FirebaseAuthService();
//   TextEditingController _emailController = TextEditingController();
//   TextEditingController _passwordController = TextEditingController();

//   bool isSigning = true;
//   print(" giirş yapıldı mı ?   $isSigning ");
//   String email = _emailController.text;
//   String password = _passwordController.text;

//   User? user = await auth.signInWithEmailAndPassword(email, password);
//   print("kullanıcı :  ${user?.email}");

//   // isSigning = false;
//   if (user != null) {
//     showToast(message: "User is successfully signed in");

//     // context.router.replace(const HomeRoute());
//   } else {
//     showToast(message: "some error occured");
//   }
//   print(" giirş yapıldı mı ?   $isSigning ");
//   print("kullanıcı :  ${user?.email}");
// }
