import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class GeminiTextButton extends StatefulWidget {
  final String text; // بخش عادی متن
  final String clickableText; // بخش قابل کلیک
  final VoidCallback onTap; // عملیات موقع کلیک
  final TextStyle? style; // استایل بخش عادی (اختیاری)
  final TextStyle? clickableStyle; // استایل بخش قابل کلیک (اختیاری)
  final TextAlign textAlign; // ترازبندی متن (اختیاری)
  final Color color1;
  final Color color2;
  const GeminiTextButton({
    super.key,
    required this.text,
    required this.clickableText,
    required this.color1,
    required this.color2,
    required this.onTap,
    this.style,
    this.clickableStyle,
    this.textAlign = TextAlign.start, // پیش‌فرض: شروع خط
  });

  @override
  State<GeminiTextButton> createState() => _GeminiTextButtonState();
}

class _GeminiTextButtonState extends State<GeminiTextButton> {
  late TapGestureRecognizer _tapRecognizer;

  @override
  void initState() {
    super.initState();
    _tapRecognizer = TapGestureRecognizer()..onTap = widget.onTap;
  }

  @override
  void dispose() {
    _tapRecognizer.dispose();
    super.dispose();
  }

  // این متد رو برای آپدیت recognizer موقع تغییر onTap اضافه می‌کنیم (احتیاطی)
  @override
  void didUpdateWidget(GeminiTextButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.onTap != oldWidget.onTap) {
      _tapRecognizer.dispose(); // قبلی رو حذف می‌کنیم
      _tapRecognizer = TapGestureRecognizer()..onTap = widget.onTap; // جدید می‌سازیم
    }
  }

  @override
  Widget build(BuildContext context) {
    // تعیین استایل‌ها با در نظر گرفتن مقادیر پیش‌فرض و تم
    final defaultStyle = widget.style ?? DefaultTextStyle.of(context).style;
    final effectiveClickableStyle = widget.clickableStyle ?? defaultStyle.copyWith(
                                        color: widget.color1, // استفاده از رنگ اصلی تم
                                        fontWeight: FontWeight.bold,
                                      );

    return RichText(
      textDirection: TextDirection.rtl, // همیشه برای فارسی RTL
      textAlign: widget.textAlign,
      text: TextSpan(
        style: defaultStyle,
        children: <TextSpan>[
          TextSpan(text: widget.text, style: TextStyle(color: widget.color2 )),
          const TextSpan(text: ' '), // یک فاصله کوچک بین دو بخش
          TextSpan(
            text: widget.clickableText,
            style: effectiveClickableStyle,
            recognizer: _tapRecognizer,
          ),
        ],
      ),
    );
  }
}


