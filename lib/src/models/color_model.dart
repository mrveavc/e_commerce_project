class Color {
  String code;
  String text;
  String filterName;
  String hybrisCode;

  Color({
    required this.code,
    required this.text,
    required this.filterName,
    required this.hybrisCode,
  });

  factory Color.fromJson(Map<String, dynamic> json) => Color(
        code: json["code"],
        text: json["text"],
        filterName: json["filterName"],
        hybrisCode: json["hybrisCode"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "text": text,
        "filterName": filterName,
        "hybrisCode": hybrisCode,
      };
}
