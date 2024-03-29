import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_project/src/constant/_colors.dart';
import 'package:e_commerce_project/src/services/fav_service.dart';
import 'package:e_commerce_project/src/utils/navigation/router/app_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

@RoutePage()
class FavoriesPage extends StatefulWidget {
  const FavoriesPage({super.key});

  @override
  State<FavoriesPage> createState() => _FavoriesPageState();
}

class _FavoriesPageState extends State<FavoriesPage> {
  FavService fav = FavService();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  CollectionReference users =
      FirebaseFirestore.instance.collection('usersData');

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: StreamBuilder<DocumentSnapshot>(
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
                        Icons.favorite_outline_outlined,
                        color: Color.fromARGB(255, 0, 0, 0),
                        size: 50,
                      ),
                    )),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      'Favorilerine eklenen ürünler buraya kaydedilecek.',
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
          if (snapshot.hasData && snapshot.data?.data() != null) {
            final DocumentSnapshot<dynamic>? document = snapshot.data;

            final Map<String, dynamic> documentData = document?.data();

            final List<Map<String, dynamic>> favList =
                documentData['fav'] != null
                    ? (documentData['fav'] as List)
                        .map((favDetail) => favDetail as Map<String, dynamic>)
                        .toList()
                    : [];

            return ListView.builder(
              itemCount: favList.length,
              itemBuilder: (BuildContext context, int index) {
                final Map<String, dynamic> favDetail = favList[index];

                final String name = favDetail['name'];
                final String category = favDetail['category'];
                final String image = favDetail['image'];
                final double price = favDetail['price'];
                final double rate = favDetail['rate'];
                final String color = favDetail['color'];

                return Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    children: [
                      Slidable(
                        key: Key(name),
                        endActionPane: ActionPane(
                            motion: const ScrollMotion(),
                            extentRatio: 0.150,
                            children: [
                              SlidableAction(
                                  onPressed: (context) {
                                    fav.removeFavData(
                                      name: name,
                                      price: price,
                                      category: category,
                                      image: image,
                                      rate: rate,
                                      color: color,
                                    );
                                  },
                                  backgroundColor: Colors.grey.shade300,
                                  padding: const EdgeInsets.all(10),
                                  icon: Icons.delete,
                                  foregroundColor: AppColor.primaryColor),
                            ]),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Image.network(image),
                            ),
                            Expanded(
                              flex: 2,
                              child: SizedBox(
                                height: 182,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 6),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            name,
                                            style: const TextStyle(
                                                height: 1.2,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(height: 6),
                                          Row(
                                            children: [
                                              const Text("Renk :",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              Text(" $color"),
                                            ],
                                          ),
                                          const SizedBox(height: 6),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '$price TL',
                                            style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            height: 35,
                                            child: ElevatedButton(
                                              style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          Colors.black)),
                                              onPressed: () {
                                                context.router.replace(
                                                    const CategoryRoute());
                                              },
                                              child: const Text(
                                                "Sepete Ekle",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
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
                      ),
                      const Divider(
                        color: Colors.black54,
                      ),
                    ],
                  ),
                );
              },
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
                        Icons.favorite_outline_outlined,
                        color: Color.fromARGB(255, 0, 0, 0),
                        size: 50,
                      ),
                    )),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      'Favorilerine eklenen ürünler buraya kaydedilecek.',
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
        },
      ),
    );
  }
}
