class GalleryImage {
  String url;
  String baseUrl;

  GalleryImage({
    required this.url,
    required this.baseUrl,
  });

  factory GalleryImage.fromJson(Map<String, dynamic> json) => GalleryImage(
        url: json["url"],
        baseUrl: json["baseUrl"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "baseUrl": baseUrl,
      };
}
