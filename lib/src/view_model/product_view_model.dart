import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_project/src/models/product.dart';
import 'package:flutter/material.dart';

class ProductViewModel with ChangeNotifier {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<Product> _products = [];

  List<Product> get products => _products;

  ProductViewModel() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _getProducts();
    });
  }
  void _getProducts() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await _firestore.collection("products").get();
    // await _firestore.collection("products").doc("efgef").update({
    //         "stock": FieldValue.increment(-1);
    //       });
    for (QueryDocumentSnapshot<Map<String, dynamic>> documentSnapshot
        in snapshot.docs) {
      Product product = Product.fromMap(
        documentSnapshot.id,
        documentSnapshot.data(),
      );

      Map<String, dynamic> productSize = product.size;
      Map<String, dynamic> productSizeUpdated = {};
      productSizeUpdated["S"] = productSize["S"];
      productSizeUpdated["M"] = productSize["M"];
      productSizeUpdated["L"] = productSize["L"];
      product.size = productSizeUpdated;
      _products.add(product);
    }
    notifyListeners();
  }
}
