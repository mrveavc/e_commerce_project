class Product {
  int id; // firebase e atılacağı için string yapılacak
  String title;
  double price;
  String description;
  String category;
  String imageOne;
  double rate;
  int count;

  Product.fromMap(Map<String, dynamic> map)
      : id = map["id"] ?? 0,
        title = map["title"] ?? "",
        price = double.tryParse((map["price"] ?? 0.0).toString()) ?? 0.0,
        description = map["description"] ?? "",
        category = map["category"] ?? "",
        imageOne = map["imageOne"] ?? "",
        rate = double.tryParse((map["rate"] ?? 0.0).toString()) ?? 0.0,
        count = map["count"] ?? 0;
}
