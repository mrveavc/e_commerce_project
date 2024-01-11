import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_project/src/models/product.dart';
import 'package:e_commerce_project/src/services/cart_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OrderService with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  List<Product> _products = [];
  List<Product> get products => _products;
  CartService cart = CartService();
  String? selectedValue = "";
  void selectedSize(String? value) {
    selectedValue = value;
  }

  OrderService() {
    WidgetsBinding.instance
        .addPostFrameCallback((timeStamp) async => await _getAllProducts());
    // .addPostFrameCallback((timeStamp) async => await addOrderData());
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
      if ((allProducts[0] as Map<String, dynamic>)["cart"] != null) {
        _products.clear();
        for (var map in (allProducts[0] as Map<String, dynamic>)["cart"]) {
          _products.add(Product.fromCartMap(
              _auth.currentUser?.uid, (map as Map<String, dynamic>)));
        }
      }
    }
    notifyListeners();
  }

  // Future<void> addOrderData({
  //   name,
  //   category,
  //   price,
  //   image,
  //   rate,
  //   color,
  //   isFav,
  //   size,
  //   quantityInCart,
  // }) async {
  //   CollectionReference users =
  //       FirebaseFirestore.instance.collection('usersData');
  //   DocumentReference userDocRef = users.doc(_auth.currentUser?.uid);
  //   CollectionReference ordersCollection = userDocRef.collection('order');
  //   return ordersCollection.doc('order1').update(
  //     {
  //       'name': name,
  //       'category': category,
  //       'price': price,
  //       'image': image,
  //       'color': color,
  //       'rate': rate,
  //     },
  //     // {
  //     //   'order': FieldValue.arrayUnion([
  //     //     {
  //     //       'name': name,
  //     //       'category': category,
  //     //       'price': price,
  //     //       'image': image,
  //     //       'color': color,
  //     //       'rate': rate,
  //     //     }
  //     //   ])
  //     // },
  //   );
  // }
}




// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:e_commerce_project/src/models/product.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class OrderService with ChangeNotifier {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   List<Product> _products = [];
//   List<Product> get products => _products;

//   String? selectedValue = "";
//   void selectedSize(String? value) {
//     selectedValue = value;
//   }

//   OrderService() {
//     WidgetsBinding.instance
//         .addPostFrameCallback((timeStamp) async => await _getAllProducts());
//     // .addPostFrameCallback((timeStamp) async => await addOrderData());
//   }

//   final CollectionReference _collectionRef =
//       FirebaseFirestore.instance.collection('usersData');

//   Future<void> _getAllProducts() async {
//     QuerySnapshot querySnapshot = await _collectionRef.get();
//     final allProducts = querySnapshot.docs
//         .where((element) => element.id == _auth.currentUser?.uid)
//         .map((doc) => doc.data())
//         .toList();

//     if (allProducts.isNotEmpty) {
//       if ((allProducts[0] as Map<String, dynamic>)["cart"] != null) {
//         _products.clear();
//         for (var map in (allProducts[0] as Map<String, dynamic>)["cart"]) {
//           _products.add(Product.fromCartMap(
//               _auth.currentUser?.uid, (map as Map<String, dynamic>)));
//         }
//       }
//     }
//     notifyListeners();
//   }

//   Future<void> addOrderData({
//     name,
//     category,
//     price,
//     image,
//     rate,
//     color,
//     isFav,
//     size,
//     quantityInCart,
//   }) async {
//     CollectionReference users =
//         FirebaseFirestore.instance.collection('usersData');
//     DocumentReference userDocRef = users.doc(_auth.currentUser?.uid);
//     CollectionReference ordersCollection = userDocRef.collection('a');
//     return ordersCollection.doc('order1').update({
//       'name': name,
//       'category': category,
//       'price': price,
//       'image': image,
//       'color': color,
//       'rate': rate,
//     });
//   }
// }
