import 'package:auto_route/auto_route.dart';
import 'package:e_commerce_project/src/common/toast.dart';
import 'package:e_commerce_project/src/constant/_colors.dart';
import 'package:e_commerce_project/src/models/product.dart';
import 'package:e_commerce_project/src/services/cart_service.dart';
import 'package:e_commerce_project/src/services/fav_service.dart';
import 'package:e_commerce_project/src/utils/navigation/router/app_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

@RoutePage()
class ProductDetailPage extends StatelessWidget {
  ProductDetailPage({super.key, required this.product});
  final Product product;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  CartService cart = CartService();
  FavService fav = FavService();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
        value: product,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(product.image),
                  const SizedBox(
                    height: 5,
                  ),
                  InkWell(
                    onTap: () {
                      context.router.push(CategoryDetailRoute(
                          title: product.category.toLowerCase()));
                    },
                    child: Text(product.category.toUpperCase(),
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.blue[600])),
                  ),
                  Text(
                    product.name,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 60, 60, 60)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        product.rate.toString(),
                        style: const TextStyle(fontSize: 15),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      RatingBar.builder(
                        initialRating: product.rate,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemSize: 20.0,
                        itemPadding:
                            const EdgeInsets.symmetric(horizontal: 4.0),
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
                    height: 10,
                  ),
                  Row(
                    children: [
                      const Text(
                        "Renk: ",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 60, 60, 60)),
                      ),
                      Text(
                        product.color,
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Color.fromARGB(255, 60, 60, 60)),
                      ),
                    ],
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text(
                              'Beden',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Row(
                                children: Map.fromEntries(
                              product.size.entries
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
                                                  groupValue:
                                                      product.selectedSize,
                                                  onChanged: (value) {
                                                    product.selectedSize =
                                                        value as String;
                                                    cart.selectedSize(value);
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        ))
                                    .toList()),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    height: 2,
                    color: AppColor.dividerColor,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "${product.price.toStringAsFixed(2).toString()} TL",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: AppColor.orangeColor),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            flex: 1,
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(
                                    width: 2.0, color: Colors.black),
                              ),
                              onPressed: () {
                                _auth.currentUser == null
                                    ? context.router.push(const LoginRoute())
                                    : fav.addFavData(
                                        name: product.name,
                                        price: product.price,
                                        category: product.category,
                                        image: product.image,
                                        rate: product.rate,
                                        color: product.color,
                                      );
                              },
                              child: const Text(
                                'Favorilere Ekle',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            flex: 1,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.black),
                              ),
                              onPressed: () {
                                product.selectedSize == ""
                                    ? showToast(
                                        message: "Lütfen Beden Seçiniz.")
                                    : _auth.currentUser == null
                                        ? context.router
                                            .push(const LoginRoute())
                                        : cart.addCartData(
                                            name: product.name,
                                            price: product.price,
                                            category: product.category,
                                            image: product.image,
                                            rate: product.rate,
                                            color: product.color,
                                            size: product.size,
                                            quantityInCart:
                                                product.quantityInCart);
                              },
                              child: const Text(
                                'Sepete Ekle',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ]),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
