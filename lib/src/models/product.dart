// class Product {
//   int id; // firebase e atılacağı için string yapılacak
//   String title;
//   double price;
//   String description;
//   String category;
//   String imageOne;
//   double rate;
//   int count;

//   Product.fromMap(Map<String, dynamic> map)
//       : id = map["id"] ?? 0,
//         title = map["title"] ?? "",
//         price = double.tryParse((map["price"] ?? 0.0).toString()) ?? 0.0,
//         description = map["description"] ?? "",
//         category = map["category"] ?? "",
//         imageOne = map["imageOne"] ?? "",
//         rate = double.tryParse((map["rate"] ?? 0.0).toString()) ?? 0.0,
//         count = map["count"] ?? 0;
// }

import 'package:flutter/foundation.dart';

class Product with ChangeNotifier {
  String? id;
  String name;
  double price;
  String category;
  String image;
  double rate;
  String color;
  Map<String, dynamic> size;
  Product(this.name, this.price, this.category, this.image, this.rate,
      this.color, this.size);

  Product.fromMap(this.id, Map<String, dynamic> map)
      :
        // id = map["id"] ?? 0,
        name = map["name"] ?? "",
        price = double.tryParse((map["price"] ?? 0.0).toString()) ?? 0.0,
        // description = map["description"] ?? "",
        category = map["category"] ?? "",
        image = (map["image"] as List<dynamic>).toList().isNotEmpty
            ? (map["image"] as List<dynamic>).toList()[0]
            : "",
        rate = double.tryParse((map["rate"] ?? 0.0).toString()) ?? 0.0,
        color = map["color"] ?? "",
        size = map["size"] as Map<String, dynamic>;

  // Map<String, dynamic> toMap() {
  //   return {
  //     "name": name,
  //     "price": price,
  //     "category": category,
  //     "image": image,
  //   };
  // }
}
