// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class UserService {
//   Future<void> addUserData({String? userEmail, User? currentUser}) {
//     CollectionReference users =
//         FirebaseFirestore.instance.collection('usersData');
//     return users
//         .doc(currentUser!.uid)
//         .set(
//           {
//             "userEmail": userEmail,
//             "userUid": currentUser.uid,
//           },
//         )
//         .then((value) => print("User Added"))
//         .catchError((error) => print("Failed to add user: $error"));
//   }
// }
