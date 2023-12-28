import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_project/src/di/injection.dart';
import 'package:e_commerce_project/src/store/auth_store.dart';
// import 'package:firebase_auth/firebase_auth.dart';

class FavService {
  final authStore = getIt.get<AuthStore>();

  Future<void> addFavData({name, code, images}) {
    CollectionReference users =
        FirebaseFirestore.instance.collection('usersData');

    // Call the user's CollectionReference to add a new user
    return users
        .doc(authStore.currentUSer!.uid)
        .update(
          {
            'fav': FieldValue.arrayUnion([
              {
                'name': name,
                'code': code,
                'images': images
                // 'images':,
              },
            ])
          },
        )
        .then((value) => print("Fav Added"))
        .catchError((error) => print("Failed to add fav: $error"));
  }

  Future<void> removeFavData({name, code, images}) {
    CollectionReference users =
        FirebaseFirestore.instance.collection('usersData');

    // Call the user's CollectionReference to add a new user
    return users
        .doc(authStore.currentUSer!.uid)
        .update(
          {
            'fav': FieldValue.arrayRemove([
              {'name': name, 'code': code, 'images': images},
            ])
          },
        )
        .then((value) => print("Fav remove"))
        .catchError((error) => print("Failed to remove fav: $error"));
  }
}
