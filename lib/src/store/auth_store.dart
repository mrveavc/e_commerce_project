// // import 'package:injectable/injectable.dart';
// // import 'package:mobx/mobx.dart';

// // part 'counter_store.g.dart';

// // @singleton
// // class CounterStore extends _CounterStore with _$CounterStore {}

// // abstract class _CounterStore with Store {
// //   @observable
// //   int count = 0;

// //   @observable
// //   ObservableList<String> isimler =
// //       ObservableList.of(['Ayse', 'Fatma', 'Hayriye']);

// //   @action
// //   void incCount() {
// //     count += 1;
// //   }

// //   @action
// //   void addToIsimler(String isim) {
// //     isimler.add(isim);
// //   }
// // }

// import 'package:e_commerce_project/src/di/injection.dart';
// import 'package:e_commerce_project/src/services/firebase_auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

part 'auth_store.g.dart';

@singleton
class AuthStore extends _AuthStore with _$AuthStore {}

abstract class _AuthStore with Store {
  //late final FirebaseAuthService _auth;

  @observable
  User? currentUSer;

  @observable
  bool isUserLoggedIn = false;
  // AuthStore() {
  //   //_auth = getIt<FirebaseAuthService>();
  // }

  @action
  void setCurrentUser(User? cUser, bool isLoggedIn) {
    if (cUser != null) {
      currentUSer = cUser;
      isUserLoggedIn = isLoggedIn;
    } else {
      currentUSer = null;
    }
  }
  // Future<User?> singIn(String email, String pass) async {
  //   this.CurrentUSer = await _auth.signInWithEmailAndPassword(email, pass);
  // }
}
