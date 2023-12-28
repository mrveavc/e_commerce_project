import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_project/src/di/injection.dart';
import 'package:flutter/material.dart';

import '../../../store/auth_store.dart';

@RoutePage()
class FavoriesPage extends StatefulWidget {
  const FavoriesPage({super.key});

  @override
  State<FavoriesPage> createState() => _FavoriesPageState();
}

class _FavoriesPageState extends State<FavoriesPage> {
  CollectionReference users =
      FirebaseFirestore.instance.collection('usersData');
  final authStore = getIt.get<AuthStore>();

  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('usersData').snapshots();

  // getFav() {
  //    CollectionReference users =
  //       FirebaseFirestore.instance.collection('usersData');
  //    final ref = users.where("userUid");
  //   ref.onSnapshot((querySnapshot) => {
  //     const items = [];
  //     querySnapshot.forEach((doc) => {
  //       items.push(doc.data());
  //     });
  //     setFav(items);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }

        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            return ListTile(
              title: Text(data['userEmail']),
              subtitle: Text(data['userUid']),
            );
          }).toList(),
        );
      },
    );

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
