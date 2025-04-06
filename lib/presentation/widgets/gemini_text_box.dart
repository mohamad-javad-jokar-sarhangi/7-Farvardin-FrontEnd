import 'package:flutter/material.dart';
import 'package:myfront/core/data_color.dart';
import 'package:myfront/presentation/widgets/vtext.dart';

class GeminiTextBox extends StatefulWidget {
  // --- پارامترهای اصلی ---
  final String name; // نام لیبل
  final double width; // عرض کل ناحیه متن (شامل فیلد و حاشیه احتمالی آیکون)
  final double height; // ارتفاع کل
  final double radius; // شعاع گردی گوشه‌ها
  final double fontSize; // اندازه فونت متن ورودی و لیبل
  final Color containerColor; // رنگ پس‌زمینه فیلد متن
  final Color cursorColor; // رنگ نشانگر تایپ
  final Color textColor; // رنگ متن ورودی
  final Color labelColor; // رنگ متن لیبل
  final TextEditingController tc; // کنترلر متن

  // --- پارامترهای جدید برای حالت فوکوس ---
  final bool enableFocusEffects; // آیا افکت‌های فوکوس فعال باشند؟
  final Color focusBorderColor; // رنگ بوردر هنگام فوکوس
  final double focusBorderWidth; // ضخامت بوردر هنگام فوکوس
  final IconData? focusIcon; // آیکون نمایش داده شده هنگام فوکوس (اختیاری)
  final Color? focusIconColor; // رنگ آیکون فوکوس (پیش‌فرض: رنگ بوردر)
  final double? focusIconSize; // اندازه آیکون فوکوس (پیش‌فرض: کمی کوچکتر از فونت)
  final double labelSpacing; // فاصله بین لیبل و فیلد متن

  const GeminiTextBox({
    super.key,
    required this.name,
    required this.width,
    required this.height,
    this.radius = 24,
    this.fontSize = 16,
    this.containerColor = DataColor.backgroundColor,
    this.cursorColor = DataColor.accentColor,
    this.textColor = DataColor.textColor,
    this.labelColor = DataColor.backgroundColor,
    required this.tc,
    // مقادیر پیش‌فرض برای قابلیت‌های جدید
    this.enableFocusEffects = true, // به طور پیش‌فرض فعال
    this.focusBorderColor = Colors.blueAccent, // یه رنگ پیش‌فرض جذاب
    this.focusBorderWidth = 2.0,
    this.focusIcon, // به طور پیش‌فرض آیکونی نیست
    this.focusIconColor = DataColor.accentColor, // رنگ پیش‌فرض بعداً تنظیم می‌شود
    this.focusIconSize = 20, // اندازه پیش‌فرض بعداً تنظیم می‌شود
    this.labelSpacing = 8.0, // فاصله پیش‌فرض بین لیبل و فیلد
  });

  @override
  State<GeminiTextBox> createState() => _GeminiTextBoxState();
}

