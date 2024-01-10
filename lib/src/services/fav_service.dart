import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FavService {
  // final authStore = getIt.get<AuthStore>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> addFavData({name, category, price, image, rate, color, isFav}) {
    // isFav = !isFav;
    CollectionReference users =
        FirebaseFirestore.instance.collection('usersData');
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
  // Future<void> addFavData({id, title, price, imageOne}) {
  //   CollectionReference users =
  //       FirebaseFirestore.instance.collection('usersData');
  //   return users
  //       .doc(_auth.currentUser?.uid)
  //       .update(
  //         {
  //           'fav': FieldValue.arrayUnion([
  //             {'id': id, 'title': title, 'price': price, 'imageOne': imageOne},
  //           ])
  //         },
  //       )
  //       .then((value) => print("Fav Added"))
  //       .catchError((error) => print("Failed to add fav: $error"));
  // }

  // Future<void> removeFavData({id, title, price, imageOne}) {
  //   CollectionReference users =
  //       FirebaseFirestore.instance.collection('usersData');
  //   return users
  //       .doc(_auth.currentUser?.uid)
  //       .update(
  //         {
  //           'fav': FieldValue.arrayRemove([
  //             {'id': id, 'title': title, 'price': price, 'imageOne': imageOne},
  //           ])
  //         },
  //       )
  //       .then((value) => print("Fav remove"))
  //       .catchError((error) => print("Failed to remove fav: $error"));
  // }
}
