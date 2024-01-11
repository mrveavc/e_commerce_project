import 'package:auto_route/auto_route.dart';
import 'package:e_commerce_project/src/constant/_colors.dart';
import 'package:e_commerce_project/src/models/product.dart';
import 'package:e_commerce_project/src/services/cart_service.dart';
import 'package:e_commerce_project/src/services/fav_service.dart';
import 'package:e_commerce_project/src/utils/navigation/router/app_router.dart';
import 'package:e_commerce_project/src/view_model/category_detail_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

@RoutePage()
class CategoryDetailPage extends StatelessWidget implements AutoRouteWrapper {
  CategoryDetailPage({super.key, required this.title});

  final String title;
  @override
  Widget wrappedRoute(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CategoryDetailViewModel(title: title),
      child: this,
    );
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  CartService cart = CartService();
  FavService fav = FavService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildCategoryDetail(),
    );
  }

  Widget _buildCategoryDetail() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: Consumer<CategoryDetailViewModel>(
          builder: (context, viewModel, child) => GridView.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 250,
                childAspectRatio: 0.48,
                crossAxisSpacing: 4,
                mainAxisSpacing: 4),
            itemCount: viewModel.products.length,
            itemBuilder: (BuildContext context, int index) {
              Product product = viewModel.products[index];
              return InkWell(
                onTap: () {
                  context.router.push(ProductDetailRoute(product: product));
                },
                child: Card(
                  elevation: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(
                        product.image,
                        fit: BoxFit.fill,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.name.length > 26
                                  ? product.name.substring(0, 24)
                                  : product.name,
                            ),
                            Text(product.category),
                            Row(
                              children: [
                                RatingBar.builder(
                                  initialRating: product.rate,
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemSize: 20.0,
                                  itemPadding:
                                      const EdgeInsets.symmetric(horizontal: 0),
                                  itemBuilder: (context, _) => const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  onRatingUpdate: (rating) {
                                    print(rating);
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    product.price.toStringAsFixed(2).toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: AppColor.orangeColor),
                                  ),
                                  InkWell(
                                    borderRadius: BorderRadius.circular(40),
                                    onTap: () {
                                      _auth.currentUser == null
                                          ? context.router
                                              .push(const LoginRoute())
                                          : fav.addFavData(
                                              name: product.name,
                                              price: product.price,
                                              category: product.category,
                                              image: product.image,
                                              rate: product.rate,
                                              color: product.color,
                                            );
                                    },
                                    child: const Padding(
                                      padding: EdgeInsets.all(6.0),
                                      child: CircleAvatar(
                                        backgroundColor: Colors.white,
                                        maxRadius: 14,
                                        child: Icon(
                                            Icons.favorite_border_outlined,
                                            size: 20),
                                      ),
                                    ),
                                  )
                                ])
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
