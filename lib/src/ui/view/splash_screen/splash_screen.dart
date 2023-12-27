import 'package:auto_route/auto_route.dart';
import 'package:e_commerce_project/src/ui/view/pages/login_page.dart';
import 'package:e_commerce_project/src/utils/navigation/router/app_router.dart';
import 'package:flutter/material.dart';

@RoutePage()
class SplashScreen extends StatefulWidget {
  final Widget? child;
  const SplashScreen({super.key, this.child});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      context.router.replace(const LoginRoute());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Image(
          image: AssetImage('assets/images/logo.png'),
        ),
        // child: Text(
        //   "Welcome To Flutter Firebase",
        //   style: TextStyle(
        //     color: Colors.blue,
        //     fontWeight: FontWeight.bold,
        //   ),
        // ),
      ),
    );
  }
}
