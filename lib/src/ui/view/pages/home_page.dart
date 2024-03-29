import 'package:auto_route/auto_route.dart';
import 'package:e_commerce_project/gen/assets.gen.dart';
import 'package:e_commerce_project/src/models/product.dart';
import 'package:e_commerce_project/src/utils/navigation/router/app_router.dart';
import 'package:e_commerce_project/src/view_model/product_view_model.dart';
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

  FavService fav = FavService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTopImage(),
              const Text(
                'Sizin İçin Seçtiklerimiz',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const SizedBox(height: 10),
              _buildProductCard(),
              const SizedBox(height: 10),
              _build2Image(),
              const Text(
                'Erkek ',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              _buildCategoryCard(Categories.erkek),
              const SizedBox(height: 10),
              _buildImageSlider(),
              const Text(
                'Kadın ',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              _buildCategoryCard(Categories.kadin),
              const SizedBox(height: 10),
              const Text(
                'Çocuk ',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              _buildCategoryCard(Categories.cocuk),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryCard(Categories cat) {
    String catName = "";
    switch (cat) {
      case Categories.kadin:
        catName = "Kadın";
        break;
      case Categories.erkek:
        catName = "Erkek";
        break;
      case Categories.cocuk:
        catName = "Çocuk";
        break;
      default:
    }
    return Consumer<ProductViewModel>(
      builder: (context, viewModel, child) => Container(
        height: 310,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount:
              viewModel.products.where((pro) => pro.category == catName).length,
          itemBuilder: (BuildContext context, int index) {
            Product categoryProduct = viewModel.products
                .where((pro) => pro.category == catName)
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      categoryProduct.price
                                          .toStringAsFixed(2)
                                          .toString(),
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
                                  product.price.toStringAsFixed(2).toString(),
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

  Widget _buildImageSlider() {
    List<String> imagePaths = [
      Assets.images.kasvaSliderFoto1.path,
      Assets.images.kasvaSliderFoto2.path,
      Assets.images.kasvaSliderFoto3.path,
      Assets.images.kasvaSliderFoto4.path,
    ];

    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: SizedBox(
        height: 200,
        width: double.infinity,
        child: PageView.builder(
          itemCount: imagePaths.length,
          itemBuilder: (BuildContext context, int index) {
            return SizedBox(
              child: Image.asset(
                imagePaths[index % 4],
                fit: BoxFit.contain,
              ),
            );
          },
        ),
      ),
    );
  }

  Padding _build2Image() {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 300,
              child: Image.asset(
                Assets.images.kasva50Indirim.path,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              height: 300,
              child: Image.asset(
                Assets.images.kasva30Indiirm.path,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding _buildTopImage() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: SizedBox(
        width: double.infinity,
        height: 400,
        child: Image.asset(
          Assets.images.kasvaYeniYilMesaji.path,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

enum Categories { kadin, erkek, cocuk }
