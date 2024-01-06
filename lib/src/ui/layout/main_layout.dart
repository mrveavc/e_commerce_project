import 'package:auto_route/auto_route.dart';
import 'package:e_commerce_project/src/di/injection.dart';
import 'package:e_commerce_project/src/store/auth_store.dart';
import 'package:e_commerce_project/src/utils/navigation/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:e_commerce_project/gen/assets.gen.dart';
import 'package:e_commerce_project/src/constant/_colors.dart';

import 'package:flutter_svg/flutter_svg.dart';

@RoutePage()
class MainLayoutPage extends StatefulWidget {
  const MainLayoutPage({super.key});

  @override
  State<MainLayoutPage> createState() => _MainLayoutPageState();
}

class _MainLayoutPageState extends State<MainLayoutPage> {
  final authStore = getIt.get<AuthStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset('assets/images/logo.jpg', width: 110),

        actions: const [
          Icon(Icons.search),
          SizedBox(
            width: 10,
          ),
          Icon(Icons.person_2_outlined),
          SizedBox(
            width: 10,
          ),
        ],
        // title: const Text("KASVA"),
      ),
      body: const AutoRouter(),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (currentIndex) {
          switch (currentIndex) {
            case 0:
              context.router.push(const MyHomeRoute());
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
              context.router.push(authStore.isUserLoggedIn
                  ? const ProfilRoute()
                  : const LoginRoute());
              break;
            default:
          }
        },
        showSelectedLabels: false,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(Assets.icons.icHome, height: 20),
            label: "Home",
          ),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(Assets.icons.icMenu, height: 20),
              label: "Category"),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(Assets.icons.icFav, height: 20),
              label: "Favories"),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(Assets.icons.icShoppingBag, height: 20),
              label: "Cart"),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(Assets.icons.icUser, height: 20),
              label: "Profile"),
        ],
        //selectedFontSize: 12,
        selectedIconTheme: const IconThemeData(
          color: Colors.amber,
          //size: 50,
        ),
        selectedItemColor: EColor.selectedIconBlack,
      ),
    );
  }
}
