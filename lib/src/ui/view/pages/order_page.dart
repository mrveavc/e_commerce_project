import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_project/src/models/product.dart';
import 'package:e_commerce_project/src/services/order_service.dart';
import 'package:e_commerce_project/src/view_model/order_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

@RoutePage()
class OrderPage extends StatefulWidget implements AutoRouteWrapper {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => OrderService(),
      child: this,
    );
  }
}

class _OrderPageState extends State<OrderPage> {
  OrderService order = OrderService();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  CollectionReference users =
      FirebaseFirestore.instance.collection('usersData');

  @override
  Widget build(Object context) {
    return Consumer<OrderService>(
      builder: (context, viewModel, child) {
        return ListView.builder(
          itemCount: viewModel.products.length,
          itemBuilder: (context, index) {
            Product product = viewModel.products[index];
            return Text(product.name);
          },
        );
      },
    );
  }
  // final authStore = getIt.get<AuthStore>();
}
