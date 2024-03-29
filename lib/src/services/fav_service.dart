import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FavService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> addFavData(
      {name, category, price, image, rate, color, isFav}) async {
    CollectionReference users =
        FirebaseFirestore.instance.collection('usersData');

    DocumentSnapshot docSnap = await users.doc(_auth.currentUser?.uid).get();

    if (!docSnap.exists) {
      print(users.doc(_auth.currentUser?.uid).get());
      return users
          .doc(_auth.currentUser?.uid)
          .set(
            {
              'fav': FieldValue.arrayUnion([
                {
                  'name': name,
                  'category': category,
                  'price': price,
                  'image': image,
                  'rate': rate,
                  'color': color,
                },
              ])
            },
          )
          .then((value) => print("Fav Added"))
          .catchError((error) => print("Failed to add fav: $error"));
    } else {
      print("girdi2");

      return users
          .doc(_auth.currentUser?.uid)
          .update(
            {
              'fav': FieldValue.arrayUnion([
                {
                  'name': name,
                  'category': category,
                  'price': price,
                  'image': image,
                  'rate': rate,
                  'color': color,
                },
              ])
            },
          )
          .then((value) => print("Fav Added"))
          .catchError((error) => print("Failed to add fav: $error"));
    }
  }

  Future<void> removeFavData({name, category, price, image, rate, color}) {
    CollectionReference users =
        FirebaseFirestore.instance.collection('usersData');
    return users
        .doc(_auth.currentUser?.uid)
        .update(
          {
            'fav': FieldValue.arrayRemove([
              {
                'name': name,
                'category': category,
                'price': price,
                'image': image,
                'rate': rate,
                'color': color,
              },
            ])
          },
        )
        .then((value) => print("Fav remove"))
        .catchError((error) => print("Failed to remove fav: $error"));
  }
}
