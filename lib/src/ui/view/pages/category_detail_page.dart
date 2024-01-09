import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_project/src/common/toast.dart';
import 'package:e_commerce_project/src/models/product.dart';
import 'package:e_commerce_project/src/services/cart_service.dart';
import 'package:e_commerce_project/src/services/fav_service.dart';
import 'package:e_commerce_project/src/utils/navigation/router/app_router.dart';
import 'package:e_commerce_project/src/view_model/category_detail_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

@RoutePage()
class CategoryDetailPage extends StatelessWidget implements AutoRouteWrapper {
  CategoryDetailPage({super.key, required this.title}) {
    print("------>" + title);
  }

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
    return Consumer<CategoryDetailViewModel>(
      builder: (context, viewModel, child) => ListView.builder(
        itemCount: viewModel.products.length,
        itemBuilder: (BuildContext context, int index) {
          List<Map<String, dynamic>> dataList = [];

          Product product = viewModel.products[index];
          return ChangeNotifierProvider.value(
              value: viewModel.products[index],
              child: Card(
                child: Column(
                  children: [
                    Column(
                      children: [
                        Image.network(
                          viewModel.products[index].image,
                          width: 50,
                        ),
                        Text(viewModel.products[index].name),
                        Text(viewModel.products[index].category),
                        Text(viewModel.products[index].price.toString()),
                        Text(viewModel.products[index].color),
                        Text(viewModel.products[index].rate.toString()),
                        Row(
                            children: Map.fromEntries(
                          viewModel.products[index].size.entries
                              .where((element) => element.value > 0),
                        )
                                .entries
                                .map((e) => Consumer<Product>(
                                      builder: (context, product, child) {
                                        return Row(
                                          children: [
                                            Text(e.key),
                                            Radio(
                                              value: e.key,
                                              groupValue: product.selectedSize,
                                              onChanged: (value) {
                                                product.selectedSize =
                                                    value as String;
                                                cart.selectedSize(value);
                                                print(value);
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    ))
                                .toList()),
                        ElevatedButton(
                          onPressed: () async {
                            product.selectedSize == ""
                                ? showToast(message: "Lütfen Beden Seçiniz.")
                                : _auth.currentUser == null
                                    ? context.router.push(LoginRoute())
                                    : await cart.addCartData(
                                        name: product.name,
                                        price: product.price,
                                        category: product.category,
                                        image: product.image,
                                        rate: product.rate,
                                        color: product.color,
                                        size: product.size,
                                        quantityInCart: product.quantityInCart);
                          },
                          child: Text("Add Cart"),
                        ),
                        ElevatedButton(
                            onPressed: () {
                              _auth.currentUser == null
                                  ? context.router.push(LoginRoute())
                                  : fav.addFavData(
                                      name: product.name,
                                      price: product.price,
                                      category: product.category,
                                      image: product.image,
                                      rate: product.rate,
                                      color: product.color,
                                    );
                              ;
                            },
                            child: Text("Add Fav"))
                      ],
                    )
                  ],
                ),
              ));
        },
      ),
    );
  }
}
