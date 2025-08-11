import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:myfront/core/data_color.dart';
import 'package:myfront/presentation/blocs/users/user_bloc.dart';
import 'package:myfront/presentation/blocs/users/user_event.dart';
import 'package:myfront/presentation/blocs/users/user_state.dart';
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
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: BlocListener<UserBloc, UserState>(
        listener: (context, state) async {
          if (state is SendPhoneNumberSuccessful) {
            // ذخیره اطلاعات قبل از رفتن به صفحه بعدی
            final prefs = await SharedPreferences.getInstance();
            await prefs.setString('user_name', state.name);
            await prefs.setString('phone', state.phone);
            await prefs.setString('role', state.role);
            await prefs.setString('location', state.location);
            await prefs.setString('username', state.username);
            await prefs.setString('password', state.password);

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const Login(fromWaitingPage: true)),
            );
          } else if (state is SendPhoneNumberFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('خطا در بررسی وضعیت: ${state.error}')),
            );
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: screenWidth * 0.8,
              height: screenWidth * 0.8,
              child: Lottie.asset('json assets/json (1).json'),
            ),
            Center(
              child: VText().PersianText(
                'برای بررسی وضعیت ثبت‌نام',
                screenWidth * 0.07,
                color: DataColor.backgroundColor,
              ),
            ),
            SizedBox(height: screenHeight * 0.04),
            if (phone.isNotEmpty)
              VText().PersianText(
                'شماره تلفن: $phone',
                screenWidth * 0.04,
                color: Colors.black54,
              ),
            SizedBox(height: screenHeight * 0.02),
            GeminiButton(
              text: 'رو دکمه کلیک کنید',
              onPressed: () {
                if (phone.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'خطا: شماره تلفنی یافت نشد. لطفا دوباره ثبت‌نام کنید.',
                      ),
                    ),
                  );
                } else {
                  context.read<UserBloc>().add(SendPhoneNumberEvent(phone));
                }
              },
              width: screenWidth * 0.7,
              height: screenHeight * 0.07,
              radius: 25,
              fontSize: screenWidth * 0.07,
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
