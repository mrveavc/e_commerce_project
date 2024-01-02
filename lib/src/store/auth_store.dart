import 'package:e_commerce_project/src/models/price_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

part 'auth_store.g.dart';

@singleton
class AuthStore extends _AuthStore with _$AuthStore {}

abstract class _AuthStore with Store {
  @observable
  User? currentUSer;

  @observable
  bool isUserLoggedIn = false;
  @observable
  double totalPrice = 0;

  @action
  void setTotalPrice(double price) {
    totalPrice = totalPrice + price;
  }

  @action
  void setCurrentUser(User? cUser, bool isLoggedIn) {
    if (cUser != null) {
      currentUSer = cUser;
      isUserLoggedIn = isLoggedIn;
    } else {
      currentUSer = null;
    }
  }
}


// // import 'package:e_commerce_project/src/di/injection.dart';
// // import 'package:e_commerce_project/src/services/firebase_auth_services.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:injectable/injectable.dart';
// import 'package:mobx/mobx.dart';

// part 'auth_store.g.dart';

// @singleton
// class AuthStore extends _AuthStore with _$AuthStore {}

// abstract class _AuthStore with Store {
//   //late final FirebaseAuthService _auth;

//   @observable
//   User? currentUSer;

//   @observable
//   bool isUserLoggedIn = false;
//   // AuthStore() {
//   //   //_auth = getIt<FirebaseAuthService>();
//   // }

//   @action
//   void setCurrentUser(User? cUser, bool isLoggedIn) {
//     if (cUser != null) {
//       currentUSer = cUser;
//       isUserLoggedIn = isLoggedIn;
//     } else {
//       currentUSer = null;
//     }
//   }
//   // Future<User?> singIn(String email, String pass) async {
//   //   this.CurrentUSer = await _auth.signInWithEmailAndPassword(email, pass);
//   // }
// }

