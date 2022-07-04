import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum StyleText {
  /// **[font]**: Roboto
  ///
  /// **[weight]**: 600
  ///
  /// **[size]**: 16
  subTitle,

  /// **[font]**: Roboto
  ///
  /// **[weight]**: 500
  ///
  /// **[size]**: 14
  buttonText,

  /// **[font]**: Roboto
  ///
  /// **[weight]**: 500
  ///
  /// **[size]**: 16
  buttonTextWhite,

  /// **[font]**: Roboto
  ///
  /// **[weight]**: 400
  ///
  /// **[size]**: 14
  textRegular,

  /// **[font]**: Roboto
  ///
  /// **[weight]**: 700
  ///
  /// **[size]**: 12
  tabTextRegular,

  /// **[font]**: Roboto
  ///
  /// **[weight]**: 400
  ///
  /// **[size]**: 16
  formFieldTextNormal,

  /// **[font]**: Roboto
  ///
  /// **[weight]**: 600
  ///
  /// **[size]**: 14
  textBold,

  /// **[font]**: Roboto
  ///
  /// **[weight]**: 500
  ///
  /// **[size]**: 9
  ultraSmallTextRegular,

  /// **[font]**: Roboto
  ///
  /// **[weight]**: 400
  ///
  /// **[size]**: 11
  smallTextRegular,

  /// **[font]**: Roboto
  ///
  /// **[weight]**: 700
  ///
  /// **[size]**: 11
  smallTextBold,

  /// **[font]**: Roboto
  ///
  /// **[weight]**: 200
  ///
  /// **[size]**: 16
  bigTextRegular,

  /// **[font]**: Roboto
  ///
  /// **[weight]**: 600
  ///
  /// **[size]**: 20
  bigTextBold,

  /// **[font]**: Roboto
  ///
  /// **[weight]**: 700
  ///
  /// **[size]**: 36
  ultraBigText
}

enum StyleColor {
  black,
  grey,
  red,
  white,
  green,
  orange,
  darkBlue,
  yellow,
  lightBlue,
  greyBorder
}

class Style {
  ///////////
  // Colors
  ///////////
  static const colorBlack = Color(0xFF333132);
  static const colorGrey = Color(0xFFc0c0c0);
  static const colorRed = Color(0xFFe42f34);
  static const colorDarkRed = Color(0xFFa13130);
  static const colorWhite = Color(0xFFffffff);
  static const colorGreen = Color(0xff04d96d);
  static const colorOrange = Color(0xfffc9b6d);
  static const colorDarkBlue = Color(0xff1382d3);
  static const colorLightBlue = Color(0xff1d548a);
  static const colorYellow = Color(0xfffcdd21);
  static const colorGreyBorder = Color(0xffc0c0c0);

  static Color getColor(BuildContext context, StyleColor styleColor) {
    switch (styleColor) {
      case StyleColor.black:
        return colorBlack;
        
      case StyleColor.grey:
        return colorGrey;
        
      case StyleColor.red:
        return colorRed;
        
      case StyleColor.white:
        return colorWhite;

      case StyleColor.green:
        return colorGreen;

      case StyleColor.orange:
        return colorOrange;

      case StyleColor.darkBlue:
        return colorDarkBlue;

      case StyleColor.yellow:
        return colorYellow;

      case StyleColor.lightBlue:
        return colorLightBlue;

      case StyleColor.greyBorder:
        return colorGreyBorder;

      default:
        throw UnimplementedError();
    }
  }

  //////////////////
  // TEXT STYLES
  //////////////////
  static TextStyle getTextStyle(BuildContext context, StyleText styleText, [StyleColor? color]) {
    switch (styleText) {
      case StyleText.subTitle:
        return TextStyle(
          fontFamily: "Roboto",
          fontWeight: FontWeight.w600,
          fontSize: 16,
          color: getColor(context, color ?? StyleColor.black)
        );
      case StyleText.buttonText:
        return TextStyle(
          fontFamily: "Roboto",
          fontWeight: FontWeight.w500,
          fontSize: 14,
          color: getColor(context, color ?? StyleColor.black)
        );
      case StyleText.buttonTextWhite:
        return TextStyle(
            fontFamily: "Roboto",
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: getColor(context, StyleColor.white)
        );
      case StyleText.textRegular:
        return TextStyle(
            fontFamily: "Roboto",
            fontWeight: FontWeight.w400,
            fontSize: 14,
            color: getColor(context, StyleColor.black)
        );
      case StyleText.tabTextRegular:
        return TextStyle(
            fontFamily: "Roboto",
            fontWeight: FontWeight.w700,
            fontSize: 12,
            color: getColor(context, color ?? StyleColor.black)
        );
      case StyleText.formFieldTextNormal:
        return TextStyle(
            fontFamily: "Roboto",
            fontWeight: FontWeight.w400,
            fontSize: 16,
            color: getColor(context, StyleColor.black)
        );
      case StyleText.textBold:
        return TextStyle(
            fontFamily: "Roboto",
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: getColor(context, color ?? StyleColor.black)
        );
      case StyleText.ultraSmallTextRegular:
        return TextStyle(
            fontFamily: "Roboto",
            fontWeight: FontWeight.w500,
            fontSize: 9,
            color: getColor(context, color ?? StyleColor.black)
        );
      case StyleText.smallTextRegular:
        return TextStyle(
            fontFamily: "Roboto",
            fontWeight: FontWeight.w400,
            fontSize: 11,
            color: getColor(context, color ?? StyleColor.black)
        );
      case StyleText.smallTextBold:
        return TextStyle(
            fontFamily: "Roboto",
            fontWeight: FontWeight.w700,
            fontSize: 11,
            color: getColor(context, color ?? StyleColor.black)
        );
      case StyleText.bigTextRegular:
        return TextStyle(
            fontFamily: "Roboto",
            fontWeight: FontWeight.w200,
            fontSize: 16,
            color: getColor(context, color ?? StyleColor.black)
        );
      case StyleText.bigTextBold:
        return TextStyle(
            fontFamily: "Roboto",
            fontWeight: FontWeight.w600,
            fontSize: 20,
            color: getColor(context, color ?? StyleColor.black)
        );
      case StyleText.ultraBigText:
        return TextStyle(
            fontFamily: "Roboto",
            fontWeight: FontWeight.w700,
            fontSize: 30,
            color: getColor(context, color ?? StyleColor.black)
        );
    }
  }
}
/// Flutter icons MyFlutterApp
/// Copyright (C) 2022 by original authors @ fluttericon.com, fontello.com
/// This font was generated by FlutterIcon.com, which is derived from Fontello.
///
/// To use this font, place it in your fonts/ directory and include the
/// following in your pubspec.yaml
///
/// flutter:
///   fonts:
///    - family:  MyFlutterApp
///      fonts:
///       - asset: fonts/MyFlutterApp.ttf
///
///
/// * Material Design Icons, Copyright (C) Google, Inc
///         Author:    Google
///         License:   Apache 2.0 (https://www.apache.org/licenses/LICENSE-2.0)
///         Homepage:  https://design.google.com/icons/
///

class MyFlutterApp {
  MyFlutterApp._();

  static const _kFontFam = 'MyFlutterApp';
  static const String? _kFontPkg = null;

  static const IconData card = IconData(0xe800, fontFamily: _kFontFam, fontPackage: _kFontPkg);
}