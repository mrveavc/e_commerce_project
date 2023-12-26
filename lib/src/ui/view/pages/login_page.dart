import 'package:auto_route/auto_route.dart';
import 'package:e_commerce_project/src/di/injection.dart';
import 'package:e_commerce_project/src/provider/user_provider.dart';
import 'package:e_commerce_project/src/services/add_user.dart';
import 'package:e_commerce_project/src/services/firebase_auth_services.dart';
import 'package:e_commerce_project/src/store/auth_store.dart';
import 'package:e_commerce_project/src/ui/widgets/form_container_widget.dart';
import 'package:e_commerce_project/src/common/toast.dart';
import 'package:e_commerce_project/src/utils/navigation/router/app_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';

@RoutePage()
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // bool _isSigning = false;
  final authStore = getIt.get<AuthStore>();
  // final _auth = getIt.get<FirebaseAuthService>();
  final FirebaseAuthService _auth = FirebaseAuthService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  // @override
  // void dispose() {
  //   _emailController.dispose();
  //   _passwordController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 50),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Login",
                style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 30,
              ),
              FormContainerWidget(
                controller: _emailController,
                hintText: "Email",
                isPasswordField: false,
              ),
              const SizedBox(
                height: 30,
              ),
              FormContainerWidget(
                controller: _passwordController,
                hintText: "Password",
                isPasswordField: true,
              ),
              const SizedBox(
                height: 50,
              ),
              GestureDetector(
                onTap: () {
                  _signIn();
                },
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: authStore.isUserLoggedIn
                        // _isSigning
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : const Text(
                            "Login",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  _signInWithGoogle();
                },
                child: Container(
                  width: double.infinity,
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black, width: 1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.save, //google icon
                          color: Colors.black,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Sign in with Google",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account?"),
                  const SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      context.router.replace(const SignUpRoute());
                      // Navigator.pushAndRemoveUntil(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => SignUpPage()),
                      //   (route) => false,
                      // );
                    },
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        )),
      ),
    );
  }

  void _signIn() async {
    // setState(() {
    //   _isSigning = true;
    // });

    // print(" giirş yapıldı mı ?   $_isSigning ");
    String email = _emailController.text;
    String password = _passwordController.text;

    User? user = await _auth.signInWithEmailAndPassword(email, password);
    // print("login_page");
    // print("user : $user");
    // print("user : ${user?.email}");
    AddUser addUser = AddUser();

    await addUser.addUserData(currentUser: user, userEmail: user?.email);

    // userProvider?.addUserData(currentUser: user, userEmail: user?.email);
    // userProvider.addUserData(
    //   // currentUser: user!.email,
    //   // userName: user.email,
    //   userEmail: user.email,
    //   // userImage: user.photoURL,
    //   currentUser: user,
    // );

    // setState(() {
    //   _isSigning = false;
    // });

    if (user != null) {
      showToast(message: "User is successfully signed in");
      context.router.replace(const HomeRoute());
      // Navigator.pushNamed(context, "/home", arguments: {'email': email});
    } else {
      showToast(message: "some error occured");
    }
    // print(" giirş yapildi mi ?   $_isSigning ");
    // print("kullanici :  ${user?.email}");
  }

  _signInWithGoogle() async {
    final GoogleSignIn _googleSignIn = GoogleSignIn();

    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken,
        );

        await _firebaseAuth.signInWithCredential(credential);
        // Navigator.pushNamed(context, "/home");
        context.router.replace(const HomeRoute());
      }
    } catch (e) {
      showToast(message: "some error occured $e");
    }
  }
}
