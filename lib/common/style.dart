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
  bigTextBold
}

enum StyleColor {
  black,
  grey,
  red,
  white,
  green,
  orange
}

class Style {
  ///////////
  // Colors
  ///////////
  static const colorBlack = Color(0xFF010000);
  static const colorGrey = Color(0xFFe1e1e1);
  static const colorRed = Color(0xFFe73725);
  static const colorWhite = Color(0xFFffffff);
  static const colorGreen = Color(0xff04d96d);
  static const colorOrange = Color(0xfffc9b6d);

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
          color: getColor(context, StyleColor.black)
        );
      case StyleText.buttonText:
        return TextStyle(
          fontFamily: "Roboto",
          fontWeight: FontWeight.w500,
          fontSize: 14,
          color: getColor(context, StyleColor.black)
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
            color: getColor(context, StyleColor.black)
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
    }
  }
}