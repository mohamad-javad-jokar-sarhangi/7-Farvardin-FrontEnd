import 'package:flutter/material.dart';
import 'package:myfront/core/data_color.dart';

class ClaudText {
  // متد اصلی برای متن فارسی
  Widget persianText(
    String text,
    double fontSize, {
    Color? color,
    FontWeight fontWeight = FontWeight.normal,
    TextAlign textAlign = TextAlign.right,
    int? maxLines,
    TextOverflow overflow = TextOverflow.clip,
    double? height,
    TextDecoration? decoration,
  }) {
    return Text(
      text,
      textDirection: TextDirection.rtl,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      style: TextStyle(
        fontSize: fontSize,
        color: color ?? DataColor.textColor,
        fontFamily: 'Vazir',
        fontWeight: fontWeight,
        height: height,
        decoration: decoration,
      ),
    );
  }

  // متد برای عناوین (تایتل)
  Widget title(String text, {Color? color, TextAlign textAlign = TextAlign.right}) {
    return persianText(
      text,
      18,
      color: color ?? DataColor.iconColor,
      fontWeight: FontWeight.bold,
      textAlign: textAlign,
    );
  }

  // متد برای متن زیرعنوان
  Widget subtitle(String text, {Color? color, TextAlign textAlign = TextAlign.right}) {
    return persianText(
      text,
      14,
      color: color ?? DataColor.iconColor.withOpacity(0.8),
      textAlign: textAlign,
    );
  }

  // متد برای متن توضیحات کوچک
  Widget caption(String text, {Color? color, TextAlign textAlign = TextAlign.right}) {
    return persianText(
      text,
      12,
      color: color ?? DataColor.iconColor.withOpacity(0.6),
      textAlign: textAlign,
    );
  }
}
