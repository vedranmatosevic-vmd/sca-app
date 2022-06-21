import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Style {
  ///////////
  // Colors
  ///////////
  static const black = Color(0xFF010000);
  static const grey = Color(0xFFe1e1e1);
  static const red = Color(0xFFe73725);
  static const white = Color(0xFFffffff);
  
  static Color getColor(BuildContext context, StyleColor styleColor) {
    switch (styleColor) {
      case StyleColor.black:
        return black;
        
      case StyleColor.grey:
        return grey;
        
      case StyleColor.red:
        return red;
        
      case StyleColor.white:
        return white;        
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
      case StyleText.textRegular:
        return TextStyle(
            fontFamily: "Roboto",
            fontWeight: FontWeight.w400,
            fontSize: 14,
            color: getColor(context, StyleColor.black)
        );
      case StyleText.textBold:
        return TextStyle(
            fontFamily: "Roboto",
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: getColor(context, StyleColor.black)
        );
      case StyleText.smallTextRegular:
        return TextStyle(
            fontFamily: "Roboto",
            fontWeight: FontWeight.w400,
            fontSize: 11,
            color: getColor(context, StyleColor.black)
        );
      case StyleText.bigTextBold:
        return TextStyle(
            fontFamily: "Roboto",
            fontWeight: FontWeight.w600,
            fontSize: 24,
            color: getColor(context, color ?? StyleColor.black)
        );
    }
  }
}

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
  /// **[weight]**: 400
  ///
  /// **[size]**: 14
  textRegular,

  /// **[font]**: Roboto
  ///
  /// **[weight]**: 600
  ///
  /// **[size]**: 14
  textBold,

  /// **[font]**: Roboto
  ///
  /// **[weight]**: 400
  ///
  /// **[size]**: 11
  smallTextRegular,

  /// **[font]**: Roboto
  ///
  /// **[weight]**: 600
  ///
  /// **[size]**: 24
  bigTextBold
}

enum StyleColor {
  black,
  grey,
  red,
  white
}