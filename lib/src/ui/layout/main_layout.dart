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
  // final authStore = getIt.get<AuthStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
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
                  labelText: "Home"),
              _buildBottomNavigationBarItem(
                  isActive: viewModel.selectedIconIndex == 1,
                  assetName: Assets.icons.icCategory,
                  labelText: "Categories"),
              _buildBottomNavigationBarItem(
                  isActive: viewModel.selectedIconIndex == 2,
                  assetName: Assets.icons.icFavorite,
                  labelText: "Favorites"),
              _buildBottomNavigationBarItem(
                  isActive: viewModel.selectedIconIndex == 3,
                  assetName: Assets.icons.icShoppingCart,
                  labelText: "Cart"),
              _buildBottomNavigationBarItem(
                  isActive: viewModel.selectedIconIndex == 4,
                  assetName: Assets.icons.icPerson,
                  labelText: "My Account"),
            ],

            // Icon'lar seçilirken default olarak padding almasını engellemek için;
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

      // bottomNavigationBar: Consumer<MainLayoutViewModel>(
      //   builder: (context, viewModel, child) {
      //     return BottomNavigationBar(
      //       currentIndex: viewModel.selectedIconIndex,
      //       onTap: (currentIndex) {
      //         switch (currentIndex) {
      //           case 0:
      //             context.router.push(const HomeRoute());

      //             break;
      //           case 1:
      //             context.router.push(const CategoryRoute());
      //             break;
      //           case 2:
      //             context.router.push(const FavoriesRoute());
      //             break;
      //           case 3:
      //             context.router.push(const CartRoute());
      //             break;
      //           case 4:
      //             context.router.push(_auth.currentUser != null
      //                 ? const ProfilRoute()
      //                 : const LoginRoute());
      //             // context.router.push(authStore.isUserLoggedIn
      //             //     ? const ProfilRoute()
      //             //     : const LoginRoute());
      //             break;
      //           default:
      //         }
      //       },
      //       showSelectedLabels: false,
      //       items: [
      //         BottomNavigationBarItem(
      //           icon: SvgPicture.asset(Assets.icons.icHome, height: 20),
      //           label: "Home",
      //         ),
      //         BottomNavigationBarItem(
      //             icon: SvgPicture.asset(Assets.icons.icMenu, height: 20),
      //             label: "Category"),
      //         BottomNavigationBarItem(
      //             icon: SvgPicture.asset(Assets.icons.icFav, height: 20),
      //             label: "Favories"),
      //         BottomNavigationBarItem(
      //             icon:
      //                 SvgPicture.asset(Assets.icons.icShoppingBag, height: 20),
      //             label: "Cart"),
      //         BottomNavigationBarItem(
      //             icon: SvgPicture.asset(Assets.icons.icUser, height: 20),
      //             label: "Profile"),
      //       ],
      //       selectedItemColor: Colors.white,
      //     );
      //   },
      // ),
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
