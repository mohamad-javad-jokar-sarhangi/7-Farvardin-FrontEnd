import 'package:flutter/material.dart';
import 'package:myfront/core/data_color.dart';
import 'package:myfront/presentation/widgets/claude_box.dart';
import 'package:myfront/presentation/widgets/claude_button.dart';
import 'package:myfront/presentation/widgets/gemini_button.dart';
import 'package:myfront/presentation/widgets/gemini_text_box.dart';
import 'package:myfront/presentation/widgets/vtext.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController user_name = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screen_width = MediaQuery.of(context).size.width;
    double screen_height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: VText().PersianText('صفحه ورد به حساب کاربری', 20),
        centerTitle: true,
        backgroundColor: DataColor.backgroundColor,
      ),
      body: Container(
        width: screen_width,
        height: screen_height,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('img/white.jpg'), fit: BoxFit.cover)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GeminiTextBox(
              name: 'نام کاربری',
              tc: user_name,
              width: screen_width*0.5,
              height: screen_height*0.08,
              radius: 15,
              fontSize: 18,
              containerColor: DataColor.backgroundColor,
              cursorColor: DataColor.accentColor,
              textColor: DataColor.textColor,
              labelColor: DataColor.backgroundColor,
              focusBorderColor: DataColor.accentColor,
              focusIcon: Icons.account_box_rounded,
              focusIconColor: DataColor.accentColor,
              focusIconSize: 30,
            ),
            SizedBox(height: screen_height*0.05,),
            GeminiTextBox(
              name: 'رمز ورود',
              tc: password,
              width: screen_width*0.53,
              height: screen_height*0.08,
              radius: 15,
              fontSize: 18,
              containerColor: DataColor.backgroundColor,
              cursorColor: DataColor.accentColor,
              textColor: DataColor.textColor,
              labelColor: DataColor.backgroundColor,
              focusBorderColor: DataColor.accentColor,
              focusIcon: Icons.password,
              focusIconColor: DataColor.accentColor,
              focusIconSize: 30,
            ),
            SizedBox(height: screen_height*0.05,),
            GeminiButton(
              text: 'ورود به حساب', 
              onPressed: (){}, 
              width: screen_width*0.6, 
              height: screen_height*0.1,
              iconData: Icons.account_circle,
              iconColor: DataColor.accentColor,
              buttonColor: DataColor.backgroundColor,
              splashColor: DataColor.accentShadowColor,
              elevation: 30,
              iconSize: 30,
              fontSize: 20,
              radius: 25,
              shadowColor: DataColor.sidebarLinkBackgroundColor,     
            )
          ],
        ),
      ),
    );
  }
}