class _GeminiTextBoxState extends State<GeminiTextBox> {
  late FocusNode _focusNode;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    // یک شنونده اضافه می‌کنیم تا هر وقت وضعیت فوکوس تغییر کرد، باخبر شویم
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    // حتماً شنونده و خود FocusNode رو در انتها پاک کنیم تا حافظه نشت نکنه
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  // این متد وقتی فوکوس تغییر می‌کنه، صدا زده میشه
  void _onFocusChange() {
    // اگر ویجت هنوز در درخت ویجت‌ها وجود داره (برای جلوگیری از خطا)
    if (mounted && widget.enableFocusEffects) {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // تعیین رنگ و اندازه آیکون فوکوس با مقادیر پیش‌فرض هوشمند
    final effectiveFocusIconColor = widget.focusIconColor ?? widget.focusBorderColor;
    final effectiveFocusIconSize = widget.focusIconSize ?? (widget.fontSize * 0.9);

    // محاسبه padding داخلی TextField با توجه به وجود آیکون در حالت فوکوس
    // در حالت RTL، 'start' سمت راست و 'end' سمت چپ است.
    // ما می‌خواهیم متن از راست شروع بشه و اگر آیکون هست، به آیکون (که چپ قرار می‌گیرد) برخورد نکنه.
    final double startPadding = widget.height * 0.25; // فاصله متن از لبه راست
    final double endPadding = (_isFocused && widget.focusIcon != null && widget.enableFocusEffects)
        ? effectiveFocusIconSize + 8.0 // اگر آیکون هست، جای بیشتری برایش بگذار
        : widget.height * 0.1; // در غیر این صورت، پدینگ کمتر

    return Row(
      mainAxisAlignment: MainAxisAlignment.center, // یا هر چیدمان دیگری که برای کل ردیف می‌خواهی
      crossAxisAlignment: CrossAxisAlignment.center, // برای تراز عمودی لیبل و فیلد
      textDirection: TextDirection.rtl, // جهت کلی ردیف راست به چپ
      children: [
        // لیبل متن با استفاده از VText شما
        VText().PersianText(
           ': ${widget.name}', // دو نقطه رو اینجا گذاشتم که بچسبه به اسم
           widget.fontSize,
           color: widget.labelColor,
        ),
        // فاصله بین لیبل و فیلد متن
        SizedBox(width: widget.labelSpacing),
        // محفظه اصلی که TextField و آیکون (در صورت وجود) را در بر می‌گیرد
        Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            color: widget.containerColor.withOpacity(0.7), // کمی شفافیت برای زیبایی
            borderRadius: BorderRadius.circular(widget.radius),
            border: widget.enableFocusEffects
                ? Border.all(
                    color: _isFocused ? widget.focusBorderColor : Colors.transparent, // رنگ بوردر شرطی
                    width: widget.focusBorderWidth, // ضخامت بوردر
                  )
                : null, // اگر افکت‌ها غیرفعال باشند، بوردری نیست
            boxShadow: _isFocused && widget.enableFocusEffects ? [ // اضافه کردن سایه ملایم در حالت فوکوس
              BoxShadow(
                color: widget.focusBorderColor.withOpacity(0.3),
                blurRadius: 5.0,
                spreadRadius: 1.0,
              )
            ] : null,
          ),
          // استفاده از Stack برای قرار دادن آیکون روی TextField
          child: Stack(
            alignment: AlignmentDirectional.center, // مرکز چین کردن محتویات Stack
            children: [
              // خود فیلد متنی
              TextField(
                controller: widget.tc,
                focusNode: _focusNode, // اتصال FocusNode به TextField
                textAlign: TextAlign.right, // چینش متن داخل فیلد
                textDirection: TextDirection.rtl, // جهت متن ورودی
                maxLines: 1,
                cursorColor: widget.cursorColor,
                style: TextStyle(
                  fontSize: widget.fontSize,
                  color: widget.textColor,
                  fontFamily: 'Vazir', // فونت شما
                ),
                decoration: InputDecoration(
                  border: InputBorder.none, // حذف بوردر پیش‌فرض TextField
                  // تنظیم دقیق contentPadding برای جای‌دهی متن و آیکون
                  contentPadding: EdgeInsetsDirectional.only(
                    start: startPadding,
                    end: endPadding,
                    // تنظیمات پدینگ بالا و پایین برای مرکز کردن عمودی متن
                    // می‌توانید این مقادیر را دقیق‌تر تنظیم کنید
                    top: (widget.height - widget.fontSize) / 2 - (widget.focusBorderWidth/2), // کمی تنظیم برای ضخامت بوردر
                    bottom:(widget.height - widget.fontSize) / 2 - (widget.focusBorderWidth/2),
                  ),
                ),
              ),

              // آیکون فوکوس (اگر فعال، در حالت فوکوس و آیکون تعریف شده باشد)
              // PositionedDirectional برای موقعیت‌دهی صحیح در RTL
              if (_isFocused && widget.focusIcon != null && widget.enableFocusEffects)
                PositionedDirectional(
                  start: 8.0, // فاصله آیکون از لبه راست (start در RTL)
                  top: (widget.height - effectiveFocusIconSize) / 2, // مرکز کردن عمودی آیکون
                  child: Icon(
                    widget.focusIcon,
                    color: effectiveFocusIconColor,
                    size: effectiveFocusIconSize,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}