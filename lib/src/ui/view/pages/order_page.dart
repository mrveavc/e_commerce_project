import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_project/src/constant/_colors.dart';
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
  List<Map<String, dynamic>> orders = [];

  CollectionReference users =
      FirebaseFirestore.instance.collection('usersData');
  @override
  Widget build(Object context) {
    return Consumer<OrderViewModel>(
      builder: (context, orderViewModel, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(14, 14, 14, 0),
              child: Text(
                'Tüm Siparişler',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: orderViewModel.orders.length,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ExpansionTile(
                        shape: const Border(),
                        subtitle: const Text("Durum : Hazırlanıyor",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColor.orangeColor)),
                        title: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 14, 14, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.calendar_month),
                                  Text(
                                    " ${orderViewModel.orders[index]["orderDate"].toString().substring(0, 16)}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount:
                                orderViewModel.orders[index]["products"].length,
                            itemBuilder: (context, ind) {
                              Product product =
                                  orderViewModel.orders[index]["products"][ind];
                              return Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(14, 14, 14, 0),
                                child: Column(
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Image.network(product.image,
                                              height: 80),
                                        ),
                                        Expanded(
                                          flex: 6,
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: SizedBox(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        product.name,
                                                        style: const TextStyle(
                                                            height: 1.2,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      const SizedBox(height: 6),
                                                      Row(
                                                        children: [
                                                          const Text("Beden :",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                          Text(
                                                              " ${product.size["singleSize"]}"),
                                                        ],
                                                      ),
                                                      const SizedBox(height: 6),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              const Text(
                                                                  "Renk :",
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold)),
                                                              Text(
                                                                  " ${product.color}"),
                                                            ],
                                                          ),
                                                          Text(
                                                            "${product.price} TL",
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          )
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Divider(
                                      color: Colors.black54,
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
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
