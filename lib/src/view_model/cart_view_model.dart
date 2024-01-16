import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_project/src/common/toast.dart';
import 'package:e_commerce_project/src/models/product.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CartViewModel with ChangeNotifier {
  double totalPrice = 0;
  void setTotalPrice(List<Map<String, dynamic>> carts) {
    totalPrice = 0;

    for (Map<String, dynamic> cartItem in carts) {
      totalPrice += (cartItem['price'] * cartItem['quantityInCart']);
    }
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final List<Product> _allProductsInCart = [];
  List<Product> get products => _allProductsInCart;

  String? selectedValue = "";
  void selectedSize(String? value) {
    selectedValue = value;
  }

  CartViewModel() {
    WidgetsBinding.instance.addPostFrameCallback(
        (timeStamp) async => await getAllProductsInCart());
  }

  final CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('usersData');

  Future<List<Product>> getAllProductsInCart() async {
    QuerySnapshot querySnapshot = await _collectionRef.get();
    final allProducts = querySnapshot.docs
        .where((element) => element.id == _auth.currentUser?.uid)
        .map((doc) => doc.data())
        .toList();

    if (allProducts.isNotEmpty) {
      if ((allProducts[0] as Map<String, dynamic>)["cart"] != null) {
        _allProductsInCart.clear();
        for (var map in (allProducts[0] as Map<String, dynamic>)["cart"]) {
          _allProductsInCart.add(Product.fromCartMap(
              _auth.currentUser?.uid, (map as Map<String, dynamic>)));
        }

        return _allProductsInCart;
      }
    }

    notifyListeners();

    return [];
  }

  Future<void> addProductToCart(
      {name, category, price, image, rate, color, size, quantityInCart}) async {
    await getAllProductsInCart();
    CollectionReference users =
        FirebaseFirestore.instance.collection('usersData');
    size = selectedValue;

    if (products.isNotEmpty) {
      for (Product product in products) {
        if (product.name == name && product.size["singleSize"] == size) {
          await users
              .doc(_auth.currentUser?.uid)
              .update({
                'cart': FieldValue.arrayRemove([
                  {
                    'name': name,
                    'category': category,
                    'price': price,
                    'image': image,
                    'rate': rate,
                    'color': color,
                    'size': {"singleSize": size},
                    'quantityInCart': product.quantityInCart
                  },
                ])
              })
              .then((value) => print("Sepete Eklendi"))
              .catchError((error) => print("Sepete Eklenemedi: $error"));
          showToast(message: "Sepete Eklendi");

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
                    'size': {"singleSize": size},
                    'quantityInCart': product.quantityInCart + 1
                  },
                ])
              })
              .then((value) => print("Sepete Eklendi"))
              .catchError((error) => print("Sepete Eklenemedi: $error"));
          showToast(message: "Sepete Eklendi");

          return;
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
                      'size': {"singleSize": size},
                      'quantityInCart': quantityInCart
                    },
                  ])
                },
              )
              .then((value) => print("Sepete Eklendi"))
              .catchError((error) => print("Sepete Eklenemedi:: $error"));
          showToast(message: "Sepete Eklendi");
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
                  'size': {"singleSize": size},
                  'quantityInCart': quantityInCart
                },
              ])
            },
          )
          .then((value) => print("Sepete Eklendi"))
          .catchError((error) => print("Sepete Eklenemedi:  $error"));
    }
  }

  Future<void> removeProductFromCart(Product product) {
    CollectionReference users =
        FirebaseFirestore.instance.collection('usersData');
    return users
        .doc(_auth.currentUser?.uid)
        .update(
          {
            'cart': FieldValue.arrayRemove([
              {
                'name': product.name,
                'category': product.category,
                'price': product.price,
                'image': product.image,
                'rate': product.rate,
                'color': product.color,
                'size': product.size,
                'quantityInCart': product.quantityInCart
              },
            ])
          },
        )
        .then((value) => print("Cart remove"))
        .catchError((error) => print("Failed to cart fav: $error"));
  }
}
