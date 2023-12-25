class Stock {
  int stockLevel;

  Stock({
    required this.stockLevel,
  });

  factory Stock.fromJson(Map<String, dynamic> json) => Stock(
        stockLevel: json["stockLevel"],
      );

  Map<String, dynamic> toJson() => {
        "stockLevel": stockLevel,
      };
}
