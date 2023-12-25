class VariantSize {
  int orderFilter;
  String filterCode;

  VariantSize({
    required this.orderFilter,
    required this.filterCode,
  });

  factory VariantSize.fromJson(Map<String, dynamic> json) => VariantSize(
        orderFilter: json["orderFilter"],
        filterCode: json["filterCode"],
      );

  Map<String, dynamic> toJson() => {
        "orderFilter": orderFilter,
        "filterCode": filterCode,
      };
}
