import 'package:flutter/material.dart';
import 'package:myfront/core/data_color.dart';
import 'package:myfront/presentation/widgets/vtext.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String name = '';
  String phone = '';
  String userType = '';
  String username = '';
  String password = '';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      // خواندن اطلاعات کاربر از SharedPreferences
      name = prefs.getString('user_name') ?? 'نام کاربر';
      phone = prefs.getString('phone') ?? 'شماره تلفن';
      userType = prefs.getString('role') ?? 'نوع کاربر';
      username = prefs.getString('username') ?? '';
      password = prefs.getString('password') ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: VText().PersianText('پروفایل', 30),
        centerTitle: true,
        backgroundColor: DataColor.backgroundColor,
        elevation: 0,
      ),
      // SingleChildScrollView به صفحه اضافه شده تا قابلیت اسکرول داشته باشد
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(), // برای اضافه کردن حس اسکرول بهتر
        child: Column(
          children: [
            // بخش بالایی با آواتار
            Container(
              padding: EdgeInsets.only(bottom: 15),
              width: double.infinity,
              decoration: BoxDecoration(
                color: DataColor.backgroundColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
              child: Column(
                children: [
                  SizedBox(height: 15),
                  
                  // نام کاربر زیر آواتار
                  VText().PersianText(name, screenWidth * 0.07, color: Colors.white),
                  SizedBox(height: 10),
                  
                  // اطلاعات اضافی مانند شماره تلفن و نوع کاربر
                  VText().PersianText(phone, screenWidth * 0.05, color: Colors.white.withOpacity(0.8)),
                  SizedBox(height: 5),
                  VText().PersianText(userType, screenWidth * 0.05, color: Colors.white.withOpacity(0.8)),
                  
                  // نمایش نام کاربری و رمز عبور اگر وجود داشته باشد
                  if(username.isNotEmpty) SizedBox(height: 5),
                  if(username.isNotEmpty) VText().PersianText('نام کاربری: $username', screenWidth * 0.04, color: Colors.white.withOpacity(0.7)),
                  if(password.isNotEmpty) SizedBox(height: 5),
                  if(password.isNotEmpty) VText().PersianText('رمز عبور: $password', screenWidth * 0.04, color: Colors.white.withOpacity(0.7)),
                ],
              ),
            ),
            // ادامه کد قبلی شما...
          ],
        ),
      ),
    );
  }
}
