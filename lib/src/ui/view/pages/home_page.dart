import 'package:auto_route/auto_route.dart';
import 'package:e_commerce_project/src/ui/view/pages/product.dart';
import 'package:e_commerce_project/src/view_model/product_view_model.dart';
import 'package:e_commerce_project/src/services/cart_service.dart';
import 'package:e_commerce_project/src/services/fav_service.dart';
import 'package:e_commerce_project/src/store/auth_store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../di/injection.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final authStore = getIt.get<AuthStore>();

  CartService cart = CartService();
  FavService fav = FavService();

  @override
  Widget build(BuildContext context) {
    // ProductViewModel viewModel = Provider.of<ProductViewModel>(
    //   context,
    //   listen: false,
    // );
    return Scaffold(
        body: Consumer<ProductViewModel>(
      builder: (context, viewModel, child) => ListView.builder(
        itemCount: viewModel.listProduct.length,
        itemBuilder: (context, index) {
          Product product = viewModel.listProduct[index];
          return _buildCard(product);
        },
      ),
    ));
  }

  Widget _buildCard(Product product) {
    return Card(
      color: const Color.fromARGB(255, 82, 81, 81),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(flex: 2, child: Image.network(product.imageOne)),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.id.toString(),
                        style:
                            const TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      Text(
                        product.title,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
              authStore
                      .isUserLoggedIn // üye giriş yapmış ise sepete ve fava ekleme butonu görünürlüğü
                  ? Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            cart.addCartData(
                              id: product.id,
                              title: product.title,
                              price: product.price,
                              imageOne: product.imageOne,
                              // images:
                              //     "${productList[index].images.first.url}",
                              // price: "${productList[index].price.value}",
                            );
                          },
                          child: const Text('Add Cart'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            fav.addFavData(
                              id: product.id,
                              title: product.title,
                              price: product.price,
                              imageOne: product.imageOne,
                            );
                          },
                          child: const Text('Add Fav'),
                        ),
                      ],
                    )
                  : const SizedBox(
                      height: 10,
                    ),
            ],
          ),
        ],
      ),
    );
    // return Container(
    //   child: Card(
    //     color: const Color.fromARGB(255, 82, 81, 81),
    //     child: Row(
    //       children: [
    //         Expanded(flex: 2, child: Image.network(product.imageOne)),
    //         Expanded(
    //           flex: 3,
    //           child: Padding(
    //             padding: const EdgeInsets.all(8.0),
    //             child: Column(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //                 Text(
    //                   product.id.toString(),
    //                   style: const TextStyle(color: Colors.white, fontSize: 20),
    //                 ),
    //                 Text(
    //                   product.title,
    //                   style: const TextStyle(color: Colors.white, fontSize: 16),
    //                 ),
    //               ],
    //             ),
    //           ),
    //         ),
    //         authStore
    //                 .isUserLoggedIn // üye giriş yapmış ise sepete ve fava ekleme butonu görünürlüğü
    //             ? Row(
    //                 children: [
    //                   Expanded(
    //                     flex: 1,
    //                     child: ElevatedButton(
    //                       onPressed: () {
    //                         cart.addCartData(
    //                           id: product.id,
    //                           title: product.title,
    //                           price: product.price,
    //                           imageOne: "${product.imageOne}",
    //                           // images:
    //                           //     "${productList[index].images.first.url}",
    //                           // price: "${productList[index].price.value}",
    //                         );
    //                       },
    //                       child: const Text('Add Cart'),
    //                     ),
    //                   ),
    //                   // Expanded(
    //                   //   flex: 1,
    //                   //   child: ElevatedButton(
    //                   //     onPressed: () {
    //                   //       fav.addFavData(
    //                   //         name: productList[index].name,
    //                   //         code: productList[index].code,
    //                   //         images:
    //                   //             "${productList[index].images.first.url}",
    //                   //       );
    //                   //     },
    //                   //     child: const Text('Add Fav'),
    //                   //   ),
    //                   // ),
    //                 ],
    //               )
    //             : const SizedBox(
    //                 height: 10,
    //               ),
    //       ],
    //     ),
    //   ),
    // );
  }
}







// import 'dart:convert';
// import 'package:e_commerce_project/src/models/product_model.dart';
// import 'package:e_commerce_project/src/services/cart_service.dart';
// import 'package:e_commerce_project/src/services/fav_service.dart';
// import 'package:e_commerce_project/src/store/auth_store.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import '../../../di/injection.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   final authStore = getIt.get<AuthStore>();

