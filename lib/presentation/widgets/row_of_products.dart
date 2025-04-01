import 'package:flutter/material.dart';
import 'package:myfront/core/data_color.dart';
import 'package:myfront/presentation/widgets/vtext.dart';

class RowOfProducts extends StatelessWidget {
  final String product_name;
  final String price;
  final String number;
  final VoidCallback onIconPressed;

  const RowOfProducts({
    super.key, 
    required this.product_name, 
    required this.price, 
    required this.number, 
    required this.onIconPressed
    });

  @override
  Widget build(BuildContext context) {
    double screen_width = MediaQuery.of(context).size.width;
    double screen_height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: screen_width * 0.8,
        height: screen_height * 0.2,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            DataColor.accentColor,
            DataColor.tableRowHoverColor,
          ]),
          borderRadius: BorderRadius.all(Radius.circular(25))
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: screen_width *0.38,
                height: screen_width *0.38,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: DataColor.backgroundColor,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(onPressed: onIconPressed,
                     icon: Icon(Icons.shopping_bag_rounded,
                     color: DataColor.accentColor,
                     size: screen_width * 0.2,
                     ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: VText().PersianText(' مشاهده و خرید ', screen_width * 0.05 ,),
                    ),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: screen_width *0.38,
                height: screen_width *0.38,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: DataColor.backgroundColor,
                ),
                child: Column(
                  textDirection: TextDirection.rtl,
                  children: [
                    SizedBox(height: screen_width * 0.05,),
                    VText().PersianText(' نام کالا : ${product_name}', screen_width * 0.05,),
                    SizedBox(height: screen_width * 0.02,),
                    VText().PersianText(' قیمت : ${price}', screen_width * 0.05,),
                    SizedBox(height: screen_width * 0.02,),
                    VText().PersianText(' تعداد : ${number}', screen_width * 0.05,),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}