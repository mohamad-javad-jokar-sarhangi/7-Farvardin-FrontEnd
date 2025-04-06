import 'package:flutter/material.dart';
import 'package:myfront/core/data_color.dart';
import 'package:myfront/presentation/widgets/vtext.dart';

enum ClaudeBoxStyle {
  normal,
  outlined,
  filled,
}

class ClaudeBox extends StatefulWidget {
  final String label;
  final String? hint;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final bool obscureText;
  final VoidCallback? onSuffixIconTap;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final Function()? onTap;
  final TextInputType keyboardType;
  final int? maxLines;
  final int? maxLength;
  final bool enabled;
  final ClaudeBoxStyle style;
  final String? errorText;
  final double? width;
  final double? height;

  const ClaudeBox({
    super.key,
    required this.label,
    this.hint,
    this.prefixIcon,
    this.suffixIcon,
    this.controller,
    this.focusNode,
    this.obscureText = false,
    this.onSuffixIconTap,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
    this.maxLength,
    this.enabled = true,
    this.style = ClaudeBoxStyle.normal,
    this.errorText,
    this.width,
    this.height,
  });

  // سازنده برای حالت نرمال
  const ClaudeBox.normal({
    super.key,
    required this.label,
    this.hint,
    this.prefixIcon,
    this.suffixIcon,
    this.controller,
    this.focusNode,
    this.obscureText = false,
    this.onSuffixIconTap,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
    this.maxLength,
    this.enabled = true,
    this.errorText,
    this.width,
    this.height,
  }) : style = ClaudeBoxStyle.normal;

  // سازنده برای حالت خط دور
  const ClaudeBox.outlined({
    super.key,
    required this.label,
    this.hint,
    this.prefixIcon,
    this.suffixIcon,
    this.controller,
    this.focusNode,
    this.obscureText = false,
    this.onSuffixIconTap,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
    this.maxLength,
    this.enabled = true,
    this.errorText,
    this.width,
    this.height,
  }) : style = ClaudeBoxStyle.outlined;

  // سازنده برای حالت پر شده
  const ClaudeBox.filled({
    super.key,
    required this.label,
    this.hint,
    this.prefixIcon,
    this.suffixIcon,
    this.controller,
    this.focusNode,
    this.obscureText = false,
    this.onSuffixIconTap,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
    this.maxLength,
    this.enabled = true,
    this.errorText,
    this.width,
    this.height,
  }) : style = ClaudeBoxStyle.filled;

  @override
  State<ClaudeBox> createState() => _ClaudeBoxState();
}

class _ClaudeBoxState extends State<ClaudeBox> {
  late FocusNode _focusNode;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    // رنگ‌های پویا بر اساس وضعیت فیلد
    final Color labelColor = _isFocused 
        ? DataColor.accentColor 
        : widget.errorText != null 
            ? Colors.red 
            : DataColor.iconColor;
    
    final Color borderColor = _isFocused 
        ? DataColor.accentColor 
        : widget.errorText != null 
            ? Colors.red 
            : DataColor.backgroundColor.withOpacity(0.5);
    
    // انتخاب نوع دکوراسیون بر اساس سبک
    InputDecoration getDecoration() {
      final baseDecoration = InputDecoration(
        labelText: widget.label,
        labelStyle: TextStyle(
          fontFamily: 'Vazir',
          color: labelColor,
          fontSize: 14,
        ),
        hintText: widget.hint,
        hintStyle: TextStyle(
          fontFamily: 'Vazir',
          color: DataColor.iconColor.withOpacity(0.5),
          fontSize: 14,
        ),
        errorText: widget.errorText,
        errorStyle: const TextStyle(
          fontFamily: 'Vazir',
          fontSize: 12,
        ),
        prefixIcon: widget.prefixIcon != null
            ? Icon(widget.prefixIcon, color: labelColor, size: 20)
            : null,
        suffixIcon: widget.suffixIcon != null
            ? GestureDetector(
                onTap: widget.onSuffixIconTap,
                child: Icon(widget.suffixIcon, color: labelColor, size: 20),
              )
            : null,
        alignLabelWithHint: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        enabled: widget.enabled,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        floatingLabelAlignment: FloatingLabelAlignment.start,
      );

      switch (widget.style) {
        case ClaudeBoxStyle.normal:
          return baseDecoration.copyWith(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: borderColor, width: 1.5),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: DataColor.accentColor, width: 2),
            ),
            errorBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 1.5),
            ),
            focusedErrorBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 2),
            ),
          );
        case ClaudeBoxStyle.outlined:
          return baseDecoration.copyWith(
            filled: false,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: borderColor, width: 1.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: DataColor.accentColor, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red, width: 1.5),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red, width: 2),
            ),
          );
        case ClaudeBoxStyle.filled:
          return baseDecoration.copyWith(
            filled: true,
            fillColor: DataColor.sidebarLinkBackgroundColor,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: DataColor.accentColor, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red, width: 1.5),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red, width: 2),
            ),
          );
      }
    }

    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        boxShadow: _isFocused ? [
          BoxShadow(
            color: DataColor.accentShadowColor.withOpacity(0.3),
            blurRadius: 12,
            spreadRadius: 1,
          )
        ] : null,
      ),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: TextField(
          controller: widget.controller,
          focusNode: _focusNode,
          style: TextStyle(
            fontFamily: 'Vazir',
            color: DataColor.iconColor,
            fontSize: 14,
          ),
          textDirection: TextDirection.rtl,
          textAlign: TextAlign.right,
          obscureText: widget.obscureText,
          keyboardType: widget.keyboardType,
          maxLines: widget.maxLines,
          maxLength: widget.maxLength,
          enabled: widget.enabled,
          onChanged: widget.onChanged,
          onSubmitted: widget.onSubmitted,
          onTap: widget.onTap,
          decoration: getDecoration(),
          cursorColor: DataColor.accentColor,
        ),
      ),
    );
  }
}
