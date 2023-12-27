import 'package:e_commerce_project/src/di/injection.dart';
import 'package:e_commerce_project/src/store/auth_store.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import '../common/toast.dart';

@module
abstract class IAuthService {}

@Injectable(as: IAuthService)
class FirebaseAuthService implements IAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final AuthStore _authStore = getIt.get<AuthStore>();

  Future<User?> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        showToast(message: 'The email address is already in use.');
      } else {
        showToast(message: 'An error occurred: ${e.code}');
      }
    }
    return null;
  }

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      // Kullanıcı login olduktan sonra currentUser ve isUserLoggedIn değişkenleri doldurulacaktır.
      _authStore.setCurrentUser(credential.user, true);

      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        showToast(message: 'Invalid email or password.');
      } else {
        showToast(message: 'An error occurred: ${e.code}');
      }
    }
    return null;
  }
}



// import 'package:e_commerce_project/src/di/injection.dart';
// import 'package:e_commerce_project/src/store/auth_store.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:injectable/injectable.dart';
// import 'package:mobx/mobx.dart';

// import '../common/toast.dart';
// // part 'firebase_auth_services.g.dart';

// // @singleton
// // class FirebaseAuthService extends _FirebaseAuthService
// //     with _$FirebaseAuthService {}
// // with Store
// class FirebaseAuthService {
//   FirebaseAuth _auth = FirebaseAuth.instance;

//   AuthStore _authStore = getIt.get<AuthStore>();

//   Future<User?> signUpWithEmailAndPassword(
//       String email, String password) async {
//     try {
//       UserCredential credential = await _auth.createUserWithEmailAndPassword(
//           email: email, password: password);

//       return credential.user;
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'email-already-in-use') {
//         showToast(message: 'The email address is already in use.');
//       } else {
//         showToast(message: 'An error occurred: ${e.code}');
//       }
//     }
//     return null;
//   }

//   Future<User?> signInWithEmailAndPassword(
//       String email, String password) async {
//     try {
//       UserCredential credential = await _auth.signInWithEmailAndPassword(
//           email: email, password: password);

//       // Kullanıcı login olduktan sonra currentUser ve isUserLoggedIn değişkenleri doldurulacaktır.
//       _authStore.setCurrentUser(credential.user, true);

//       return credential.user;
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'user-not-found' || e.code == 'wrong-password') {
//         showToast(message: 'Invalid email or password.');
//       } else {
//         showToast(message: 'An error occurred: ${e.code}');
//       }
//     }
//     return null;
//   }
// }
