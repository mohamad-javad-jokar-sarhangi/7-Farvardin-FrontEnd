import 'package:flutter/material.dart';
import 'package:myfront/core/data_color.dart';
import 'package:myfront/presentation/widgets/vtext.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String name = 'محمد جواد';
  String phone = '0911431694';
  @override
  Widget build(BuildContext context) {
    double screen_width = MediaQuery.of(context).size.width;
    double screen_height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: VText().PersianText('پروفایل', 30),
        centerTitle: true,
        backgroundColor: DataColor.backgroundColor,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: screen_height* 0.05),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: screen_width*0.5,
                  height: screen_height *0.09,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: DataColor.backgroundColor
                  ),
                  child: Center(child: VText().PersianText(': نام کاربری ', screen_width * 0.07)),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: screen_width*0.9,
                  height: screen_height *0.09,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: DataColor.backgroundColor
                  ),
                  child: Center(child: VText().PersianText(' $name ', screen_width * 0.08)),
                ),
              ],
            ),
          ),
          
          SizedBox(height: screen_height* 0.15),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: screen_width*0.6,
                  height: screen_height *0.09,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: DataColor.backgroundColor
                  ),
                  child: Center(child: VText().PersianText(': شماره تماس ', screen_width * 0.07)),
                ),
              ],
            ),
          ), 

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: screen_width*0.9,
                  height: screen_height *0.09,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: DataColor.backgroundColor
                  ),
                  child: Center(child: VText().PersianText(' $phone ', screen_width * 0.08)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}