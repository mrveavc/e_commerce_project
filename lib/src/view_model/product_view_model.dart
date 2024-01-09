import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_project/src/models/product.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductViewModel with ChangeNotifier {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool? _isChecked = false;
  bool? get isChecked => _isChecked;

  // List<bool>? _isChecked;
  // List<bool>? get isChecked => _isChecked;

  void set isChecked(bool? value) {
    _isChecked = value;
    notifyListeners();
  }

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
      _products.add(product);
    }
    notifyListeners();
  }

  // final String api = "https://api.canerture.com/ecommerce/get_products";
  // List<Product> _listProduct = [];
  // List<Product> get listProduct => _listProduct;

  // ProductViewModel() {
  //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) => _getProducts());
  // }

  // void _getProducts() async {
  //   Uri uri = Uri.parse(api);
  //   http.Response response = await http.get(
  //     uri,
  //     headers: {"store": "canerture"},
  //   );

  //   Map<String, dynamic> responseMap = jsonDecode(response.body);
  //   List<dynamic> allProduct = responseMap['products'] ?? [];

  //   for (Map<String, dynamic> productMap in allProduct) {
  //     _listProduct.add(Product.fromMap(productMap));
  //   }
  //   notifyListeners();
  // }
}
