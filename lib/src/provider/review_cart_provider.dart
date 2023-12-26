import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ReviewCartPRovider with ChangeNotifier {
  void addReviewCartData({
    required String cartCode,
    required String cartName,
    required int cartPrice,
  }) async {
    FirebaseFirestore.instance
        .collection("ReviewCart")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("YourReviewCart")
        .doc(cartCode)
        .set(
      {
        "cartId": cartCode,
        "cartName": cartName,
        "cartPrice": cartPrice,
        "isAdd": true,
      },
    );
  }
}