//   CartService cart = CartService();
//   FavService fav = FavService();
//   List<Product> productList = [];
//   @override
//   void initState() {
//     super.initState();
//     setState(() {
//       _getProducts();
//     });
//   }

//   Future<void> _getProducts() async {
//     var url = Uri.parse(
//         'https://apidojo-hm-hennes-mauritz-v1.p.rapidapi.com/products/list?country=us&lang=en&currentpage=0&pagesize=30&categories=men_all&concepts=H%26M%20MAN');

//     var response = await http.get(
//       url,
//       headers: {
//         'X-RapidAPI-Key': 'c1c4c50604mshde0963d18280fdfp13a0d1jsneb65f17ad75d',
//         'X-RapidAPI-Host': 'apidojo-hm-hennes-mauritz-v1.p.rapidapi.com',
//       },
//     );

//     if (response.statusCode == 200) {
//       var responseBody = json.decode(response.body);

//       productList = parseProducts(responseBody['results']);

//       setState(() {});
//     } else {
//       print('Request failed with status: ${response.statusCode}.');
//     }
//   }

//   List<Product> parseProducts(dynamic collection) {
//     List<Product> products = [];

//     if (collection != null) {
//       for (var product in collection) {
//         products.add(Product.fromJson(product));
//       }
//     }

//     return products;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: productList.length,
//       itemBuilder: (context, index) {
//         return Card(
//           child: Column(
//             children: [
//               ListTile(
//                 title: Text(productList[index].name),
//                 subtitle: Text('Price: \$${productList[index].price.value}'),
//                 trailing: Image.network(productList[index].images.first.url),
//                 onTap: () => {
//                   // addCart.addCartData(
//                   //     name: productList[index].name,
//                   //     code: productList[index].code),
//                   // print("product-code: ${productList[index].code}"),
//                   // print(
//                   //     "product-images ${productList[index].images.first.url}")
//                 },
//               ),
//               authStore
//                       .isUserLoggedIn // üye giriş yapmış ise sepete ve fava ekleme butonu görünürlüğü
//                   ? Row(
//                       children: [
//                         Expanded(
//                           flex: 1,
//                           child: ElevatedButton(
//                             onPressed: () {
//                               cart.addCartData(
//                                 name: productList[index].name,
//                                 code: productList[index].code,
//                                 images:
//                                     "${productList[index].images.first.url}",
//                                 price: "${productList[index].price.value}",
//                               );
//                             },
//                             child: const Text('Add Cart'),
//                           ),
//                         ),
//                         Expanded(
//                           flex: 1,
//                           child: ElevatedButton(
//                             onPressed: () {
//                               fav.addFavData(
//                                 name: productList[index].name,
//                                 code: productList[index].code,
//                                 images:
//                                     "${productList[index].images.first.url}",
//                               );
//                             },
//                             child: const Text('Add Fav'),
//                           ),
//                         ),
//                       ],
//                     )
//                   : const SizedBox(
//                       height: 10,
//                     ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }








// import 'package:auto_route/auto_route.dart';
// import 'package:e_commerce_project/src/ui/view/pages/sign_up_page.dart';
// import 'package:e_commerce_project/src/common/toast.dart';
// import 'package:e_commerce_project/src/utils/navigation/router/app_router.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// // import 'package:fluttertoast/fluttertoast.dart';

// @RoutePage()
// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   SignUpPage sgn = SignUpPage();
//   // SignUpPage sgn = const SignUpPage();

//   @override
//   Widget build(BuildContext context) {
//     // final arguments = (ModalRoute.of(context)?.settings.arguments ??
//     //     <String, dynamic>{}) as Map;
//     return Scaffold(
//         appBar: AppBar(
//           automaticallyImplyLeading: false,
//           title: const Text("HomePage"),
//         ),
//         body: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Center(
//                 child: Text(
//               "Welcome Home buddy !",
//               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
//             )),
//             const SizedBox(
//               height: 30,
//             ),
//             GestureDetector(
//               onTap: () {
//                 FirebaseAuth.instance.signOut();
//                 context.router.replace(const LoginRoute());
//                 // Navigator.pushNamed(context, "/login");

//                 showToast(message: "Successfully signed out");
//               },
//               child: Container(
//                 height: 45,
//                 width: 100,
//                 decoration: BoxDecoration(
//                     color: Colors.blue,
//                     borderRadius: BorderRadius.circular(10)),
//                 child: const Center(
//                   child: Text(
//                     "Sign outt",
//                     style: TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 18),
//                   ),
//                 ),
//               ),
//             )
//           ],
//         ));
//   }
// }
