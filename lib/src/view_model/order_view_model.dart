import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_project/src/models/product.dart';
import 'package:e_commerce_project/src/view_model/cart_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OrderViewModel with ChangeNotifier {
  final List<Map<String, dynamic>> _orders = [];

  List<Map<String, dynamic>> get orders => _orders;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  var cartViewModel = CartViewModel();

  OrderViewModel() {
    WidgetsBinding.instance
        .addPostFrameCallback((timeStamp) async => await getAllOrders());
  }

  final CollectionReference collectionRef =
      FirebaseFirestore.instance.collection('usersData');

  Future<void> moveCurrentCartItemsToOrder() async {
    var products = await cartViewModel.getAllProductsInCart();

    String uniqueKey = UniqueKey().toString();

    List<dynamic> cartItems = [];

    for (Product pro in products) {
      Map<String, dynamic> proMap = pro.toMap();
      cartItems.add(proMap);
      cartViewModel.removeProductFromCart(pro);
    }

    await collectionRef
        .doc(_auth.currentUser?.uid)
        .collection("orders")
        .doc(uniqueKey)
        .set({
      "orderDate": DateTime.now().toString(),
      "products": FieldValue.arrayUnion(cartItems)
    });
  }

  Future<void> getAllOrders() async {
    _orders.clear();

    var qs = await collectionRef
        .doc(_auth.currentUser?.uid)
        .collection("orders")
        .get();

    var orders = qs.docs.map((doc) => doc.data()).toList();

    List<Product> products = [];

    for (var _order in orders) {
      for (var _product in _order["products"]) {
        products.add(Product.fromCartMap(null, _product));
      }

      _orders.add({
        "orderDate": _order["orderDate"],
        "products": products.map((e) => e).toList()
      });

      products.clear();
    }

    notifyListeners();
  }
}
