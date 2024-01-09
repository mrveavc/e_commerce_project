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
class HomePage extends StatefulWidget implements AutoRouteWrapper {
  const HomePage({super.key});
  @override
  Widget wrappedRoute(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProductViewModel(),
      child: this,
    );
  }

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // final authStore = getIt.get<AuthStore>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  CartService cart = CartService();
  FavService fav = FavService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildProductCard(),
    );
  }

  // List<String> list = <String>['One', 'Two', 'Three', 'Four'];

  // Widget _buildDropdown() {
  //   String dropdownValue = list.first;

  //   return DropdownButton<String>(
  //     value: dropdownValue,
  //     icon: const Icon(Icons.arrow_downward),
  //     elevation: 16,
  //     style: const TextStyle(color: Colors.deepPurple),
  //     underline: Container(
  //       height: 2,
  //       color: Colors.deepPurpleAccent,
  //     ),
  //     onChanged: (String? value) {
  //       // This is called when the user selects an item.
  //       setState(() {
  //         dropdownValue = value!;
  //       });
  //     },
  //     items: list.map<DropdownMenuItem<String>>((String value) {
  //       return DropdownMenuItem<String>(
  //         value: value,
  //         child: Text(value),
  //       );
  //     }).toList(),
  //   );
  // }

  Widget _buildProductCard() {
    // List<String> list = <String>['One', 'Two', 'Three', 'Four'];

    // String dropdownValue = list.first;

    return Consumer<ProductViewModel>(
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
                        // Container(
                        //   color: viewModel.products[index].color ==,
                        //   child: Text(viewModel.products[index].color),
                        // ),
                        Text(viewModel.products[index].color),
                        Text(viewModel.products[index].rate.toString()),
                        // Row(
                        //   children: [
                        //     DropdownButton<String>(
                        //       value: dropdownValue,
                        //       icon: const Icon(Icons.arrow_downward),
                        //       elevation: 16,
                        //       style: const TextStyle(color: Colors.deepPurple),
                        //       underline: Container(
                        //         height: 2,
                        //         color: Colors.deepPurpleAccent,
                        //       ),
                        //       onChanged: (String? value) {
                        //         // This is called when the user selects an item.
                        //         setState(() {
                        //           dropdownValue = value!;
                        //         });
                        //       },
                        //       items: list.map<DropdownMenuItem<String>>(
                        //         (String value) {
                        //           return DropdownMenuItem<String>(
                        //             value: value,
                        //             child: Text(value),
                        //           );
                        //         },
                        //       ).toList(),
                        //     ),
                        //   ],
                        // ),
                        // Row(
                        //   children: [
                        //     DropdownButton(
                        //         items: Map.fromEntries(
                        //           viewModel.products[index].size.entries
                        //               .where((element) => element > 0),
                        //         ).entries.map((e) => e.value)
                        //         onChanged: onChanged)
                        //   ],
                        // ),

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
                                                  groupValue:
                                                      product.selectedSize,
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
                                        )

                                    // (e) => Flexible(
                                    //   child: ListView.builder(
                                    //     shrinkWrap: true,
                                    //     itemCount: e.key.length,
                                    //     itemBuilder: (context, index) {
                                    //       return Radio(
                                    //         value: index,
                                    //         groupValue: viewModel.selectedIndex,
                                    //         onChanged: (value) {
                                    //           viewModel.selectedIndex = value!;
                                    //         },
                                    //       );
                                    //     },

                                    //     // CheckboxListTile(
                                    //     //     title: Text(e.key),
                                    //     //     // value: viewModel.isChecked[index],
                                    //     //     value: viewModel.isChecked.indexOf(e.key),
                                    //     //     onChanged: (
                                    //     //       bool? value,
                                    //     //     ) {
                                    //     //       viewModel.isChecked = value!;
                                    //     //       print(e.key);
                                    //     //     }),
                                    //   ),
                                    // ),
                                    )
                                .toList()),
                        ElevatedButton(
                          onPressed: () async {
                            // cart.name == product.name
                            //     ? print('eşit')
                            //     : print('eşit değil');
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
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //       body: Consumer<ProductViewModel>(
  //     builder: (context, viewModel, child) => ListView.builder(
  //       itemCount: viewModel.listProduct.length,
  //       itemBuilder: (context, index) {
  //         Product product = viewModel.listProduct[index];
  //         return _buildCard(product);
  //       },
  //     ),
  //   ));
  // }

  // Widget _buildCard(Product product) {
  //   return Card(
  //     color: const Color.fromARGB(255, 82, 81, 81),
  //     child: Column(
  //       children: [
  //         Row(
  //           children: [
  //             Expanded(flex: 2, child: Image.network(product.imageOne)),
  //             Expanded(
  //               flex: 3,
  //               child: Padding(
  //                 padding: const EdgeInsets.all(8.0),
  //                 child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Text(
  //                       product.id.toString(),
  //                       style:
  //                           const TextStyle(color: Colors.white, fontSize: 20),
  //                     ),
  //                     Text(
  //                       product.title,
  //                       style:
  //                           const TextStyle(color: Colors.white, fontSize: 16),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //             _auth.currentUser != null
  //                 // .isUserLoggedIn // üye giriş yapmış ise sepete ve fava ekleme butonu görünürlüğü
  //                 ? Row(
  //                     children: [
  //                       ElevatedButton(
  //                         onPressed: () {
  //                           cart.addCartData(
  //                             id: product.id,
  //                             title: product.title,
  //                             price: product.price,
  //                             imageOne: product.imageOne,
  //                             // images:
  //                             //     "${productList[index].images.first.url}",
  //                             // price: "${productList[index].price.value}",
  //                           );
  //                         },
  //                         child: const Text('Add Cart'),
  //                       ),
  //                       ElevatedButton(
  //                         onPressed: () {
  //                           fav.addFavData(
  //                             id: product.id,
  //                             title: product.title,
  //                             price: product.price,
  //                             imageOne: product.imageOne,
  //                           );
  //                         },
  //                         child: const Text('Add Fav'),
  //                       ),
  //                     ],
  //                   )
  //                 : const SizedBox(
  //                     height: 10,
  //                   ),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  //   // return Container(
  //   //   child: Card(
  //   //     color: const Color.fromARGB(255, 82, 81, 81),
  //   //     child: Row(
  //   //       children: [
  //   //         Expanded(flex: 2, child: Image.network(product.imageOne)),
  //   //         Expanded(
  //   //           flex: 3,
  //   //           child: Padding(
  //   //             padding: const EdgeInsets.all(8.0),
  //   //             child: Column(
  //   //               crossAxisAlignment: CrossAxisAlignment.start,
  //   //               children: [
  //   //                 Text(
  //   //                   product.id.toString(),
  //   //                   style: const TextStyle(color: Colors.white, fontSize: 20),
  //   //                 ),
  //   //                 Text(
  //   //                   product.title,
  //   //                   style: const TextStyle(color: Colors.white, fontSize: 16),
  //   //                 ),
  //   //               ],
  //   //             ),
  //   //           ),
  //   //         ),
  //   //         authStore
  //   //                 .isUserLoggedIn // üye giriş yapmış ise sepete ve fava ekleme butonu görünürlüğü
  //   //             ? Row(
  //   //                 children: [
  //   //                   Expanded(
  //   //                     flex: 1,
  //   //                     child: ElevatedButton(
  //   //                       onPressed: () {
  //   //                         cart.addCartData(
  //   //                           id: product.id,
  //   //                           title: product.title,
  //   //                           price: product.price,
  //   //                           imageOne: "${product.imageOne}",
  //   //                           // images:
  //   //                           //     "${productList[index].images.first.url}",
  //   //                           // price: "${productList[index].price.value}",
  //   //                         );
  //   //                       },
  //   //                       child: const Text('Add Cart'),
  //   //                     ),
  //   //                   ),
  //   //                   // Expanded(
  //   //                   //   flex: 1,
  //   //                   //   child: ElevatedButton(
  //   //                   //     onPressed: () {
  //   //                   //       fav.addFavData(
  //   //                   //         name: productList[index].name,
  //   //                   //         code: productList[index].code,
  //   //                   //         images:
  //   //                   //             "${productList[index].images.first.url}",
  //   //                   //       );
  //   //                   //     },
  //   //                   //     child: const Text('Add Fav'),
  //   //                   //   ),
  //   //                   // ),
  //   //                 ],
  //   //               )
  //   //             : const SizedBox(
  //   //                 height: 10,
  //   //               ),
  //   //       ],
  //   //     ),
  //   //   ),
  //   // );
  // }
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
