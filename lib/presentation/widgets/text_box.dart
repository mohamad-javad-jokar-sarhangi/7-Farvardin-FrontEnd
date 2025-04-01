import 'package:flutter/material.dart';
import 'package:myfront/presentation/widgets/vtext.dart';

class TextAreaBox extends StatelessWidget {
  final String name;
  final double width;
  final double minHeight;
  final double maxHeight;
  final double radius;
  final double fontSize;
  final Color containerColor;
  final Color cursorColor;
  final Color textColor;
  final Color labelColor;
  final TextEditingController tc;
  final String? hintText;

  const TextAreaBox({
    super.key,
    required this.name,
    required this.width,
    this.minHeight = 150,
    this.maxHeight = 300,
    required this.radius,
    required this.fontSize,
    required this.containerColor,
    required this.cursorColor,
    required this.textColor,
    required this.labelColor,
    required this.tc,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // برچسب در بالا سمت راست
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0, right: 4.0),
          child: VText().PersianText(' : $name', fontSize, color: labelColor),
        ),
        
        // باکس متن چند خطی
        Center(
          child: Container(
            width: width,
            constraints: BoxConstraints(
              minHeight: minHeight,
              maxHeight: maxHeight,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius),
              color: containerColor.withOpacity(0.5),
            ),
            child: TextField(
              controller: tc,
              textAlign: TextAlign.right,
              textDirection: TextDirection.rtl,
              maxLines: null, // تعداد خطوط نامحدود
              keyboardType: TextInputType.multiline, // برای پشتیبانی بهتر از Enter
              cursorColor: cursorColor,
              scrollPhysics: const BouncingScrollPhysics(), // افزودن حس اسکرول
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                hintText: hintText,
                hintTextDirection: TextDirection.rtl,
                hintStyle: TextStyle(
                  color: textColor.withOpacity(0.5),
                  fontFamily: 'Vazir',
                  fontSize: fontSize * 0.8,
                ),
              ),
              style: TextStyle(
                fontSize: fontSize,
                color: textColor,
                fontFamily: 'Vazir',
                height: 1.5, // فاصله بین خطوط
              ),
            ),
          ),
        ),
      ],
    );
  }
}





class TextBox extends StatelessWidget {
  final String name;
  final double width;
  final double height;
  final double radius;
  final double fontSize;
  final Color containerColor;
  final Color cursorColor;
  final Color textColor;
  final Color labelColor;
  final TextEditingController tc;

  const TextBox({
    super.key,
    required this.name,
    required this.width,
    required this.height,
    required this.radius,
    required this.fontSize,
    required this.containerColor,
    required this.cursorColor,
    required this.textColor,
    required this.labelColor,
    required this.tc
    });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            color: containerColor.withOpacity(0.5)
          ),
          child: TextField(
            controller: tc,
            textAlign: TextAlign.right,
            textDirection: TextDirection.rtl,
            maxLines: 1,
            cursorColor: cursorColor,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(right: height * 0.35),
            ),
            style: TextStyle(fontSize: fontSize , color: textColor,fontFamily: 'Vazir' ),
          ),
        ),
        SizedBox(width: height*0.01,),
        VText().PersianText(' : $name', fontSize , color: labelColor)
      ],
    );
  }
}
