import 'package:e_commerce_project/src/models/color_model.dart';
import 'package:e_commerce_project/src/models/gallery_image_model.dart';
import 'package:e_commerce_project/src/models/price_model.dart';

class Article {
  String code;
  String name;
  List<GalleryImage> images;
  String pk;
  Price whitePrice;
  List<GalleryImage> logoPicture;
  List<GalleryImage> normalPicture;
  bool visible;
  int numbersOfPieces;
  String ticket;
  bool dummy;
  double ecoTaxValue;
  bool redirectToPdp;
  bool comingSoon;
  Color color;
  String rgbColor;
  String? genArticle;
  String turnToSku;
  String? videoId;
  bool? plpVideo;

  Article({
    required this.code,
    required this.name,
    required this.images,
    required this.pk,
    required this.whitePrice,
    required this.logoPicture,
    required this.normalPicture,
    required this.visible,
    required this.numbersOfPieces,
    required this.ticket,
    required this.dummy,
    required this.ecoTaxValue,
    required this.redirectToPdp,
    required this.comingSoon,
    required this.color,
    required this.rgbColor,
    required this.genArticle,
    required this.turnToSku,
    required this.videoId,
    required this.plpVideo,
  });

  factory Article.fromJson(Map<String, dynamic> json) => Article(
        code: json["code"],
        name: json["name"],
        images: List<GalleryImage>.from(
            json["images"].map((x) => GalleryImage.fromJson(x))),
        pk: json["pk"],
        whitePrice: Price.fromJson(json["whitePrice"]),
        logoPicture: List<GalleryImage>.from(
            json["logoPicture"].map((x) => GalleryImage.fromJson(x))),
        normalPicture: List<GalleryImage>.from(
            json["normalPicture"].map((x) => GalleryImage.fromJson(x))),
        visible: json["visible"],
        numbersOfPieces: json["numbersOfPieces"],
        ticket: json["ticket"],
        dummy: json["dummy"],
        ecoTaxValue: json["ecoTaxValue"],
        redirectToPdp: json["redirectToPdp"],
        comingSoon: json["comingSoon"],
        color: Color.fromJson(json["color"]),
        rgbColor: json["rgbColor"],
        genArticle: json["genArticle"],
        turnToSku: json["turnToSku"],
        videoId: json["videoId"],
        plpVideo: json["plpVideo"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "name": name,
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
        "pk": pk,
        "whitePrice": whitePrice.toJson(),
        "logoPicture": List<dynamic>.from(logoPicture.map((x) => x.toJson())),
        "normalPicture":
            List<dynamic>.from(normalPicture.map((x) => x.toJson())),
        "visible": visible,
        "numbersOfPieces": numbersOfPieces,
        "ticket": ticket,
        "dummy": dummy,
        "ecoTaxValue": ecoTaxValue,
        "redirectToPdp": redirectToPdp,
        "comingSoon": comingSoon,
        "color": color.toJson(),
        "rgbColor": rgbColor,
        "genArticle": genArticle,
        "turnToSku": turnToSku,
        "videoId": videoId,
        "plpVideo": plpVideo,
      };
}
