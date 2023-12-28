import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_project/src/di/injection.dart';
import 'package:e_commerce_project/src/store/auth_store.dart';
// import 'package:firebase_auth/firebase_auth.dart';

class CartService {
  final authStore = getIt.get<AuthStore>();

  Future<void> addCartData({name, code}) {
    CollectionReference users =
        FirebaseFirestore.instance.collection('usersData');

    // Call the user's CollectionReference to add a new user
    return users
        .doc(authStore.currentUSer!.uid)
        .update(
          {
            // 'cart': FieldValue.arrayUnion([name, code]),
            'cart': FieldValue.arrayUnion([
              {'name': name, 'code': code},
            ])
          },
        )
        .then((value) => print("Cart Added"))
        .catchError((error) => print("Failed to add cart: $error"));
  }
}
