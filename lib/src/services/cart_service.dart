import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CartService {
  // final authStore = getIt.get<AuthStore>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> addCartData({name, category, price, image, rate, color}) {
    CollectionReference users =
        FirebaseFirestore.instance.collection('usersData');
    return users
        .doc(_auth.currentUser?.uid)
        .update(
          {
            'cart': FieldValue.arrayUnion([
              {
                'name': name,
                'category': category,
                'price': price,
                'image': image,
                'rate': rate,
                'color': color,
              },
            ])
          },
        )
        .then((value) => print("Cart Added"))
        .catchError((error) => print("Failed to add cart: $error"));
  }

  Future<void> removeCartData({name, category, price, image, rate, color}) {
    CollectionReference users =
        FirebaseFirestore.instance.collection('usersData');
    return users
        .doc(_auth.currentUser?.uid)
        .update(
          {
            'cart': FieldValue.arrayRemove([
              {
                'name': name,
                'category': category,
                'price': price,
                'image': image,
                'rate': rate,
                'color': color,
              },
            ])
          },
        )
        .then((value) => print("Cart remove"))
        .catchError((error) => print("Failed to cart fav: $error"));
  }
  // Future<void> addCartData({id, title, price, imageOne}) {
  //   CollectionReference users =
  //       FirebaseFirestore.instance.collection('usersData');
  //   return users
  //       .doc(_auth.currentUser?.uid)
  //       .update(
  //         {
  //           'cart': FieldValue.arrayUnion([
  //             {'id': id, 'title': title, 'price': price, 'imageOne': imageOne},
  //           ])
  //         },
  //       )
  //       .then((value) => print("Cart Added"))
  //       .catchError((error) => print("Failed to add cart: $error"));
  // }

  // Future<void> removeCartData({id, title, price, imageOne}) {
  //   CollectionReference users =
  //       FirebaseFirestore.instance.collection('usersData');
  //   return users
  //       .doc(_auth.currentUser?.uid)
  //       .update(
  //         {
  //           'cart': FieldValue.arrayRemove([
  //             {'id': id, 'title': title, 'price': price, 'imageOne': imageOne},
  //           ])
  //         },
  //       )
  //       .then((value) => print("Cart remove"))
  //       .catchError((error) => print("Failed to cart fav: $error"));
  // }
}
