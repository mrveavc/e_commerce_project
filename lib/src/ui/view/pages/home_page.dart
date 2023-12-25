import 'package:auto_route/auto_route.dart';
import 'package:e_commerce_project/src/ui/view/pages/sign_up_page.dart';
import 'package:e_commerce_project/src/common/toast.dart';
import 'package:e_commerce_project/src/utils/navigation/router/app_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SignUpPage sgn = SignUpPage();
  // SignUpPage sgn = const SignUpPage();

  @override
  Widget build(BuildContext context) {
    // final arguments = (ModalRoute.of(context)?.settings.arguments ??
    //     <String, dynamic>{}) as Map;
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text("HomePage"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Center(
                child: Text(
              "Welcome Home buddy !",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
            )),
            const SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {
                FirebaseAuth.instance.signOut();
                context.router.replace(const LoginRoute());
                // Navigator.pushNamed(context, "/login");
                showToast(message: "Successfully signed out");
              },
              child: Container(
                height: 45,
                width: 100,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10)),
                child: const Center(
                  child: Text(
                    "Sign out",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
