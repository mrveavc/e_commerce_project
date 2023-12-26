import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _PageCartState();
}

class _PageCartState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("merve"),
    );
  }
}
