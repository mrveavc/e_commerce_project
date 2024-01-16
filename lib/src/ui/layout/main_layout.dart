import 'package:auto_route/auto_route.dart';
import 'package:e_commerce_project/src/constant/_colors.dart';
import 'package:e_commerce_project/src/utils/navigation/router/app_router.dart';
import 'package:e_commerce_project/src/view_model/main_layout_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:e_commerce_project/gen/assets.gen.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

@RoutePage()
class MainLayoutPage extends StatefulWidget implements AutoRouteWrapper {
  const MainLayoutPage({super.key});

  @override
  State<MainLayoutPage> createState() => _MainLayoutPageState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => MainLayoutViewModel(), child: this);
  }
}

class _MainLayoutPageState extends State<MainLayoutPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        centerTitle: true,
        title: Image.asset(Assets.images.logo.path, width: 110),
        actions: [
          const Icon(Icons.search),
          const SizedBox(
            width: 10,
          ),
          IconButton(
            icon: const Icon(Icons.person_outline),
            onPressed: () {
              if (_auth.currentUser != null) {
                context.router.push(const ProfilRoute());
              } else {
                context.router.push(const LoginRoute());
              }
            },
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      body: const AutoRouter(),
      bottomNavigationBar: Consumer<MainLayoutViewModel>(
        builder: (context, viewModel, child) {
          return BottomNavigationBar(
            currentIndex: viewModel.selectedIconIndex,
            onTap: (currentIndex) {
              viewModel.selectedIconIndex = currentIndex;

              viewModel.navigateToSelectedPage(currentIndex, context);
            },
            items: [
              _buildBottomNavigationBarItem(
                  isActive: viewModel.selectedIconIndex == 0,
                  assetName: Assets.icons.icHome,
                  labelText: "Anasayfa"),
              _buildBottomNavigationBarItem(
                  isActive: viewModel.selectedIconIndex == 1,
                  assetName: Assets.icons.icCategory,
                  labelText: "Kategoriler"),
              _buildBottomNavigationBarItem(
                  isActive: viewModel.selectedIconIndex == 2,
                  assetName: Assets.icons.icFavorite,
                  labelText: "Favorilerim"),
              _buildBottomNavigationBarItem(
                  isActive: viewModel.selectedIconIndex == 3,
                  assetName: Assets.icons.icShoppingCart,
                  labelText: "Sepetim"),
              _buildBottomNavigationBarItem(
                  isActive: viewModel.selectedIconIndex == 4,
                  assetName: Assets.icons.icPerson,
                  labelText: "Hesabım"),
            ],
            type: BottomNavigationBarType.fixed,
            backgroundColor: AppColor.whiteColor,
            unselectedFontSize: 12,
            selectedFontSize: 12,
            selectedItemColor: AppColor.selectedIconColor,
            unselectedItemColor: AppColor.unSelectedIconColor,
            showUnselectedLabels: true,
          );
        },
      ),
    );
  }
}

BottomNavigationBarItem _buildBottomNavigationBarItem(
    {required bool isActive,
    required String assetName,
    required String labelText}) {
  return BottomNavigationBarItem(
      icon: isActive
          ? SvgPicture.asset(assetName,
              color: AppColor.selectedIconColor, height: 28)
          : SvgPicture.asset(assetName,
              color: AppColor.unSelectedIconColor, height: 28),
      label: labelText);
}
