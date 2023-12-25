import 'dart:convert';
import 'package:e_commerce_project/src/models/article_model.dart';
import 'package:e_commerce_project/src/models/gallery_image_model.dart';
import 'package:e_commerce_project/src/models/price_model.dart';
import 'package:e_commerce_project/src/models/stock_model.dart';
import 'package:e_commerce_project/src/models/variant_size_model.dart';

class Product {
  Product productFromJson(String str) => Product.fromJson(json.decode(str));

  String productToJson(Product data) => json.encode(data.toJson());
  String code;
  String name;
  Stock stock;
  Price price;
  List<GalleryImage> images;
  List<dynamic> categories;
  String pk;
  Price whitePrice;
  List<Article> articles;
  bool visible;
  List<String> concept;
  int numbersOfPieces;
  Article defaultArticle;
  bool sale;
  List<VariantSize> variantSizes;
  List<dynamic> swatches;
  List<String> articleCodes;
  String ticket;
  String searchEngineProductId;
  bool dummy;
  String linkPdp;
  String categoryName;
  List<String> rgbColors;
  List<String> articleColorNames;
  double ecoTaxValue;
  int swatchesTotal;
  bool showPriceMarker;
  bool redirectToPdp;
  String mainCategoryCode;
  bool comingSoon;
  String brandName;
  List<GalleryImage> galleryImages;
  List<String> allArticleCodes;
  List<String> allArticleImages;
  List<String> allArticleBaseImages;

  Product({
    required this.code,
    required this.name,
    required this.stock,
    required this.price,
    required this.images,
    required this.categories,
    required this.pk,
    required this.whitePrice,
    required this.articles,
    required this.visible,
    required this.concept,
    required this.numbersOfPieces,
    required this.defaultArticle,
    required this.sale,
    required this.variantSizes,
    required this.swatches,
    required this.articleCodes,
    required this.ticket,
    required this.searchEngineProductId,
    required this.dummy,
    required this.linkPdp,
    required this.categoryName,
    required this.rgbColors,
    required this.articleColorNames,
    required this.ecoTaxValue,
    required this.swatchesTotal,
    required this.showPriceMarker,
    required this.redirectToPdp,
    required this.mainCategoryCode,
    required this.comingSoon,
    required this.brandName,
    required this.galleryImages,
    required this.allArticleCodes,
    required this.allArticleImages,
    required this.allArticleBaseImages,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        code: json["code"],
        name: json["name"],
        stock: Stock.fromJson(json["stock"]),
        price: Price.fromJson(json["price"]),
        images: List<GalleryImage>.from(
            json["images"].map((x) => GalleryImage.fromJson(x))),
        categories: List<dynamic>.from(json["categories"].map((x) => x)),
        pk: json["pk"],
        whitePrice: Price.fromJson(json["whitePrice"]),
        articles: List<Article>.from(
            json["articles"].map((x) => Article.fromJson(x))),
        visible: json["visible"],
        concept: List<String>.from(json["concept"].map((x) => x)),
        numbersOfPieces: json["numbersOfPieces"],
        defaultArticle: Article.fromJson(json["defaultArticle"]),
        sale: json["sale"],
        variantSizes: List<VariantSize>.from(
            json["variantSizes"].map((x) => VariantSize.fromJson(x))),
        swatches: List<dynamic>.from(json["swatches"].map((x) => x)),
        articleCodes: List<String>.from(json["articleCodes"].map((x) => x)),
        ticket: json["ticket"],
        searchEngineProductId: json["searchEngineProductId"],
        dummy: json["dummy"],
        linkPdp: json["linkPdp"],
        categoryName: json["categoryName"],
        rgbColors: List<String>.from(json["rgbColors"].map((x) => x)),
        articleColorNames:
            List<String>.from(json["articleColorNames"].map((x) => x)),
        ecoTaxValue: json["ecoTaxValue"],
        swatchesTotal: json["swatchesTotal"],
        showPriceMarker: json["showPriceMarker"],
        redirectToPdp: json["redirectToPdp"],
        mainCategoryCode: json["mainCategoryCode"],
        comingSoon: json["comingSoon"],
        brandName: json["brandName"],
        galleryImages: List<GalleryImage>.from(
            json["galleryImages"].map((x) => GalleryImage.fromJson(x))),
        allArticleCodes:
            List<String>.from(json["allArticleCodes"].map((x) => x)),
        allArticleImages:
            List<String>.from(json["allArticleImages"].map((x) => x)),
        allArticleBaseImages:
            List<String>.from(json["allArticleBaseImages"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "name": name,
        "stock": stock.toJson(),
        "price": price.toJson(),
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
        "categories": List<dynamic>.from(categories.map((x) => x)),
        "pk": pk,
        "whitePrice": whitePrice.toJson(),
        "articles": List<dynamic>.from(articles.map((x) => x.toJson())),
        "visible": visible,
        "concept": List<dynamic>.from(concept.map((x) => x)),
        "numbersOfPieces": numbersOfPieces,
        "defaultArticle": defaultArticle.toJson(),
        "sale": sale,
        "variantSizes": List<dynamic>.from(variantSizes.map((x) => x.toJson())),
        "swatches": List<dynamic>.from(swatches.map((x) => x)),
        "articleCodes": List<dynamic>.from(articleCodes.map((x) => x)),
        "ticket": ticket,
        "searchEngineProductId": searchEngineProductId,
        "dummy": dummy,
        "linkPdp": linkPdp,
        "categoryName": categoryName,
        "rgbColors": List<dynamic>.from(rgbColors.map((x) => x)),
        "articleColorNames":
            List<dynamic>.from(articleColorNames.map((x) => x)),
        "ecoTaxValue": ecoTaxValue,
        "swatchesTotal": swatchesTotal,
        "showPriceMarker": showPriceMarker,
        "redirectToPdp": redirectToPdp,
        "mainCategoryCode": mainCategoryCode,
        "comingSoon": comingSoon,
        "brandName": brandName,
        "galleryImages":
            List<dynamic>.from(galleryImages.map((x) => x.toJson())),
        "allArticleCodes": List<dynamic>.from(allArticleCodes.map((x) => x)),
        "allArticleImages": List<dynamic>.from(allArticleImages.map((x) => x)),
        "allArticleBaseImages":
            List<dynamic>.from(allArticleBaseImages.map((x) => x)),
      };
}
