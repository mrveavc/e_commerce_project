import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_project/src/utils/navigation/router/app_router.dart';
import 'package:e_commerce_project/src/view_model/cart_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
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
  CollectionReference users =
      FirebaseFirestore.instance.collection('usersData');

  final FirebaseAuth _auth = FirebaseAuth.instance;

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
                    onPressed: () {
                      context.router.push(const LoginRoute());
                    },
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

          if (snapshot.hasData && snapshot.data?.data() != null) {
            final DocumentSnapshot<dynamic>? document = snapshot.data;

            final Map<String, dynamic> documentData = document?.data();

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
                      final String name = cartDetail['name'];
                      final String category = cartDetail['category'];
                      final String image = cartDetail['image'];
                      final double price = cartDetail['price'];
                      final double rate = cartDetail['rate'];
                      final String color = cartDetail['color'];
                      final String size = cartDetail['size'];
                      final int? quantityInCart = cartDetail['quantityInCart'];

                      return Padding(
                        padding: const EdgeInsets.all(14),
                        child: Slidable(
                          key: Key(name),
                          endActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              extentRatio: 0.150,
                              children: [
                                SlidableAction(
                                  onPressed: (context) {
                                    print("silme slide gerçekleşti");

                                    cartViewModel.removeCartData(
                                        name: name,
                                        price: price,
                                        category: category,
                                        image: image,
                                        rate: rate,
                                        color: color,
                                        size: size,
                                        quantityInCart: quantityInCart);
                                  },
                                  backgroundColor: Colors.grey.shade300,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  icon: Icons.delete,
                                  foregroundColor: Colors.black,
                                ),
                              ]),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      children: [
                                        Image.network(image),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "$quantityInCart Adet ",
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const Icon(
                                                Icons.keyboard_arrow_down)
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: SizedBox(
                                        height: 220,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  name,
                                                  style: const TextStyle(
                                                      height: 1.2,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                const SizedBox(height: 6),
                                                Row(
                                                  children: [
                                                    const Text("Beden :",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                    Text(" $size"),
                                                  ],
                                                ),
                                                const SizedBox(height: 6),
                                                Row(
                                                  children: [
                                                    const Text("Renk :",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                    Text(" $color"),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Text(
                                                  price.toString(),
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 8),
                              const Divider(
                                color: Colors.black54,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color.fromARGB(255, 229, 223, 223))),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Consumer<CartViewModel>(
                      builder: (context, viewModel, child) => Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Toplam Tutar :"),
                                Text(
                                  ' ${viewModel.totalPrice.ceilToDouble()} TL',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.black)),
                              onPressed: () {
                                context.router
                                    .push(PaymentRoute(viewModel: viewModel));
                              },
                              child: const Text(
                                "Sepeti Onayla",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
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
