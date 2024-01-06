import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_project/src/di/injection.dart';
import 'package:e_commerce_project/src/services/cart_service.dart';
import 'package:e_commerce_project/src/store/cart_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../store/auth_store.dart';

@RoutePage()
class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  CartService cart = CartService();

  CollectionReference users =
      FirebaseFirestore.instance.collection('usersData');
  final authStore = getIt.get<AuthStore>();
  final cartStore = getIt.get<CartStore>();

  @override
  void initState() {
    cartStore.totalPrice = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: StreamBuilder<DocumentSnapshot>(
        stream: users.doc(authStore.currentUSer?.uid).snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (authStore.isUserLoggedIn == false) {
            return Column(
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
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      'Siparişlere eklenen ürünler buraya kaydedilecek.',
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
            );
          }

          if (snapshot.hasData) {
            final DocumentSnapshot<dynamic>? document = snapshot.data;

            final Map<String, dynamic> documentData = document?.data();

            // if (documentData['cart'] == null) {
            //   print('No item now');
            // }

            final List<Map<String, dynamic>> cartList =
                (documentData['cart'] as List)
                    .map((cartDetail) => cartDetail as Map<String, dynamic>)
                    .toList();

            cartStore.setTotalPrice(cartList);
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartList.length,
                    itemBuilder: (BuildContext context, int index) {
                      final Map<String, dynamic> cartDetail = cartList[index];
                      // final Map<String, dynamic> favImage = favList[index];
                      final int id = cartDetail['id'];
                      final String title = cartDetail['title'];
                      final String imageOne = cartDetail['imageOne'];
                      final double price = cartDetail['price'];

                      // final String price = cartDetail['price'];
                      // final DateTime date = (cartDetail['date'] as Timestamp).toDate();

                      return Card(
                        child: Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(16.0),
                            ),
                            Expanded(
                              child: Row(
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Image(
                                      image: NetworkImage(imageOne),
                                      width: 50,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 5,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          'title : ${title.toUpperCase()}',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13),
                                        ),
                                        Text(
                                          'id: $id',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                          ),
                                        ),
                                        Text(
                                          'Price: $price',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 4.0,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: IconButton(
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                      onPressed: () {
                                        cart.removeCartData(
                                            id: id,
                                            title: title,
                                            imageOne: imageOne,
                                            price: price);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Observer(
                  builder: (context) {
                    return Text('Sepet Tutar : ${cartStore.totalPrice}');
                  },
                ),
              ],
            );
          } else {
            return Column(
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
                      'Siparişlere eklenen ürünler buraya kaydedilecek.',
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
            );
          }
        }, // builder:
      ),
    );
  }
}
