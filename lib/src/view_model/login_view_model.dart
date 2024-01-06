// import 'package:auto_route/auto_route.dart';
// import 'package:e_commerce_project/src/common/toast.dart';
// import 'package:e_commerce_project/src/services/firebase_auth_services.dart';
// import 'package:e_commerce_project/src/ui/view/pages/home_page.dart';
// import 'package:e_commerce_project/src/utils/navigation/router/app_router.dart';
// import 'package:e_commerce_project/src/view_model/product_view_model.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class LoginViewModel with ChangeNotifier {
//   // final FirebaseAuthService _auth = FirebaseAuthService();

//   void signIn(BuildContext context, String email, String password) async {
//     final _auth = Provider.of<FirebaseAuthService>(context);

//     try {
//       User? user = await _auth.signInWithEmailAndPassword(
//         email,
//         password,
//       );
//       if (user != null) {
//         showToast(message: "User is successfully signed in");
//         context.router.replace(const ProfilRoute());
//       } else {
//         showToast(message: "Login user null");
//       }
//       _openMainPage(context);
//     } on FirebaseAuthException catch (e) {
//       print(e.message);
//     }
//   }

//   void _openMainPage(BuildContext context) {
//     MaterialPageRoute pageRoute = MaterialPageRoute(
//       builder: (context) => ChangeNotifierProvider(
//         create: (context) => ProductViewModel(),
//         child: HomePage(),
//       ),
//     );
//     Navigator.pushReplacement(context, pageRoute);
//   }

//   // void openRegisterPage(BuildContext context) {
//   //   MaterialPageRoute pageRoute = MaterialPageRoute(
//   //     builder: (context) => ChangeNotifierProvider(
//   //       create: (context) => RegisterViewModel(),
//   //       child: RegisterPage(),
//   //     ),
//   //   );
//   //   Navigator.pushReplacement(context, pageRoute);
//   // }

//   // void _openMainPage(BuildContext context) {
//   //   MaterialPageRoute pageRoute = MaterialPageRoute(
//   //     builder: (context) => ChangeNotifierProvider(
//   //       create: (context) => MainViewModel(),
//   //       child: MainPage(),
//   //     ),
//   //   );
//   //   Navigator.pushReplacement(context, pageRoute);
//   // }
// }
