import 'package:auto_route/auto_route.dart';
import 'package:e_commerce_project/src/common/toast.dart';
import 'package:e_commerce_project/src/models/product.dart';
import 'package:e_commerce_project/src/utils/navigation/router/app_router.dart';
import 'package:e_commerce_project/src/view_model/product_view_model.dart';
import 'package:e_commerce_project/src/services/cart_service.dart';
import 'package:e_commerce_project/src/services/fav_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

@RoutePage()
class HomePage extends StatelessWidget implements AutoRouteWrapper {
  HomePage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProductViewModel(),
      child: this,
    );
  }

  @override
  final FirebaseAuth _auth = FirebaseAuth.instance;

  CartService cart = CartService();
  FavService fav = FavService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Sizin İçin Seçtiklerimiz',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(height: 10),
            _buildProductCard(),
            const SizedBox(height: 10),
            const Text(
              'Erkek ',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            _buildCategoryCard("Erkek"),
            const SizedBox(height: 10),
            const Text(
              'Kadın ',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            _buildCategoryCard("Kadın"),
            const SizedBox(height: 10),
            const Text(
              'Çocuk ',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            _buildCategoryCard("Çocuk"),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryCard(String categoryName) {
    return Consumer<ProductViewModel>(
      builder: (context, viewModel, child) => Container(
        height: 310,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: viewModel.products
              .where((pro) => pro.category == categoryName)
              .length,
          itemBuilder: (BuildContext context, int index) {
            Product categoryProduct = viewModel.products
                .where((pro) => pro.category == categoryName)
                .toList()[index];

            return ChangeNotifierProvider.value(
                value: categoryProduct,
                child: InkWell(
                  onTap: () {
                    context.router
                        .push(ProductDetailRoute(product: categoryProduct));
                  },
                  child: SizedBox(
                    width: 150,
                    child: Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(
                            categoryProduct.image,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Column(
                              children: [
                                Text(
                                  categoryProduct.name.length > 30
                                      ? "${categoryProduct.name.substring(0, 30)}.."
                                      : categoryProduct.name,
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 53, 52, 52),
                                      fontWeight: FontWeight.w400),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      categoryProduct.price.toString(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    InkWell(
                                      borderRadius: BorderRadius.circular(40),
                                      onTap: () {
                                        _auth.currentUser == null
                                            ? context.router
                                                .push(const LoginRoute())
                                            : fav.addFavData(
                                                name: categoryProduct.name,
                                                price: categoryProduct.price,
                                                category:
                                                    categoryProduct.category,
                                                image: categoryProduct.image,
                                                rate: categoryProduct.rate,
                                                color: categoryProduct.color,
                                              );
                                      },
                                      child: const CircleAvatar(
                                        backgroundColor: Colors.white,
                                        maxRadius: 14,
                                        child: Icon(
                                            Icons.favorite_border_outlined,
                                            size: 20),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ));
          },
        ),
      ),
    );
  }

  Widget _buildProductCard() {
    return Consumer<ProductViewModel>(
      builder: (context, viewModel, child) => Container(
        height: 310,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: viewModel.products.length,
          itemBuilder: (BuildContext context, int index) {
            Product product = viewModel.products[index];
            return InkWell(
              onTap: () {
                context.router.push(ProductDetailRoute(product: product));
              },
              child: SizedBox(
                width: 150,
                child: Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(
                        product.image,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.name.length > 30
                                  ? "${product.name.substring(0, 30)}.."
                                  : product.name,
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 53, 52, 52),
                                  fontWeight: FontWeight.w400),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  product.price.toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
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
                                  child: const CircleAvatar(
                                    backgroundColor: Colors.white,
                                    maxRadius: 14,
                                    child: Icon(Icons.favorite_border_outlined,
                                        size: 20),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
