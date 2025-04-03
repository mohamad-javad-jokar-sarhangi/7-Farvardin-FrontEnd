import 'package:flutter/material.dart';
import 'package:myfront/presentation/widgets/vtext.dart';
// import 'package:myfront/presentation/widgets/vtext.dart';

// --- کلاس VText (نمونه - از کد خودت استفاده کن) ---
// class VText {
//   Widget PersianText(String text, double fontSize, {Color? color, FontWeight? fontWeight}) {
//     // این نمونه ساده است، VText خودت رو جایگزین کن
//     return Text(
//       text,
//       textDirection: TextDirection.rtl, // مهم برای نمایش متن فارسی
//       style: TextStyle(
//         fontSize: fontSize,
//         color: color,
//         fontWeight: fontWeight,
//         fontFamily: 'Vazir', // فونت رو مطابق نیازت تنظیم کن
//       ),
//     );
//   }
// }
// --- پایان کلاس VText نمونه ---

class GeminiDropdown extends StatelessWidget {
  final String label; // متن لیبل
  final List<String> items; // لیست گزینه‌ها
  final String? selectedValue; // مقدار انتخاب شده فعلی (می‌تونه null باشه)
  final ValueChanged<String?>? onChanged; // تابعی که موقع انتخاب اجرا می‌شه
  final double width;
  final double height;
  final double radius;
  final double fontSize; // اندازه فونت لیبل و آیتم‌ها
  final Color selectedBorderColor;
  final Color unselectedBorderColor;
  final Color labelColor;
  final Color? iconColor; // رنگ آیکون (پیش‌فرض: مثل رنگ لیبل)
  final IconData? iconData; // آیکون اختیاری کنار لیبل
  final String? hintText; // متن راهنما وقتی مقداری انتخاب نشده
  final Color? dropdownColor; // رنگ پس‌زمینه منوی بازشونده
  final Color? fillColor; // رنگ پس‌زمینه داخل فیلد
  final bool filled; // آیا پس‌زمینه رنگی داشته باشد؟

  const GeminiDropdown({
    super.key,
    required this.label,
    required this.items,
    required this.selectedValue,
    required this.onChanged,
    required this.width,
    required this.height,
    this.radius = 10.0,
    this.fontSize = 16.0,
    this.selectedBorderColor = Colors.blue, // رنگ پیش‌فرض بوردر فعال
    this.unselectedBorderColor = Colors.grey, // رنگ پیش‌فرض بوردر غیرفعال
    this.labelColor = Colors.grey, // رنگ پیش‌فرض لیبل
    this.iconColor,
    this.iconData,
    this.hintText,
    this.dropdownColor, // معمولا همرنگ پس‌زمینه صفحه یا کمی متفاوت
    this.fillColor,
    this.filled = false,
  });

  @override
  Widget build(BuildContext context) {
    // رنگ آیکون: اگر مشخص نشده بود، همرنگ لیبل باشه
    final effectiveIconColor = iconColor ?? labelColor;

    return SizedBox(
      width: width,
      height: height,
      child: DropdownButtonFormField<String>(
        value: selectedValue,
        // **مهم:** items باید لیستی از DropdownMenuItem باشه
        items: items.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            // از VText برای نمایش آیتم‌ها در منو استفاده می‌کنیم
            // برای راست‌چین بودن متن داخل منو
            child: Align(
              alignment: Alignment.centerRight, // متن در آیتم‌ها راست‌چین باشه
              child: VText().PersianText(
                value,
                fontSize,
                // رنگ متن آیتم‌ها در منو (می‌تونی سفارشی کنی)
                color: Theme.of(context).textTheme.titleMedium?.color,
              ),
            ),
          );
        }).toList(),
        onChanged: onChanged,
        isExpanded: true, // باعث می‌شه عرض کامل SizedBox رو بگیره
        dropdownColor: dropdownColor, // رنگ پس‌زمینه خود منو
        // استایل متن مقدار انتخاب شده *داخل* دکمه
        style: TextStyle(
          fontSize: fontSize,
          color: Theme.of(context).textTheme.titleMedium?.color ?? Colors.black,
          fontFamily: 'Vazir',
        ),
        icon: Icon( // آیکون پیش‌فرض بازشونده (مثلث کوچک)
          Icons.arrow_drop_down,
          color: unselectedBorderColor, // همرنگ بوردر غیرفعال
        ),
        // --- بخش اصلی: استایل‌دهی شبیه GeminiTextBox ---
        decoration: InputDecoration(
          filled: filled,
          fillColor: fillColor,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0), // تنظیم پدینگ داخلی
          labelText: label,
          hintText: hintText, // نمایش متن راهنما
          labelStyle: TextStyle(
            fontSize: fontSize,
            color: labelColor,
            fontFamily: 'Vazir',
          ),
          hintStyle: TextStyle(
            fontSize: fontSize * 0.9, // کمی کوچکتر
            color: labelColor.withOpacity(0.7),
            fontFamily: 'Vazir',
          ),
          // استفاده از آیکون در سمت راست (چون RTL هستیم)
          prefixIcon: iconData != null
              ? Padding(
                  // کمی پدینگ برای آیکون
                  padding: const EdgeInsetsDirectional.only(start: 12.0, end: 8.0),
                  child: Icon(
                    iconData,
                    color: effectiveIconColor,
                    size: fontSize * 1.4, // کمی بزرگتر از فونت
                  ),
                )
              : null,
          prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0), // جلوگیری از فضای اضافه آیکون
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: BorderSide(color: unselectedBorderColor, width: 1.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: BorderSide(color: unselectedBorderColor, width: 1.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: BorderSide(color: selectedBorderColor, width: 1.5), // بوردر ضخیم‌تر موقع فعال بودن
          ),
          // می‌تونی errorBorder و ... رو هم اضافه کنی اگه نیاز به اعتبارسنجی داری
          floatingLabelBehavior: FloatingLabelBehavior.auto, // رفتار پیش‌فرض لیبل شناور
        ),
      ),
    );
  }
}
