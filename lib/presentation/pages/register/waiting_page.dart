import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:myfront/core/data_color.dart';
import 'package:myfront/presentation/widgets/gemini_button.dart';
import 'package:myfront/presentation/widgets/vtext.dart';

class WaitingPage extends StatefulWidget {
  const WaitingPage({super.key});

  @override
  State<WaitingPage> createState() => _WaitingPageState();
}

class _WaitingPageState extends State<WaitingPage> {
  @override
  Widget build(BuildContext context) {
    double screen_width = MediaQuery.of(context).size.width;
    double screen_height = MediaQuery.of(context).size.height;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: screen_width * 0.8,
            height: screen_width * 0.8,
            child: Lottie.asset('json assets/json (1).json')
          ),
          VText().PersianText(
            'برای برسی وضعیت  ثبت نام',
            screen_width * 0.07,
            color: DataColor.backgroundColor
          ),
          SizedBox(height: screen_height*0.04,) ,
          GeminiButton(
            text: ' رو دکمه کلید کنید ',
            onPressed: () {  },
            width: screen_width*0.7,
            height: screen_height * 0.07,
            radius: 25, 
            fontSize: screen_width * 0.07,
            buttonColor: DataColor.backgroundColor,
            textColor: DataColor.textColor,
            iconData: Icons.ads_click, // آیکون اضافه شد
            iconSize: 22, // اندازه آیکون کمی بزرگتر
            iconPadding: 12, // فاصله بیشتر
            iconPosition: IconPosition.leading, // موقعیت پیش‌فرض (ولی برای تاکید)
            elevation: 5, // سایه بیشتر
            shadowColor: Colors.purple.withOpacity(0.5), // رنگ سایه بنفش
            splashColor: Colors.purpleAccent.withOpacity(0.3),
            iconColor: DataColor.accentColor,
          ),


        ],
      ),
    );
  }
}