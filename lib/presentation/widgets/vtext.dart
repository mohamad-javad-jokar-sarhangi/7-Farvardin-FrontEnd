import 'package:flutter/cupertino.dart';
import 'package:myfront/core/data_color.dart';

class VText{
  Widget PersianText(String text, double fontSize, {Color? color}){
    return Text(
      text, 
      style: TextStyle(
        fontSize: fontSize, 
        color: color ?? DataColor.textColor,
        fontFamily: 'Vazir'
      ),
    );
  }
}
