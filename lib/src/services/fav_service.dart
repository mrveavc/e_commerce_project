import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_project/src/di/injection.dart';
import 'package:e_commerce_project/src/store/auth_store.dart';

class FavService {
  final authStore = getIt.get<AuthStore>();

  Future<void> addFavData({id, title, price, imageOne}) {
    CollectionReference users =
        FirebaseFirestore.instance.collection('usersData');
    return users
        .doc(authStore.currentUSer!.uid)
        .update(
          {
            'fav': FieldValue.arrayUnion([
              {'id': id, 'title': title, 'price': price, 'imageOne': imageOne},
            ])
          },
        )
        .then((value) => print("Fav Added"))
        .catchError((error) => print("Failed to add fav: $error"));
  }

  Future<void> removeFavData({id, title, price, imageOne}) {
    CollectionReference users =
        FirebaseFirestore.instance.collection('usersData');
    return users
        .doc(authStore.currentUSer!.uid)
        .update(
          {
            'fav': FieldValue.arrayRemove([
              {'id': id, 'title': title, 'price': price, 'imageOne': imageOne},
            ])
          },
        )
        .then((value) => print("Fav remove"))
        .catchError((error) => print("Failed to remove fav: $error"));
  }
}
