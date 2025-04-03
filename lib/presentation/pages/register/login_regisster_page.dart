import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myfront/presentation/blocs/users/user_bloc.dart';
import 'package:myfront/presentation/blocs/users/user_event.dart';
import 'package:myfront/presentation/blocs/users/user_state.dart';
import 'package:myfront/core/data_color.dart';
import 'package:myfront/presentation/pages/register/waiting_page.dart';
import 'package:myfront/presentation/widgets/gemini_button.dart';
import 'package:myfront/presentation/widgets/gemini_dropdown.dart';
import 'package:myfront/presentation/widgets/gemini_text_box.dart';

class LoginRegissterPage extends StatefulWidget {
  const LoginRegissterPage({super.key});

  @override
  State<LoginRegissterPage> createState() => _LoginRegissterPageState();
}

class _LoginRegissterPageState extends State<LoginRegissterPage> {
  TextEditingController user_name_controller = TextEditingController();
  TextEditingController user_phone_controller = TextEditingController();

  String? _selectedRole;
  List<String> role = ["عادی", "راننده", "فروشنده", "شورا", "دهیار"];

  @override
  Widget build(BuildContext context) {
    double screen_width = MediaQuery.of(context).size.width;
    double screen_height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: BlocListener<UserBloc, UserState>(
        listener: (context, state) {
          if (state is UserLoading) {
            // نمایش دیالوگ بارگذاری
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return const AlertDialog(
                  content: Row(
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(width: 20),
                      Text("در حال ثبت نام..."),
                    ],
                  ),
                );
              },
            );
          } else if (state is UserAdded) {
            // حذف دیالوگ بارگذاری
            Navigator.of(context).pop();

            // در صورت موفقیت، رفتن به صفحه انتظار تأیید
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const WaitingPage()),
            );
          } else if (state is UserError) {
            // حذف دیالوگ بارگذاری
            Navigator.of(context).pop();

            // نمایش پیام خطا
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('خطا در ثبت نام: ${state.error}')),
            );
          }
        },
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: screen_height * 0.035),
              Icon(
                Icons.account_circle_rounded,
                size: screen_height * 0.25,
                color: DataColor.backgroundColor,
              ),

              Padding(
                padding: EdgeInsets.all(screen_height * 0.02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GeminiTextBox(
                      name: 'نام کاربر',
                      width: screen_width * 0.6,
                      height: screen_height * 0.07,
                      radius: 15,
                      fontSize: 18,
                      containerColor: Colors.tealAccent.withOpacity(0.2),
                      cursorColor: Colors.teal,
                      textColor: Colors.black87,
                      labelColor: Colors.black54,
                      tc: user_name_controller,
                      focusBorderColor: DataColor.backgroundColor,
                      focusBorderWidth: 2.5,
                      focusIcon: Icons.person_outline,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(screen_height * 0.02),
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
                selectedValue: _selectedRole,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedRole = newValue;
                  });
                },
                width: screen_width * 0.7,
                height: screen_height * 0.1,
                fontSize: 16,
                radius: 12,
                selectedBorderColor: Colors.purple,
                unselectedBorderColor: Colors.grey.shade400,
                labelColor: Colors.grey.shade600,
                iconData: Icons.person_outline,
                iconColor: Colors.purpleAccent,
                hintText: "لطفا نقش خود را انتخاب کنید...",
              ),
              SizedBox(height: screen_height * 0.035),
              GeminiButton(
                text: 'ثبت نام',
                onPressed: () {
                  if (user_name_controller.text.isNotEmpty &&
                      user_phone_controller.text.isNotEmpty &&
                      _selectedRole != null) {
                    // افزودن کاربر به کمک Bloc
                    context.read<UserBloc>().add(
                          AddUser(
                            user_name_controller.text,
                            user_phone_controller.text,
                            _selectedRole!,
                          ),
                        );
                  } else {
                    // پیام خطا در صورت عدم پر شدن فیلدها
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('خطا در ثبت اطلاعات'),
                          content: const Text(
                              'لطفاً تمامی فیلدها را صحیح وارد کنید.'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('باشه'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                width: screen_width * 0.7,
                height: screen_height * 0.1,
                radius: 25,
                fontSize: screen_width * 0.07,
                buttonColor: DataColor.backgroundColor,
                textColor: DataColor.textColor,
                iconData: Icons.person_add_alt_1,
                iconSize: 22,
                iconPadding: 12,
                iconPosition: IconPosition.leading,
                elevation: 5,
                shadowColor: Colors.purple.withOpacity(0.5),
                splashColor: Colors.purpleAccent.withOpacity(0.3),
                iconColor: DataColor.accentColor,
              ),
              SizedBox(height: screen_height * 0.035),
            ],
          ),
        ),
      ),
    );
  }
}
