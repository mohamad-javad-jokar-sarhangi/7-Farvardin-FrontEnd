import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myfront/core/data_color.dart';
import 'package:myfront/presentation/blocs/users/user_bloc.dart';
import 'package:myfront/presentation/blocs/users/user_event.dart';
import 'package:myfront/presentation/blocs/users/user_state.dart';
import 'package:myfront/presentation/pages/home.dart';
import 'package:myfront/presentation/widgets/gemini_button.dart';
import 'package:myfront/presentation/widgets/gemini_text_box.dart';
import 'package:myfront/presentation/widgets/vtext.dart';
import 'package:quickalert/quickalert.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  final bool fromWaitingPage;
  const Login({super.key, this.fromWaitingPage = false});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController user_name_controller = TextEditingController();
  TextEditingController password_controller = TextEditingController();

  String username = '';
  String password = '';


  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username') ?? '';
      password = prefs.getString('password') ?? '';
    });
  }

  @override
void initState() {
  super.initState();
  if (widget.fromWaitingPage) {
    _loadUserData().then((_) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.warning,
          title: 'از اینجا اسکرین شات بگیر',
          widget: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'نام کاربری: $username\nرمز ورود: $password',
                textAlign: TextAlign.right,
                textDirection: TextDirection.rtl,
                style: TextStyle(fontFamily: 'Vazir', fontSize: 16),
              ),
            ],
          ),
          confirmBtnText: 'اگه گرفتی بزن بریم',
          confirmBtnColor: Colors.green,
        );
      });
    });
  }
}


  @override
  Widget build(BuildContext context) {
    double screen_width = MediaQuery.of(context).size.width;
    double screen_height = MediaQuery.of(context).size.height;

    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state is LoginSuccessful) {
          // هدایت به صفحه Home در صورت موفقیت
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => const Home()));
        } else if (state is LoginFailed) {
          // نمایش پیام خطا در صورت شکست
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error)),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: VText().PersianText('صفحه ورد به حساب کاربری', 20),
          centerTitle: true,
          backgroundColor: DataColor.backgroundColor,
        ),
        body: Container(
          width: screen_width,
          height: screen_height,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('img/white.jpg'), fit: BoxFit.cover),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // اگر از WaitingPage آمده باشیم، دیالوگ QuickAlert در initState نمایش داده شده است
              SizedBox(height: screen_height * 0.05),
              GeminiTextBox(
                name: 'نام کاربری',
                tc: user_name_controller,
                width: screen_width * 0.5,
                height: screen_height * 0.08,
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
              SizedBox(height: screen_height * 0.05),
              GeminiTextBox(
                name: 'رمز ورود',
                tc: password_controller,
                width: screen_width * 0.53,
                height: screen_height * 0.08,
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
              SizedBox(height: screen_height * 0.05),
              GeminiButton(
                text: 'ورود به حساب',
                onPressed: () {
                  context.read<UserBloc>().add(LoginUserEvent(
                        user_name_controller.text, // دریافت مقدار نام کاربری از TextBox
                        password_controller.text, // دریافت مقدار رمز عبور از TextBox
                      ));
                },
                width: screen_width * 0.6,
                height: screen_height * 0.1,
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
      ),
    );
  }
}