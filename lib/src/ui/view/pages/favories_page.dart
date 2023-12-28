import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_project/src/di/injection.dart';
import 'package:e_commerce_project/src/services/fav_service.dart';
import 'package:flutter/material.dart';

import '../../../store/auth_store.dart';

@RoutePage()
class FavoriesPage extends StatefulWidget {
  const FavoriesPage({super.key});

  @override
  State<FavoriesPage> createState() => _FavoriesPageState();
}

class _FavoriesPageState extends State<FavoriesPage> {
  FavService fav = FavService();

  CollectionReference users =
      FirebaseFirestore.instance.collection('usersData');
  final authStore = getIt.get<AuthStore>();

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

          if (snapshot.hasData) {
            final DocumentSnapshot<dynamic>? document = snapshot.data;

            final Map<String, dynamic> documentData = document?.data();

            // if (documentData['fav'] == null) {
            //   print('No item now');
            // }

            final List<Map<String, dynamic>> favList =
                (documentData['fav'] as List)
                    .map((favDetail) => favDetail as Map<String, dynamic>)
                    .toList();
            print("favList : $favList");

            return ListView.builder(
              itemCount: favList.length,
              itemBuilder: (BuildContext context, int index) {
                final Map<String, dynamic> favDetail = favList[index];
                // final Map<String, dynamic> favImage = favList[index];

                final String code = favDetail['code'];
                final String name = favDetail['name'];
                final String images = favDetail['images'];

                // final String price = favDetail['price'];
                // final DateTime date = (favDetail['date'] as Timestamp).toDate();

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
                                image: NetworkImage(images),
                                width: 50,
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    'Name : ${name.toUpperCase()}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13),
                                  ),
                                  Text(
                                    'Code: $code',
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
                                  fav.removeFavData(
                                      name: name, code: code, images: images);
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
        }, // builder:
      ),
    );

    //sil
    // return StreamBuilder(
    //     stream: users.doc(authStore.currentUSer!.uid).snapshots(),
    //     builder: (context, snapshot) {
    //       if (!snapshot.hasData) {
    //         return Text("Loading");
    //       }
    //       var userDocument = snapshot.data;
    //       return Text(userDocument?[{
    //         'fav': FieldValue.arrayUnion([0])
    //       }]);
    //     });

    // return StreamBuilder<QuerySnapshot>(
    //   stream: _usersStream,
    //   builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    //     if (snapshot.hasError) {
    //       return const Text('Something went wrong');
    //     }

    //     if (snapshot.connectionState == ConnectionState.waiting) {
    //       return const Text("Loading");
    //     }

    //     return ListView(
    //       children: snapshot.data!.docs.map((DocumentSnapshot document) {
    //         Map<String, dynamic> data =
    //             document.data()! as Map<String, dynamic>;
    //         return ListTile(
    //           title: Text(data['userEmail']),
    //           subtitle: Text(data['userUid']),
    //         );
    //       }).toList(),
    //     );
    //   },
    // );

    // return Scaffold(
    //   body: Column(
    //     mainAxisAlignment: MainAxisAlignment.spaceAround,
    //     children: [
    //       const SizedBox(
    //         height: 150,
    //       ),
    //       const Column(
    //         children: [
    //           Center(
    //               child: CircleAvatar(
    //             radius: 50,
    //             backgroundColor: Color.fromRGBO(211, 211, 211, 1),
    //             child: Icon(
    //               Icons.favorite_outline_outlined,
    //               color: Color.fromARGB(255, 0, 0, 0),
    //               size: 50,
    //             ),
    //           )),
    //           SizedBox(
    //             height: 30,
    //           ),
    //           Text(
    //             'Favorilerine eklenen ürünler buraya kaydedilecek.',
    //             textAlign: TextAlign.center,
    //             style: TextStyle(fontSize: 20),
    //           ),
    //         ],
    //       ),
    //       Container(
    //         height: 50,
    //         width: 250,
    //         margin: const EdgeInsets.only(top: 100),
    //         child: ElevatedButton(
    //           onPressed: () {},
    //           style: ElevatedButton.styleFrom(
    //             backgroundColor: Colors.black,
    //           ),
    //           child: const Text(
    //             'Alışverişe Başla',
    //             style: TextStyle(
    //               fontSize: 18,
    //               color: Colors.white,
    //             ),
    //           ),
    //         ),
    //       ),

    //       // users.doc(authStore.currentUSer!.uid).snapshots((QuerySnapshot) => {})
    //     ],
    //   ),
    // );
  }
}
