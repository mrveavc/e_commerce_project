import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_project/src/models/product.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CartService with ChangeNotifier {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // final authStore = getIt.get<AuthStore>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  List<Product> _products = [];
  List<Product> get products => _products;

  String? selectedValue = "";
  void selectedSize(String? value) {
    selectedValue = value;
  }

  CartService() {
    WidgetsBinding.instance
        .addPostFrameCallback((timeStamp) async => await _getAllProducts());
  }

  final CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('usersData');

  Future<void> _getAllProducts() async {
    QuerySnapshot querySnapshot = await _collectionRef.get();
    final allProducts = querySnapshot.docs
        .where((element) => element.id == _auth.currentUser?.uid)
        .map((doc) => doc.data())
        .toList();

    if (allProducts.isNotEmpty) {
      _products.clear();
      for (var map in (allProducts[0] as Map<String, dynamic>)["cart"]) {
        _products.add(Product.fromCartMap(
            _auth.currentUser?.uid, (map as Map<String, dynamic>)));
      }
    }

    notifyListeners();
  }

  Future<void> addCartData(
      {name, category, price, image, rate, color, size, quantityInCart}) async {
    await _getAllProducts();
    CollectionReference users =
        FirebaseFirestore.instance.collection('usersData');
    size = selectedValue;
    if (products.isNotEmpty) {
      for (Product product in products) {
        if (product.name == name && product.size["singleSize"] == size) {
          // int newQuantityInCart = quantityInCart + 1
          //;
          print("!!!! quantityInCart: " + product.quantityInCart.toString());
          await users.doc(_auth.currentUser?.uid).update({
            'cart': FieldValue.arrayRemove([
              {
                'name': name,
                'category': category,
                'price': price,
                'image': image,
                'rate': rate,
                'color': color,
                'size': size,
                'quantityInCart': product.quantityInCart
              },
            ])
          });
          await users
              .doc(_auth.currentUser?.uid)
              .update({
                'cart': FieldValue.arrayUnion([
                  {
                    'name': name,
                    'category': category,
                    'price': price,
                    'image': image,
                    'rate': rate,
                    'color': color,
                    'size': size,
                    'quantityInCart': product.quantityInCart + 1
                  },
                ])
              })
              .then((value) => print("Cart Added"))
              .catchError((error) => print("Failed to add cart: $error"));
        } else {
          await users
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
                      'size': size,
                      'quantityInCart': quantityInCart
                    },
                  ])
                },
              )
              .then((value) => print("Cart Added"))
              .catchError((error) => print("Failed to add cart: $error"));
        }
      }
    } else {
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
                  'size': size,
                  'quantityInCart': quantityInCart
                },
              ])
            },
          )
          .then((value) => print("Cart Added"))
          .catchError((error) => print("Failed to add cart: $error"));
    }
  }

  Future<void> removeCartData(
      {name, category, price, image, rate, color, size, quantityInCart}) {
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
                'size': size,
                'quantityInCart': quantityInCart
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
