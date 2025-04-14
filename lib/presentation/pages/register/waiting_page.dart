import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:myfront/core/data_color.dart';
import 'package:myfront/presentation/blocs/users/user_bloc.dart';
import 'package:myfront/presentation/blocs/users/user_event.dart';
import 'package:myfront/presentation/blocs/users/user_state.dart';
import 'package:myfront/presentation/pages/home.dart';
import 'package:myfront/presentation/pages/register/login.dart';
import 'package:myfront/presentation/widgets/gemini_button.dart';
import 'package:myfront/presentation/widgets/vtext.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WaitingPage extends StatefulWidget {
  const WaitingPage({super.key});

  @override
  State<WaitingPage> createState() => _WaitingPageState();
}

class _WaitingPageState extends State<WaitingPage> {
  String phone = '';

  @override
  void initState() {
    super.initState();
    // خواندن شماره تلفن از SharedPreferences در زمان شروع صفحه
    _loadPhoneNumber();
  }

  Future<void> _loadPhoneNumber() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      phone = prefs.getString('phone_number') ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    double screen_width = MediaQuery.of(context).size.width;
    double screen_height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: BlocListener<UserBloc, UserState>(
        listener: (context, state) {
          if (state is SendPhoneNumberSuccessful) {
            // در صورت موفقیت، انتقال به صفحه اصلی
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const Login(fromWaitingPage: true)),
            );
          } else if (state is SendPhoneNumberFailure) {
            // نمایش پیام خطا
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('خطا در بررسی وضعیت: ${state.error}')),
            );
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: screen_width * 0.8,
              height: screen_width * 0.8,
              child: Lottie.asset('json assets/json (1).json')
            ),
            VText().PersianText(
              'برای برسی وضعیت ثبت نام',
              screen_width * 0.07,
              color: DataColor.backgroundColor
            ),
            SizedBox(height: screen_height * 0.04),
            // نمایش شماره تلفن ذخیره شده
            phone.isNotEmpty 
              ? VText().PersianText(
                  'شماره تلفن: $phone',
                  screen_width * 0.04,
                  color: Colors.black54
                )
              : Container(),
            SizedBox(height: screen_height * 0.02),
            GeminiButton(
              text: ' رو دکمه کلید کنید ',
              onPressed: () {
                if (phone.isEmpty) {
                  // اگر شماره تلفن خالی باشد، نمایش پیام خطا
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('خطا: شماره تلفنی یافت نشد. لطفا دوباره ثبت نام کنید.'),
                    ),
                  );
                } else {
                  // ارسال شماره تلفن به API از طریق Bloc
                  context.read<UserBloc>().add(SendPhoneNumberEvent(phone));
                }
              },
              width: screen_width * 0.7,
              height: screen_height * 0.07,
              radius: 25,
              fontSize: screen_width * 0.07,
              buttonColor: DataColor.backgroundColor,
              textColor: DataColor.textColor,
              iconData: Icons.ads_click,
              iconSize: 22,
              iconPadding: 12,
              iconPosition: IconPosition.leading,
              elevation: 5,
              shadowColor: Colors.purple.withOpacity(0.5),
              splashColor: Colors.purpleAccent.withOpacity(0.3),
              iconColor: DataColor.accentColor,
            ),
          ],
        ),
      ),
    );
  }
}
