import 'dart:convert';
import 'package:e_commerce_project/src/ui/view/pages/product.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductViewModel with ChangeNotifier {
  final String api = "https://api.canerture.com/ecommerce/get_products";
  List<Product> _listProduct = [];
  List<Product> get listProduct => _listProduct;

  ProductViewModel() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => _getProducts());
  }

  void _getProducts() async {
    Uri uri = Uri.parse(api);
    http.Response response = await http.get(
      uri,
      headers: {"store": "canerture"},
    );

    Map<String, dynamic> responseMap = jsonDecode(response.body);
    List<dynamic> allProduct = responseMap['products'] ?? [];

    for (Map<String, dynamic> productMap in allProduct) {
      _listProduct.add(Product.fromMap(productMap));
    }
    notifyListeners();
  }
}
