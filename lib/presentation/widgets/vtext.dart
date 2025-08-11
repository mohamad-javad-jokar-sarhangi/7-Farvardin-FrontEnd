import 'package:flutter/cupertino.dart';
import 'package:myfront/core/data_color.dart';

class VText{
  Widget PersianText(
    String text,
    double fontSize,
    {Color? color,
    TextAlign textAlign = TextAlign.right,
    TextDirection textDirection = TextDirection.rtl,
    }){
    return Text(
      text,
      textAlign: textAlign,
      textDirection: textDirection, 
      style: TextStyle(
        fontSize: fontSize, 
        color: color ?? DataColor.textColor,
        fontFamily: 'Vazir'
      ),
    );
  }
}
