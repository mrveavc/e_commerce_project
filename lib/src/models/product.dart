import 'package:flutter/foundation.dart';

class Product with ChangeNotifier {
  String? id;
  String name;
  double price;
  String category;
  String image;
  double rate;
  String color;
  int quantityInCart = 1;

  Map<String, dynamic> size;
  String _selectedSize = '';

  String get selectedSize => _selectedSize;

  void set selectedSize(String value) {
    _selectedSize = value;
    notifyListeners();
  }

  Product(this.name, this.price, this.category, this.image, this.rate,
      this.color, this.size, this.quantityInCart);

  Product.fromMap(this.id, Map<String, dynamic> map)
      : name = map["name"] ?? "",
        price = double.tryParse((map["price"] ?? 0.0).toString()) ?? 0.0,
        category = map["category"] ?? "",
        image = (map["image"] as List<dynamic>).toList().isNotEmpty
            ? (map["image"] as List<dynamic>).toList()[0]
            : "",
        rate = double.tryParse((map["rate"] ?? 0.0).toString()) ?? 0.0,
        color = map["color"] ?? "",
        size = map["size"] as Map<String, dynamic>;

  Product.fromCartMap(this.id, Map<String, dynamic> map)
      : name = map["name"] ?? "",
        price = double.tryParse((map["price"] ?? 0.0).toString()) ?? 0.0,
        category = map["category"] ?? "",
        image = map["image"] ?? "",
        rate = double.tryParse((map["rate"] ?? 0.0).toString()) ?? 0.0,
        color = map["color"] ?? "",
        size = map["size"] ?? {},
        quantityInCart =
            int.tryParse((map["quantityInCart"] ?? 0).toString()) ?? 0;

  Product.fromCategoryMap(this.id, Map<String, dynamic> map)
      : name = map["name"] ?? "",
        price = double.tryParse((map["price"] ?? 0.0).toString()) ?? 0.0,
        category = map["category"] ?? "",
        image = (map["image"] as List<dynamic>).toList().isNotEmpty
            ? (map["image"] as List<dynamic>).toList()[0]
            : "",
        rate = double.tryParse((map["rate"] ?? 0.0).toString()) ?? 0.0,
        color = map["color"] ?? "",
        size = map["size"] as Map<String, dynamic>;

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "price": price,
      "category": category,
      "image": image,
      "color": color,
      "quantityInCart": quantityInCart,
      "size": size
    };
  }
}
