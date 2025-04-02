import 'package:flutter/material.dart';
import 'package:myfront/core/data_color.dart';
import 'package:myfront/presentation/widgets/vtext.dart';
import 'package:myfront/presentation/widgets/text_box.dart';

class CreateProducts extends StatefulWidget {
  const CreateProducts({super.key});

  @override
  State<CreateProducts> createState() => _CreateProductsState();
}

class _CreateProductsState extends State<CreateProducts> {
  TextEditingController kala_name = TextEditingController();
  TextEditingController kala_price = TextEditingController();
  TextEditingController kala_number = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double screen_width = MediaQuery.of(context).size.width;
    double screen_height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        SizedBox(height: screen_height * 0.02,),
        VText().PersianText(' ساخت محصولات ',screen_width * 0.065, color: DataColor.backgroundColor),
        SizedBox(height: screen_height * 0.05,),
        TextBox(
            name: ' نام کالا ',
            width: screen_width * 0.7,
            height: screen_height * 0.07,
            containerColor: DataColor.backgroundColor,
            cursorColor: DataColor.accentColor,
            textColor: DataColor.textColor,
            labelColor: DataColor.backgroundColor,
            radius: 25,
            fontSize: screen_width * 0.045,
            tc: kala_name,
          ),
          SizedBox(height: screen_height * 0.01,),
          TextBox(
            name: ' قیمت کالا ',
            width: screen_width * 0.7,
            height: screen_height * 0.07,
            containerColor: DataColor.backgroundColor,
            cursorColor: DataColor.accentColor,
            textColor: DataColor.textColor,
            labelColor: DataColor.backgroundColor,
            radius: 25,
            fontSize: screen_width * 0.045,
            tc: kala_price,
          ),
          SizedBox(height: screen_height * 0.01,),
          TextBox(
            name: ' تعداد کالا ',
            width: screen_width * 0.7,
            height: screen_height * 0.07,
            containerColor: DataColor.backgroundColor,
            cursorColor: DataColor.accentColor,
            textColor: DataColor.textColor,
            labelColor: DataColor.backgroundColor,
            radius: 25,
            fontSize: screen_width * 0.045, 
            tc: kala_number,
          ),
          SizedBox(height: screen_height * 0.05,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(onPressed: (){},
                  style: ElevatedButton.styleFrom(
                          backgroundColor: DataColor.backgroundColor, // رنگ پس زمینه دکمه
                          foregroundColor:  DataColor.accentColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          shadowColor: DataColor.backgroundColor,
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          elevation: 3,
                        ),
                  child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add_box_rounded, color: DataColor.accentColor , size: screen_width * 0.08,),
                            SizedBox(width: 10),
                            VText().PersianText(' ایجاد کالا ', screen_width * 0.05, color: DataColor.accentColor),
                          ],
                        ),
                  ),
          ),
      ],
    );
  }
}