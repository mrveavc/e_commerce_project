import 'package:auto_route/auto_route.dart';
import 'package:e_commerce_project/src/ui/view/pages/profile_page.dart';
import 'package:e_commerce_project/src/utils/navigation/router/app_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MainLayoutViewModel with ChangeNotifier {
  int _selectedIconIndex = 0;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  int get selectedIconIndex => _selectedIconIndex;

  set selectedIconIndex(int value) {
    _selectedIconIndex = value;
    notifyListeners();
  }

  void navigateToSelectedPage(int currentIndex, BuildContext context) {
    switch (_selectedIconIndex) {
      case 0:
        context.router.push(HomeRoute());
        break;
      case 1:
        context.router.push(const CategoryRoute());
        break;
      case 2:
        context.router.push(const FavoriesRoute());
        break;
      case 3:
        context.router.push(const CartRoute());
        break;
      case 4:
        context.router.push(_auth.currentUser != null
            ? const ProfilRoute()
            : const LoginRoute());
        break;
      default:
    }
  }
}
