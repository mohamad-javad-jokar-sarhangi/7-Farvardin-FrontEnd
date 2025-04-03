import 'package:flutter/material.dart';
import 'package:myfront/core/data_color.dart';
import 'package:myfront/presentation/widgets/gemini_button.dart';
import 'package:myfront/presentation/widgets/text_box.dart';
import 'package:myfront/presentation/widgets/vtext.dart';

class CreateEvent extends StatefulWidget {
  const CreateEvent({super.key});
  @override
  State<CreateEvent> createState() => _CreateEventState();
}


class _CreateEventState extends State<CreateEvent> {
  TextEditingController titel = TextEditingController();
  TextEditingController box = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double screen_width = MediaQuery.of(context).size.width;
    double screen_height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(height: screen_height * 0.01,),
          TextBox(
            name: ' موضوع ',
            width: screen_width * 0.7,
            height: screen_height * 0.07,
            containerColor: DataColor.backgroundColor,
            cursorColor: DataColor.accentColor,
            textColor: DataColor.textColor,
            labelColor: DataColor.backgroundColor,
            radius: 25,
            fontSize: 20, 
            tc: titel,
          ),
          SizedBox(height: screen_height * 0.01,),
          TextAreaBox(
            name: 'محتوا',
            width: screen_width * 0.9,
            hintText: '',
            maxHeight: screen_height * 0.5,
            minHeight: 10,
            containerColor: DataColor.backgroundColor,
            cursorColor: DataColor.accentColor,
            textColor: DataColor.textColor,
            labelColor: DataColor.backgroundColor,
            radius: 25,
            fontSize: 20, 
            tc: box,
          ),

          Padding(
            padding: EdgeInsets.all(screen_height*0.05),
            child: Center(
              child: GeminiButton(
                text: 'ثبت اطلاعیه',
                onPressed: () { /* ... */ },
                width: 200,
                height: 55,
                radius: 25, 
                fontSize: 16,
                buttonColor: DataColor.backgroundColor,
                textColor: DataColor.textColor,
                iconData: Icons.person_add_alt_1, // آیکون اضافه شد
                iconSize: 22, // اندازه آیکون کمی بزرگتر
                iconPadding: 12, // فاصله بیشتر
                iconPosition: IconPosition.leading, // موقعیت پیش‌فرض (ولی برای تاکید)
                elevation: 5, // سایه بیشتر
                shadowColor: Colors.purple.withOpacity(0.5), // رنگ سایه بنفش
                splashColor: Colors.purpleAccent.withOpacity(0.3),
                iconColor: DataColor.accentColor,
              ),
            ),
          ),
          SizedBox(height: screen_height * 0.3,),
        ],
      ),
    );
  }
}