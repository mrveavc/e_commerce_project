// import 'package:e_commerce_project/src/models/product_model.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class ProductApi {
//   static Future<List<Product>> getProducts() async {
//     List<Product> productList = [];

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
//     } else {
//       print('Request failed with status: ${response.statusCode}.');
//     }
//     return productList;
//   }

//   static List<Product> parseProducts(dynamic collection) {
//     List<Product> products = [];

//     if (collection != null) {
//       for (var product in collection) {
//         products.add(Product.fromJson(product));
//       }
//     }

//     return products;
//     // return Product.productFromJson(products);
//   }
// }
