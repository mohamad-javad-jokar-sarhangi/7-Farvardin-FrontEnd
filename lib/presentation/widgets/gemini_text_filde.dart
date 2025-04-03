import 'package:flutter/material.dart';
import 'package:myfront/presentation/widgets/vtext.dart';
// import 'package:myfront/presentation/widgets/vtext.dart';

// --- کلاس VText (فقط برای اینکه کد پایین اجرا بشه، از کد خودت استفاده کن) ---
// این بخش فقط یک نمونه ساده است، حتماً از پیاده‌سازی VText خودت استفاده کن!
// class VText {
//   Widget PersianText(String text, double fontSize, {required Color color}) {
//     return Text(
//       text,
//       textDirection: TextDirection.rtl, // اطمینان از راست‌چین بودن
//       style: TextStyle(
//         fontSize: fontSize,
//         color: color,
//         fontFamily: 'Vazir', // فرض می‌کنیم فونت وزیر رو داری
//       ),
//     );
//   }
// }
// --- پایان کلاس VText نمونه ---

class GeminiTextFilde extends StatefulWidget {
  // --- پارامترهای اصلی از TextAreaBox ---
  final String name; // نام لیبل
  final double width; // عرض کل ناحیه
  final double minHeight; // حداقل ارتفاع
  final double maxHeight; // حداکثر ارتفاع
  final double radius; // شعاع گردی گوشه‌ها
  final double fontSize; // اندازه فونت متن ورودی
  final double labelFontSize; // اندازه فونت لیبل (می‌تونه متفاوت باشه)
  final Color containerColor; // رنگ پس‌زمینه
  final Color cursorColor; // رنگ نشانگر تایپ
  final Color textColor; // رنگ متن ورودی
  final Color labelColor; // رنگ متن لیبل
  final TextEditingController tc; // کنترلر متن
  final String? hintText; // متن راهنما

  // --- پارامترهای جدید برای حالت فوکوس ---
  final bool enableFocusEffects; // آیا افکت‌های فوکوس فعال باشند؟
  final Color focusBorderColor; // رنگ بوردر هنگام فوکوس
  final double focusBorderWidth; // ضخامت بوردر هنگام فوکوس
  final IconData? focusIcon; // آیکون نمایش داده شده هنگام فوکوس (اختیاری)
  final Color? focusIconColor; // رنگ آیکون فوکوس (پیش‌فرض: رنگ بوردر)
  final double? focusIconSize; // اندازه آیکون فوکوس (پیش‌فرض: کمی کوچکتر از فونت لیبل)
  final double labelSpacing; // فاصله عمودی بین لیبل و فیلد متن

  const GeminiTextFilde({
    super.key,
    required this.name,
    required this.width,
    this.minHeight = 150, // مقدار پیش‌فرض قبلی
    this.maxHeight = 300, // مقدار پیش‌فرض قبلی
    required this.radius,
    required this.fontSize,
    double? labelFontSize, // اجازه میدیم اندازه فونت لیبل جدا باشه
    required this.containerColor,
    required this.cursorColor,
    required this.textColor,
    required this.labelColor,
    required this.tc,
    this.hintText,
    // مقادیر پیش‌فرض برای قابلیت‌های جدید
    this.enableFocusEffects = true,
    this.focusBorderColor = Colors.blueAccent,
    this.focusBorderWidth = 2.0,
    this.focusIcon, // آیکون معمولاً برای TextArea کمتر استفاده میشه، ولی گزینه‌اش هست
    this.focusIconColor,
    this.focusIconSize,
    this.labelSpacing = 8.0,
  }) : labelFontSize = labelFontSize ?? fontSize; // اگر فونت لیبل داده نشد، از فونت اصلی استفاده کن

  @override
  State<GeminiTextFilde> createState() => _GeminiTextFildeState();
}

