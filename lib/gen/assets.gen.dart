/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/ic_bell_fill.svg
  String get icBellFill => 'assets/icons/ic_bell_fill.svg';

  /// File path: assets/icons/ic_category.svg
  String get icCategory => 'assets/icons/ic_category.svg';

  /// File path: assets/icons/ic_favorite.svg
  String get icFavorite => 'assets/icons/ic_favorite.svg';

  /// File path: assets/icons/ic_favorite_empty.svg
  String get icFavoriteEmpty => 'assets/icons/ic_favorite_empty.svg';

  /// File path: assets/icons/ic_home.svg
  String get icHome => 'assets/icons/ic_home.svg';

  /// File path: assets/icons/ic_person.svg
  String get icPerson => 'assets/icons/ic_person.svg';

  /// File path: assets/icons/ic_search.svg
  String get icSearch => 'assets/icons/ic_search.svg';

  /// File path: assets/icons/ic_shopping_cart.svg
  String get icShoppingCart => 'assets/icons/ic_shopping_cart.svg';

  /// File path: assets/icons/ic_user.svg
  String get icUser => 'assets/icons/ic_user.svg';

  /// List of all assets
  List<String> get values => [
        icBellFill,
        icCategory,
        icFavorite,
        icFavoriteEmpty,
        icHome,
        icPerson,
        icSearch,
        icShoppingCart,
        icUser
      ];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/avatar.jpg
  AssetGenImage get avatar => const AssetGenImage('assets/images/avatar.jpg');

  /// File path: assets/images/cocuk-giyim.jpg
  AssetGenImage get cocukGiyim =>
      const AssetGenImage('assets/images/cocuk-giyim.jpg');

  /// File path: assets/images/erkek-giyim.jpg
  AssetGenImage get erkekGiyim =>
      const AssetGenImage('assets/images/erkek-giyim.jpg');

  /// File path: assets/images/kadin-giyim.jpg
  AssetGenImage get kadinGiyim =>
      const AssetGenImage('assets/images/kadin-giyim.jpg');

  /// File path: assets/images/kasva-30-indiirm.png
  AssetGenImage get kasva30Indiirm =>
      const AssetGenImage('assets/images/kasva-30-indiirm.png');

  /// File path: assets/images/kasva-50-indirim.png
  AssetGenImage get kasva50Indirim =>
      const AssetGenImage('assets/images/kasva-50-indirim.png');

  /// File path: assets/images/kasva-slider-foto-1.jpeg
  AssetGenImage get kasvaSliderFoto1 =>
      const AssetGenImage('assets/images/kasva-slider-foto-1.jpeg');

  /// File path: assets/images/kasva-slider-foto-2.png
  AssetGenImage get kasvaSliderFoto2 =>
      const AssetGenImage('assets/images/kasva-slider-foto-2.png');

  /// File path: assets/images/kasva-slider-foto3.jpg
  AssetGenImage get kasvaSliderFoto3 =>
      const AssetGenImage('assets/images/kasva-slider-foto3.jpg');

  /// File path: assets/images/kasva-slider-foto4.jpg
  AssetGenImage get kasvaSliderFoto4 =>
      const AssetGenImage('assets/images/kasva-slider-foto4.jpg');

  /// File path: assets/images/kasva-yeni-yil-mesaji.png
  AssetGenImage get kasvaYeniYilMesaji =>
      const AssetGenImage('assets/images/kasva-yeni-yil-mesaji.png');

  /// File path: assets/images/logo.jpg
  AssetGenImage get logo => const AssetGenImage('assets/images/logo.jpg');

  /// List of all assets
  List<AssetGenImage> get values => [
        avatar,
        cocukGiyim,
        erkekGiyim,
        kadinGiyim,
        kasva30Indiirm,
        kasva50Indirim,
        kasvaSliderFoto1,
        kasvaSliderFoto2,
        kasvaSliderFoto3,
        kasvaSliderFoto4,
        kasvaYeniYilMesaji,
        logo
      ];
}

class Assets {
  Assets._();

  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
