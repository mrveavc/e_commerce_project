import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_project/src/di/injection.dart';
import 'package:e_commerce_project/src/store/auth_store.dart';

class CartService {
  final authStore = getIt.get<AuthStore>();

  Future<void> addCartData({id, title, price, imageOne}) {
    CollectionReference users =
        FirebaseFirestore.instance.collection('usersData');
    return users
        .doc(authStore.currentUSer!.uid)
        .update(
          {
            'cart': FieldValue.arrayUnion([
              {'id': id, 'title': title, 'price': price, 'imageOne': imageOne},
            ])
          },
        )
        .then((value) => print("Cart Added"))
        .catchError((error) => print("Failed to add cart: $error"));
  }

  Future<void> removeCartData({id, title, price, imageOne}) {
    CollectionReference users =
        FirebaseFirestore.instance.collection('usersData');
    return users
        .doc(authStore.currentUSer!.uid)
        .update(
          {
            'cart': FieldValue.arrayRemove([
              {'id': id, 'title': title, 'price': price, 'imageOne': imageOne},
            ])
          },
        )
        .then((value) => print("Cart remove"))
        .catchError((error) => print("Failed to cart fav: $error"));
  }
}
