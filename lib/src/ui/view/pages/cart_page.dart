import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   centerTitle: false,
      //   titleTextStyle: const TextStyle(fontSize: 20, color: EColor.iconGrey),
      //   title: const Text('Favoriler'),
      // ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const SizedBox(
            height: 150,
          ),
          const Column(
            children: [
              Center(
                  child: CircleAvatar(
                radius: 50,
                backgroundColor: Color.fromRGBO(211, 211, 211, 1),
                child: Icon(
                  Icons.shopping_bag,
                  color: Color.fromARGB(255, 0, 0, 0),
                  size: 50,
                ),
              )),
              SizedBox(
                height: 30,
              ),
              Text(
                'Siparişlerine eklenen ürünler buraya kaydedilecek.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
          Container(
            height: 50,
            width: 250,
            margin: const EdgeInsets.only(top: 100),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
              ),
              child: const Text(
                'Alışverişe Başla',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
