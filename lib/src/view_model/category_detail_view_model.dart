import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_project/src/models/product.dart';
import 'package:flutter/material.dart';

class CategoryDetailViewModel with ChangeNotifier {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<Product> _products = [];
  final String title;
  List<Product> get products => _products;
  CategoryDetailViewModel({required this.title}) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _getProducts();
    });
  }

  void _getProducts() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await _firestore.collection("products").get();

    for (QueryDocumentSnapshot<Map<String, dynamic>> documentSnapshot
        in snapshot.docs) {
      Product product = Product.fromMap(
        documentSnapshot.id,
        documentSnapshot.data(),
      );
      product.category.toLowerCase() == title.toLowerCase()
          ? _products.add(product)
          : print('Değil');
    }
    notifyListeners();
  }
}
