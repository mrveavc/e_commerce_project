import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_project/src/models/product.dart';
import 'package:e_commerce_project/src/view_model/order_view_model.dart';
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
      create: (_) => OrderViewModel(),
      child: this,
    );
  }
}

class _OrderPageState extends State<OrderPage> {
  OrderViewModel order = OrderViewModel();

  CollectionReference users =
      FirebaseFirestore.instance.collection('usersData');
  @override
  Widget build(Object context) {
    return Consumer<OrderViewModel>(
      builder: (context, viewModel, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                'Siparişler',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: viewModel.products.length,
                itemBuilder: (context, index) {
                  Product product = viewModel.products[index];

                  // order.addOrderData(
                  //     name: product.name,
                  //     price: product.price,
                  //     category: product.category,
                  //     image: product.image,
                  //     rate: product.rate,
                  //     color: product.color,
                  //     size: product.size,
                  //     quantityInCart: product.quantityInCart);
                  return Padding(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Column(
                                children: [
                                  Image.network(product.image),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "${product.quantityInCart} Adet ",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const Icon(Icons.keyboard_arrow_down)
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
                                            product.name,
                                            style: const TextStyle(
                                                height: 1.2,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(height: 6),
                                          Row(
                                            children: [
                                              const Text("Beden :",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              Text(" ${product.size}"),
                                            ],
                                          ),
                                          const SizedBox(height: 6),
                                          Row(
                                            children: [
                                              const Text("Renk :",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              Text(" ${product.color}"),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            product.price.toString(),
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
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
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
