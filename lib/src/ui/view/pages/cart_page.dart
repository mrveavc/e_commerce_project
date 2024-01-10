import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_project/src/models/product.dart';
import 'package:e_commerce_project/src/services/cart_service.dart';
import 'package:e_commerce_project/src/services/order_service.dart';
import 'package:e_commerce_project/src/view_model/cart_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

@RoutePage()
class CartPage extends StatefulWidget implements AutoRouteWrapper {
  const CartPage({super.key});
  @override
  Widget wrappedRoute(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CartViewModel(),
      child: this,
    );
  }

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  OrderService order = OrderService();
  CartService cart = CartService();

  CollectionReference users =
      FirebaseFirestore.instance.collection('usersData');
  // final authStore = getIt.get<AuthStore>();
  FirebaseAuth _auth = FirebaseAuth.instance;
  // final cartStore = getIt.get<CartStore>();

  // @override
  // void initState() {
  //   viewModel.totalPrice = 0;
  // }

  @override
  Widget build(BuildContext context) {
    CartViewModel cartViewModel = Provider.of(context, listen: false);

    return Container(
      color: Colors.white,
      child: StreamBuilder<DocumentSnapshot>(
        // stream: users.doc(authStore.currentUSer?.uid).snapshots(),
        stream: users.doc(_auth.currentUser?.uid).snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (_auth.currentUser == null) {
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
                documentData['cart'] != null
                    ? (documentData['cart'] as List)
                        .map((cartDetail) => cartDetail as Map<String, dynamic>)
                        .toList()
                    : [];

            cartViewModel.setTotalPrice(cartList);
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartList.length,
                    itemBuilder: (BuildContext context, int index) {
                      final Map<String, dynamic> cartDetail = cartList[index];
                      // final Map<String, dynamic> favImage = favList[index];
                      final String name = cartDetail['name'];
                      final String category = cartDetail['category'];
                      final String image = cartDetail['image'];
                      final double price = cartDetail['price'];
                      final double rate = cartDetail['rate'];
                      final String color = cartDetail['color'];
                      final String size = cartDetail['size'];
                      final int? quantityInCart = cartDetail['quantityInCart'];

                      // final String size = cartDetail['size '];
                      // final String color = cartDetail['color '];

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
                                      image: NetworkImage(image),
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
                                          name.toUpperCase(),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13),
                                        ),
                                        Text(
                                          'Category: $category',
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
                                        Text(
                                          'Size: $size',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                          ),
                                        ),
                                        Text(
                                          // quantityInCart == null
                                          //     ? "Adet : 0"
                                          //     : 'Adet: $quantityInCart',
                                          quantityInCart.toString(),
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
                                            name: name,
                                            price: price,
                                            category: category,
                                            image: image,
                                            rate: rate,
                                            color: color,
                                            size: size,
                                            quantityInCart: quantityInCart);
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
                Consumer<CartViewModel>(
                    builder: (context, viewModel, child) =>
                        Text('Sepet Tutar : ${viewModel.totalPrice}')),
                // ElevatedButton(onPressed: () {
                //   order.addOrderData( name: name,
                //                             price: price,
                //                             category: category,
                //                             image: image,
                //                             rate: rate,
                //                             color: color,
                //                             size: size,
                //                             quantityInCart: quantityInCart)
                // }, child: Text('Ödeme Yap'))
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
