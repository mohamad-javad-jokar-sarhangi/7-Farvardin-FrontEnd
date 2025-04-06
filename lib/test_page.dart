import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  TextEditingController textController = TextEditingController(); // کنترلر برای گرفتن ورودی از کاربر
  String displayText = 'هنوز چیزی ذخیره نشده است'; // متن پیش‌فرض برای نمایش

  // تابع ذخیره داده در SharedPreferences
  Future<void> saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('saved_text', textController.text); // ذخیره متن وارد شده
  }

  // تابع خواندن داده از SharedPreferences
  Future<void> loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedText = prefs.getString('saved_text'); // خواندن داده ذخیره‌شده
    setState(() {
      displayText = storedText ?? 'چیزی ذخیره نشده است'; // تنظیم مقدار ذخیره‌شده یا متن پیش‌فرض
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SharedPreferences Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // باکس متن برای وارد کردن داده
            TextField(
              controller: textController, // متصل به کنترلر
              decoration: const InputDecoration(
                labelText: 'متن خود را وارد کنید',
                border: OutlineInputBorder(), // حاشیه مستطیلی
              ),
            ),
            const SizedBox(height: 20), // فاصله بین المان‌ها

            // دکمه ذخیره
            ElevatedButton(
              onPressed: saveData, // اتصال به تابع ذخیره
              child: const Text('ذخیره داده'),
            ),
            const SizedBox(height: 10),

            // دکمه نمایش
            ElevatedButton(
              onPressed: loadData, // اتصال به تابع نمایش داده
              child: const Text('نمایش داده ذخیره‌شده'),
            ),
            const SizedBox(height: 20),

            // متن نمایش داده‌شده
            Text(
              displayText, // مقدار ذخیره شده یا متن پیش‌فرض
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
