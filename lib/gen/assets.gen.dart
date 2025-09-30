/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import

import 'package:flutter/widgets.dart';

class $AssetsFontsGen {
  const $AssetsFontsGen();

  /// File path: assets/fonts/IRANSansXFaNum-Black.ttf
  String get iRANSansXFaNumBlack => 'assets/fonts/IRANSansXFaNum-Black.ttf';

  /// File path: assets/fonts/IRANSansXFaNum-Bold.ttf
  String get iRANSansXFaNumBold => 'assets/fonts/IRANSansXFaNum-Bold.ttf';

  /// File path: assets/fonts/IRANSansXFaNum-DemiBold.ttf
  String get iRANSansXFaNumDemiBold =>
      'assets/fonts/IRANSansXFaNum-DemiBold.ttf';

  /// File path: assets/fonts/IRANSansXFaNum-ExtraBold.ttf
  String get iRANSansXFaNumExtraBold =>
      'assets/fonts/IRANSansXFaNum-ExtraBold.ttf';

  /// File path: assets/fonts/IRANSansXFaNum-Light.ttf
  String get iRANSansXFaNumLight => 'assets/fonts/IRANSansXFaNum-Light.ttf';

  /// File path: assets/fonts/IRANSansXFaNum-Medium.ttf
  String get iRANSansXFaNumMedium => 'assets/fonts/IRANSansXFaNum-Medium.ttf';

  /// File path: assets/fonts/IRANSansXFaNum-Regular.ttf
  String get iRANSansXFaNumRegular => 'assets/fonts/IRANSansXFaNum-Regular.ttf';

  /// File path: assets/fonts/IRANSansXFaNum-Thin.ttf
  String get iRANSansXFaNumThin => 'assets/fonts/IRANSansXFaNum-Thin.ttf';

  /// File path: assets/fonts/IRANSansXFaNum-UltraLight.ttf
  String get iRANSansXFaNumUltraLight =>
      'assets/fonts/IRANSansXFaNum-UltraLight.ttf';

  /// File path: assets/fonts/PoppinsBlack.ttf
  String get poppinsBlack => 'assets/fonts/PoppinsBlack.ttf';

  /// File path: assets/fonts/PoppinsBold.ttf
  String get poppinsBold => 'assets/fonts/PoppinsBold.ttf';

  /// File path: assets/fonts/PoppinsExtraLight.ttf
  String get poppinsExtraLight => 'assets/fonts/PoppinsExtraLight.ttf';

  /// File path: assets/fonts/PoppinsLight.ttf
  String get poppinsLight => 'assets/fonts/PoppinsLight.ttf';

  /// File path: assets/fonts/PoppinsMedium.ttf
  String get poppinsMedium => 'assets/fonts/PoppinsMedium.ttf';

  /// File path: assets/fonts/PoppinsRegular.ttf
  String get poppinsRegular => 'assets/fonts/PoppinsRegular.ttf';

  /// File path: assets/fonts/PoppinsSemiBold.ttf
  String get poppinsSemiBold => 'assets/fonts/PoppinsSemiBold.ttf';

  /// File path: assets/fonts/PoppinsThin.ttf
  String get poppinsThin => 'assets/fonts/PoppinsThin.ttf';

  /// File path: assets/fonts/Shoma.ttf
  String get shoma => 'assets/fonts/Shoma.ttf';

  /// File path: assets/fonts/ZAR.ttf
  String get zar => 'assets/fonts/ZAR.ttf';

  /// File path: assets/fonts/ZARB.ttf
  String get zarb => 'assets/fonts/ZARB.ttf';

  /// File path: assets/fonts/icomoon.ttf
  String get icomoon => 'assets/fonts/icomoon.ttf';
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/logo.png
  AssetGenImage get logo => const AssetGenImage('assets/images/logo.png');
}

class Assets {
  Assets._();

  static const $AssetsFontsGen fonts = $AssetsFontsGen();
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

  String get path => _assetName;

  String get keyName => _assetName;
}
