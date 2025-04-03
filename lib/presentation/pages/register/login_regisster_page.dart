import 'package:flutter/material.dart';
import 'package:myfront/core/data_color.dart';
import 'package:myfront/presentation/widgets/gemini_button.dart';
import 'package:myfront/presentation/widgets/gemini_dropdown.dart';
import 'package:myfront/presentation/widgets/gemini_text_box.dart';
import 'package:myfront/presentation/widgets/gemini_text_button.dart';
import 'package:myfront/presentation/widgets/text_box.dart';
import 'package:myfront/presentation/widgets/vtext.dart';
class LoginRegissterPage extends StatefulWidget {
  const LoginRegissterPage({super.key});

  @override
  State<LoginRegissterPage> createState() => _LoginRegissterPageState();
}

class _LoginRegissterPageState extends State<LoginRegissterPage> {
  TextEditingController user_name_controller = TextEditingController();
  TextEditingController user_phone_controller  = TextEditingController();

  
  String? _selectedRole;
  List<String> role = ["عادی", "راننده", "فروشنده", "شورا", "دهیار"];

  @override
  Widget build(BuildContext context) {
    double screen_width = MediaQuery.of(context).size.width;
    double screen_height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          SizedBox(height: screen_height * 0.035),
          Icon(Icons.account_circle_rounded, size: screen_height*0.25,color: DataColor.backgroundColor,),

          Padding(
            padding: EdgeInsets.all(screen_height*0.02),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GeminiTextBox(
                  name: 'نام کاربری',
                  width: screen_width * 0.6, // شاید نیاز به عرض بیشتری باشد
                  height: screen_height * 0.07,
                  radius: 15,
                  fontSize: 18,
                  containerColor: Colors.tealAccent.withOpacity(0.2), // یک رنگ نمونه
                  cursorColor: Colors.teal,
                  textColor: Colors.black87,
                  labelColor: Colors.black54,
                  tc: user_name_controller, // کنترلر شما
                  // شخصی‌سازی افکت‌های فوکوس:
                  focusBorderColor: DataColor.backgroundColor,
                  focusBorderWidth: 2.5,
                  focusIcon: Icons.person_outline, // آیکون نمونه
                  // focusIconColor: Colors.red, // در صورت نیاز به رنگ متفاوت برای آیکون
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(screen_height*0.02),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GeminiTextBox(
                  name: 'شماره تماس',
                  width: screen_width * 0.54,
                  height: screen_height * 0.07,
                  radius: 15,
                  fontSize: 18,
                  containerColor: Colors.tealAccent.withOpacity(0.2),
                  cursorColor: Colors.teal,
                  textColor: Colors.black87,
                  labelColor: Colors.black54,
                  tc: user_phone_controller,
                  focusBorderColor: DataColor.backgroundColor,
                  focusIcon: Icons.phone_outlined,
                ),
              ],
            ),
          ),
          SizedBox(height: screen_height * 0.025),
          GeminiDropdown(
            label: "نقش کاربر",
                  items: role,
                  dropdownColor: DataColor.tableRowEvenColor,
                  selectedValue: _selectedRole, // پاس دادن مقدار فعلی
                  onChanged: (String? newValue) {
                    // --- آپدیت State ---
                    setState(() {
                      _selectedRole = newValue;
                    });
                  },
                  width: screen_width * 0.7,
                  height: screen_height * 0.1,
                  fontSize: 16,
                  radius: 12,
                  selectedBorderColor: Colors.purple, // رنگ بوردر فعال
                  unselectedBorderColor: Colors.grey.shade400,
                  labelColor: Colors.grey.shade600,
                  iconData: Icons.person_outline, // آیکون دلخواه
                  iconColor: Colors.purpleAccent, // رنگ آیکون
                  hintText: "لطفا نقش خود را انتخاب کنید...", // متن راهنما
                  // dropdownColor: Colors.grey[200], // رنگ پس‌زمینه منو (اختیاری)
          ),
          SizedBox(height: screen_height * 0.035),
          GeminiButton(
            text: 'ثبت نام',
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
          SizedBox(height: screen_height * 0.035),
          GeminiTextButton(
            text: 'حسابی ندارید؟',
            clickableText: "وارد شوید",
            onTap: () {
              
            },
            color1: DataColor.accentColor,
            color2: DataColor.backgroundColor,
            textAlign: TextAlign.right,
          )
      
        ],
      ),
    );
  }
}