class _GeminiTextFildeState extends State<GeminiTextFilde> {
  late FocusNode _focusNode;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    if (mounted && widget.enableFocusEffects) {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // تعیین رنگ و اندازه آیکون فوکوس
    final effectiveFocusIconColor = widget.focusIconColor ?? widget.focusBorderColor;
    // اندازه آیکون رو کمی کوچکتر از فونت لیبل می‌گیریم که خیلی بزرگ نباشه
    final effectiveFocusIconSize = widget.focusIconSize ?? (widget.labelFontSize * 1.1);

    // محاسبه padding داخلی TextField با توجه به وجود آیکون
    // آیکون رو در گوشه بالا-راست (در RTL) قرار می‌دیم
    final double topPadding = (_isFocused && widget.focusIcon != null && widget.enableFocusEffects)
        ? effectiveFocusIconSize + 12.0 // اگر آیکون هست، پدینگ بالا بیشتر
        : 12.0; // پدینگ عادی بالا
    final double startPadding = 16.0; // پدینگ راست (در RTL)
    final double endPadding = 16.0; // پدینگ چپ (در RTL)
    final double bottomPadding = 12.0; // پدینگ پایین

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end, // لیبل در سمت راست بالا
      children: [
        // --- لیبل ---
        Padding(
          // کمی پدینگ راست برای هماهنگی با لبه کانتینر
          padding: EdgeInsetsDirectional.only(end: widget.radius * 0.5),
          child: VText().PersianText(
            ' : ${widget.name}', // دو نقطه رو اینجا هم گذاشتم
            widget.labelFontSize,
            color: widget.labelColor,
          ),
        ),

        // فاصله بین لیبل و فیلد
        SizedBox(height: widget.labelSpacing),

        // --- کانتینر اصلی با افکت‌های فوکوس ---
        Center( // برای اینکه کانتینر در مرکز افقی Column قرار بگیره
          child: Container(
            width: widget.width,
            constraints: BoxConstraints(
              minHeight: widget.minHeight,
              maxHeight: widget.maxHeight,
            ),
            decoration: BoxDecoration(
              color: widget.containerColor.withOpacity(0.7), // کمی شفافیت
              borderRadius: BorderRadius.circular(widget.radius),
              border: widget.enableFocusEffects
                  ? Border.all(
                      color: _isFocused ? widget.focusBorderColor : Colors.transparent,
                      width: widget.focusBorderWidth,
                    )
                  : null,
              boxShadow: _isFocused && widget.enableFocusEffects ? [
                BoxShadow(
                  color: widget.focusBorderColor.withOpacity(0.3),
                  blurRadius: 5.0,
                  spreadRadius: 1.0,
                )
              ] : null,
            ),
            // استفاده از ClipRRect برای اینکه TextField از گوشه‌های گرد بیرون نزنه
            child: ClipRRect(
               borderRadius: BorderRadius.circular(widget.radius - (widget.focusBorderWidth / 2)), // شعاع داخلی کمی کمتر
               child: Stack( // Stack برای قرار دادن آیکون روی TextField
                 children: [
                   // --- فیلد متنی چند خطی ---
                   TextField(
                     controller: widget.tc,
                     focusNode: _focusNode,
                     textAlign: TextAlign.right,
                     textDirection: TextDirection.rtl,
                     maxLines: null, // اجازه به تعداد خطوط نامحدود
                     minLines: null, // اجازه به تعداد خطوط نامحدود
                     expands: true, // اجازه می‌دهد فیلد فضای عمودی موجود را پر کند
                     keyboardType: TextInputType.multiline,
                     cursorColor: widget.cursorColor,
                     scrollPhysics: const BouncingScrollPhysics(), // اسکرول نرم
                     decoration: InputDecoration(
                       border: InputBorder.none, // حذف بوردر پیش‌فرض
                       filled: true, // باید true باشه تا رنگ پس زمینه اعمال بشه (ولی ما رنگ رو روی کانتینر داریم)
                       fillColor: Colors.transparent, // رنگ داخل TextField شفاف باشه چون کانتینر رنگ داره
                       contentPadding: EdgeInsetsDirectional.only(
                         start: startPadding,
                         end: endPadding,
                         top: topPadding,
                         bottom: bottomPadding,
                       ),
                       hintText: widget.hintText,
                       hintTextDirection: TextDirection.rtl,
                       hintStyle: TextStyle(
                         color: widget.textColor.withOpacity(0.5),
                         fontFamily: 'Vazir', // فونت شما
                         fontSize: widget.fontSize * 0.9, // فونت هینت کمی کوچکتر
                       ),
                     ),
                     style: TextStyle(
                       fontSize: widget.fontSize,
                       color: widget.textColor,
                       fontFamily: 'Vazir', // فونت شما
                       height: 1.6, // کمی افزایش فاصله بین خطوط برای خوانایی بهتر
                     ),
                   ),

                   // --- آیکون فوکوس (در صورت وجود و فعال بودن) ---
                   if (_isFocused && widget.focusIcon != null && widget.enableFocusEffects)
                     PositionedDirectional(
                       top: 8.0, // فاصله از بالا
                       start: 8.0, // فاصله از راست (در RTL)
                       child: Icon(
                         widget.focusIcon,
                         color: effectiveFocusIconColor,
                         size: effectiveFocusIconSize,
                       ),
                     ),
                 ],
               ),
            ),
          ),
        ),
      ],
    );
  }
}
