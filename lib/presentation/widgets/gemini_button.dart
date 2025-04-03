import 'package:flutter/material.dart';
import 'package:myfront/presentation/widgets/vtext.dart';
// import 'package:myfront/presentation/widgets/vtext.dart';

// --- کلاس VText (نمونه - از کد خودت استفاده کن) ---
// class VText {
//   Widget PersianText(String text, double fontSize, {Color? color}) {
//     return Text(
//       text,
//       textDirection: TextDirection.rtl,
//       style: TextStyle(
//         fontSize: fontSize,
//         color: color,
//         fontFamily: 'Vazir',
//       ),
//     );
//   }
// }
// --- پایان کلاس VText نمونه ---

enum IconPosition {
  leading,
  trailing,
}

class GeminiButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final double width;
  final double height;
  final double radius;
  final double fontSize;
  final Color buttonColor;
  final Color textColor; // رنگ متن در حالت فعال
  final Color splashColor;
  final Color? disabledButtonColor;
  final Color? disabledTextColor; // رنگ متن در حالت غیرفعال
  final double elevation;
  final Color? shadowColor;
  final IconData? iconData;
  final double? iconSize;
  final double iconPadding;
  final IconPosition iconPosition;

  // --- پارامترهای جدید برای رنگ آیکون ---
  final Color? iconColor; // **جدید:** رنگ آیکون در حالت فعال (پیش‌فرض: مثل textColor)
  final Color? disabledIconColor; // **جدید:** رنگ آیکون در حالت غیرفعال (پیش‌فرض: مثل disabledTextColor)

  const GeminiButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.width,
    required this.height,
    required this.radius,
    required this.fontSize,
    required this.buttonColor,
    required this.textColor,
    this.splashColor = Colors.white38,
    this.disabledButtonColor,
    this.disabledTextColor,
    this.elevation = 2.0,
    this.shadowColor,
    this.iconData,
    this.iconSize,
    this.iconPadding = 8.0,
    this.iconPosition = IconPosition.leading,
    this.iconColor, // **جدید**
    this.disabledIconColor, // **جدید**
  });

  @override
  Widget build(BuildContext context) {
    // تعیین اینکه دکمه فعال است یا نه
    final bool isEnabled = onPressed != null;

    // تعیین رنگ‌های حالت غیرفعال متن (اگر کاربر مشخص نکرده باشه)
    final effectiveDisabledTextColor = disabledTextColor ?? textColor.withOpacity(0.5);

    // --- تعیین رنگ *موثر* برای آیکون ---
    final Color? effectiveIconColor;
    if (isEnabled) {
      // در حالت فعال: اولویت با iconColor داده شده، وگرنه textColor اصلی
      effectiveIconColor = iconColor ?? textColor;
    } else {
      // در حالت غیرفعال: اولویت با disabledIconColor داده شده، وگرنه effectiveDisabledTextColor
      effectiveIconColor = disabledIconColor ?? effectiveDisabledTextColor;
    }
    // ------------------------------------

    // رنگ پس‌زمینه غیرفعال
    final effectiveDisabledButtonColor = disabledButtonColor ?? buttonColor.withOpacity(0.5);

    // اندازه پیش‌فرض آیکون
    final double effectiveIconSize = iconSize ?? (fontSize * 1.3);

    // رنگ *متن* بر اساس فعال/غیرفعال بودن
    final Color currentTextColor = isEnabled ? textColor : effectiveDisabledTextColor;

    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          // foregroundColor: حالا فقط روی *متن* تاثیر اصلی داره، چون رنگ آیکون رو جدا مدیریت می‌کنیم
          foregroundColor: currentTextColor,
          disabledBackgroundColor: effectiveDisabledButtonColor,
          disabledForegroundColor: effectiveDisabledTextColor, // رنگ متن غیرفعال
          elevation: elevation,
          shadowColor: shadowColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
          padding: EdgeInsets.zero,
          splashFactory: InkRipple.splashFactory,
        ).copyWith(
           overlayColor: MaterialStateProperty.resolveWith<Color?>(
             (Set<MaterialState> states) {
               if (states.contains(MaterialState.pressed) && isEnabled) {
                 return splashColor;
               }
               return null;
             },
           ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          textDirection: TextDirection.rtl,
          // ارسال رنگ آیکون محاسبه شده و اندازه آیکون به متد کمکی
          children: _buildButtonChildren(effectiveIconColor, effectiveIconSize),
        ),
      ),
    );
  }

  // متد کمکی برای ساخت لیست ویجت‌های داخل Row
  // حالا رنگ آیکون رو به عنوان ورودی می‌گیره
  List<Widget> _buildButtonChildren(Color? currentIconColor, double effectiveIconSize) {
    final textWidget = VText().PersianText(
      text,
      fontSize,
      // رنگ متن همچنان توسط foregroundColor استایل دکمه کنترل می‌شود
      color: null,
    );

    if (iconData == null) {
      return [textWidget];
    }

    // --- ساخت ویجت آیکون با رنگ محاسبه شده ---
    final iconWidget = Icon(
      iconData,
      size: effectiveIconSize,
      // رنگ آیکون رو اینجا به صورت دستی تنظیم می‌کنیم
      color: currentIconColor,
    );
    // ----------------------------------------

    final paddingWidget = SizedBox(width: iconPadding);

    if (iconPosition == IconPosition.leading) {
      return [iconWidget, paddingWidget, textWidget];
    } else {
      return [textWidget, paddingWidget, iconWidget];
    }
  }
}
