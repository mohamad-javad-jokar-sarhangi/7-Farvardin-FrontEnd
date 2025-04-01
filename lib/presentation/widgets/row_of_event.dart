import 'package:flutter/material.dart';
import 'package:myfront/core/data_color.dart';
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
                ElevatedButton(onPressed: widget.onIconPressed,
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
                child: VText().PersianText('برای مشاهده جزئیات کیلک کنید', screen_height*0.03),
                ),
              ],
            ),

            
          ],
        ),
      ),
    );
  }
}