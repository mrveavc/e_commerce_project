import 'package:auto_route/auto_route.dart';
import 'package:e_commerce_project/src/ui/layout/main_layout.dart';
import 'package:e_commerce_project/src/ui/view/pages/cart_page.dart';
import 'package:e_commerce_project/src/ui/view/pages/category_detail_page.dart';
import 'package:e_commerce_project/src/ui/view/pages/category_page.dart';
import 'package:e_commerce_project/src/ui/view/pages/favories_page.dart';
import 'package:e_commerce_project/src/ui/view/pages/home_page.dart';
import 'package:e_commerce_project/src/ui/view/pages/login_page.dart';
import 'package:e_commerce_project/src/ui/view/pages/profile_page.dart';
import 'package:e_commerce_project/src/ui/view/pages/sign_up_page.dart';
import 'package:e_commerce_project/src/ui/view/splash_screen/splash_screen.dart';

import 'package:e_commerce_project/src/utils/navigation/guards/auth_guard.dart';
import 'package:flutter/material.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: SplashRoute.page, initial: true),
        AutoRoute(
            guards: [AuthGuard()],
            page: MainLayoutRoute.page,
            children: [
              AutoRoute(page: HomeRoute.page, initial: true),
              AutoRoute(page: SignUpRoute.page),
              AutoRoute(page: LoginRoute.page),
              AutoRoute(page: CartRoute.page),
              AutoRoute(page: FavoriesRoute.page),
              AutoRoute(page: CategoryRoute.page),
              AutoRoute(page: ProfilRoute.page),
              AutoRoute(page: CategoryDetailRoute.page)
            ]),
      ];
}
