import 'package:flutter/material.dart';
import 'package:myfront/core/data_color.dart';
import 'package:myfront/presentation/widgets/gemini_button.dart';
import 'package:myfront/presentation/widgets/vtext.dart';

class RowOfEvent extends StatefulWidget {
  final String eventTitle;
  final VoidCallback onIconPressed;
  const RowOfEvent({
    super.key ,
    required this.eventTitle,
    required this.onIconPressed,
  });

  @override
  State<RowOfEvent> createState() => _RowOfEventState();
}

class _RowOfEventState extends State<RowOfEvent> {
  @override
  Widget build(BuildContext context) {
    double screen_width = MediaQuery.of(context).size.width;
    double screen_height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: screen_width ,
        height: screen_height * 0.3,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            DataColor.accentColor,
            DataColor.tableRowHoverColor,
          ]),
          borderRadius: BorderRadius.all(Radius.circular(25))
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                     width: screen_width * 0.9,
                     height: screen_height * 0.1,
                     decoration: BoxDecoration(
                      color: DataColor.backgroundColor,
                      borderRadius: BorderRadius.all(Radius.circular(25))
                    ),
                    child: Center(child: VText().PersianText(' اطلاعیه :   ${widget.eventTitle} ', screen_height * 0.04,))
                    ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GeminiButton(
                  text: 'مشاهده اطلاعیه',
                  onPressed: widget.onIconPressed,
                  width: 200,
                  height: 55,
                  radius: 25, 
                  fontSize: 16,
                  buttonColor: DataColor.backgroundColor,
                  textColor: DataColor.textColor,
                  iconData: Icons.info, // آیکون اضافه شد
                  iconSize: 22, // اندازه آیکون کمی بزرگتر
                  iconPadding: 12, // فاصله بیشتر
                  iconPosition: IconPosition.leading, // موقعیت پیش‌فرض (ولی برای تاکید)
                  elevation: 5, // سایه بیشتر
                  shadowColor: Colors.purple.withOpacity(0.5), // رنگ سایه بنفش
                  splashColor: Colors.purpleAccent.withOpacity(0.3),
                  iconColor: DataColor.accentColor,
                )
              ],
            ),

            
          ],
        ),
      ),
    );
  }
}