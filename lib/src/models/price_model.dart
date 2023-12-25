class Price {
  String currencyIso;
  double value;
  String priceType;
  String formattedValue;
  String type;

  Price({
    required this.currencyIso,
    required this.value,
    required this.priceType,
    required this.formattedValue,
    required this.type,
  });

  factory Price.fromJson(Map<String, dynamic> json) => Price(
        currencyIso: json["currencyIso"],
        value: json["value"]?.toDouble(),
        priceType: json["priceType"],
        formattedValue: json["formattedValue"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "currencyIso": currencyIso,
        "value": value,
        "priceType": priceType,
        "formattedValue": formattedValue,
        "type": type,
      };
}
