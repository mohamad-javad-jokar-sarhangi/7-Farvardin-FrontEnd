import 'package:flutter/material.dart';
import 'package:myfront/presentation/widgets/vtext.dart';

enum IconPosition {
  leading,
  trailing,
}

class ClaudeButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  
  // پارامترهای ثابت
  final Color buttonColor;
  final Color textColor;
  final Color splashColor;
  final Color? disabledButtonColor;
  final Color? disabledTextColor;
  final Color? shadowColor;
  final IconData? iconData;
  final IconPosition iconPosition;
  final Color? iconColor;
  final Color? disabledIconColor;
  
  // پارامترهای نسبی (درصدی از صفحه)
  final double? widthFactor;  // نسبت به عرض صفحه
  final double? heightFactor; // نسبت به ارتفاع صفحه
  final double radiusFactor;  // نسبت به ارتفاع دکمه
  final double fontSizeFactor; // نسبت به ارتفاع دکمه
  
  // پارامترهای مطلق (پیکسل)
  final double? width;       // اولویت با width نسبت به widthFactor
  final double? height;      // اولویت با height نسبت به heightFactor
  final double? radius;      // اولویت با radius نسبت به radiusFactor
  final double? fontSize;    // اولویت با fontSize نسبت به fontSizeFactor
  final double? iconSize;    // اندازه آیکون
  final double iconPadding;  // فاصله بین آیکون و متن
  final double elevation;    // ارتفاع سایه
  
  // مقادیر پیش فرض پارامترهای نسبی
  static const double DEFAULT_WIDTH_FACTOR = 0.85;    // 85% عرض صفحه
  static const double DEFAULT_HEIGHT_FACTOR = 0.06;   // 6% ارتفاع صفحه
  static const double DEFAULT_RADIUS_FACTOR = 0.25;   // 25% ارتفاع دکمه
  static const double DEFAULT_FONT_SIZE_FACTOR = 0.4; // 40% ارتفاع دکمه

  const ClaudeButton({
    super.key,
    required this.text,
    required this.onPressed,
    // می‌توانید width و height را مستقیم تعیین کنید
    this.width,
    this.height,
    this.radius,
    this.fontSize,
    // یا می‌توانید به صورت درصدی از سایز صفحه تعیین کنید
    this.widthFactor,
    this.heightFactor,
    this.radiusFactor = DEFAULT_RADIUS_FACTOR,
    this.fontSizeFactor = DEFAULT_FONT_SIZE_FACTOR,
    // سایر پارامترها با مقادیر پیش‌فرض
    this.buttonColor = const Color(0xFF2196F3), // آبی ماتریال
    this.textColor = Colors.white,
    this.splashColor = Colors.white38,
    this.disabledButtonColor,
    this.disabledTextColor,
    this.elevation = 2.0,
    this.shadowColor,
    this.iconData,
    this.iconSize,
    this.iconPadding = 8.0,
    this.iconPosition = IconPosition.leading,
    this.iconColor,
    this.disabledIconColor,
  });

  // سازنده بدون آیکون - برای راحتی بیشتر
  const ClaudeButton.simple({
    super.key,
    required this.text,
    required this.onPressed,
    this.width,
    this.height,
    this.radius,
    this.fontSize,
    this.widthFactor,
    this.heightFactor,
    this.radiusFactor = DEFAULT_RADIUS_FACTOR,
    this.fontSizeFactor = DEFAULT_FONT_SIZE_FACTOR,
    this.buttonColor = const Color(0xFF2196F3),
    this.textColor = Colors.white,
    this.splashColor = Colors.white38,
    this.elevation = 2.0,
    this.disabledButtonColor,
    this.disabledTextColor,
    this.shadowColor,
  }) : iconData = null,
       iconSize = null,
       iconPadding = 8.0,
       iconPosition = IconPosition.leading,
       iconColor = null,
       disabledIconColor = null;

  // سازنده با استایل متفاوت - مثلاً برای دکمه خطر یا هشدار
  const ClaudeButton.danger({
    super.key,
    required this.text,
    required this.onPressed,
    this.width,
    this.height,
    this.radius,
    this.fontSize,
    this.widthFactor,
    this.heightFactor,
    this.radiusFactor = DEFAULT_RADIUS_FACTOR,
    this.fontSizeFactor = DEFAULT_FONT_SIZE_FACTOR,
    this.iconData,
    this.iconSize,
    this.iconPadding = 8.0,
    this.iconPosition = IconPosition.leading,
    this.elevation = 2.0,
    this.shadowColor,
    this.iconColor,
    this.disabledIconColor,
  }) : buttonColor = const Color(0xFFF44336), // رنگ قرمز
       textColor = Colors.white,
       splashColor = Colors.white38,
       disabledButtonColor = null,
       disabledTextColor = null;

  @override
  Widget build(BuildContext context) {
    // محاسبه ابعاد واقعی بر اساس MediaQuery
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;
    
    // محاسبه عرض و ارتفاع نهایی (اولویت با مقادیر مستقیم، سپس فاکتورها، سپس پیش‌فرض‌ها)
    final double effectiveWidth = width ?? 
        (widthFactor != null ? screenWidth * widthFactor! : screenWidth * DEFAULT_WIDTH_FACTOR);
    
    final double effectiveHeight = height ?? 
        (heightFactor != null ? screenHeight * heightFactor! : screenHeight * DEFAULT_HEIGHT_FACTOR);
    
    // محاسبه شعاع گرد گوشه و اندازه فونت بر اساس ارتفاع دکمه
    final double effectiveRadius = radius ?? (effectiveHeight * radiusFactor);
    final double effectiveFontSize = fontSize ?? (effectiveHeight * fontSizeFactor);
    
    // بقیه محاسبات مثل قبل
    final bool isEnabled = onPressed != null;
    final effectiveDisabledTextColor = disabledTextColor ?? textColor.withOpacity(0.5);
    final Color? effectiveIconColor = isEnabled 
        ? (iconColor ?? textColor) 
        : (disabledIconColor ?? effectiveDisabledTextColor);
    final effectiveDisabledButtonColor = disabledButtonColor ?? buttonColor.withOpacity(0.5);
    final double effectiveIconSize = iconSize ?? (effectiveFontSize * 1.3);
    final Color currentTextColor = isEnabled ? textColor : effectiveDisabledTextColor;

    return SizedBox(
      width: effectiveWidth,
      height: effectiveHeight,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          foregroundColor: currentTextColor,
          disabledBackgroundColor: effectiveDisabledButtonColor,
          disabledForegroundColor: effectiveDisabledTextColor,
          elevation: elevation,
          shadowColor: shadowColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(effectiveRadius),
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
          children: _buildButtonChildren(effectiveIconColor, effectiveIconSize, effectiveFontSize),
        ),
      ),
    );
  }

  // متد کمکی برای ساخت لیست ویجت‌های داخل Row
  List<Widget> _buildButtonChildren(Color? currentIconColor, double effectiveIconSize, double effectiveFontSize) {
    final textWidget = VText().PersianText(
      text,
      effectiveFontSize,
      color: null,
    );

    if (iconData == null) {
      return [textWidget];
    }

    final iconWidget = Icon(
      iconData,
      size: effectiveIconSize,
      color: currentIconColor,
    );

    final paddingWidget = SizedBox(width: iconPadding);

    if (iconPosition == IconPosition.leading) {
      return [iconWidget, paddingWidget, textWidget];
    } else {
      return [textWidget, paddingWidget, iconWidget];
    }
  }
}
