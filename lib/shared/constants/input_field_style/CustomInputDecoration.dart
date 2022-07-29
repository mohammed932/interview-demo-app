import 'package:base_flutter/shared/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomInputDecoration extends InputDecoration {
  final String lang;
  final String? labelTxt;
  final String? hint;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color? enableColor;
  final Color? focusColor;
  final Color? hintColor;
  final Color? customFillColor;
  final double? borderRadius;
  final EdgeInsets? padding;

  CustomInputDecoration(
      {required this.lang,
      this.hint,
      this.labelTxt,
      this.prefixIcon,
      this.suffixIcon,
      this.hintColor,
      this.customFillColor,
      this.enableColor,
      this.focusColor,
      this.borderRadius,
      this.padding})
      : super();

  @override
  InputBorder get enabledBorder => OutlineInputBorder(
        borderSide:
            BorderSide(color: enableColor ?? AppColors.lightGrey, width: .7),
        borderRadius: BorderRadius.circular(borderRadius ?? 10),
      );

  @override
  InputBorder get focusedBorder => OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius ?? 10),
      borderSide: BorderSide(color: focusColor ?? AppColors.primary, width: 1));

  @override
  InputBorder get errorBorder => OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.red, width: .5),
      borderRadius: BorderRadius.circular(borderRadius ?? 10));

  @override
  InputBorder get focusedErrorBorder => OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius ?? 10),
      borderSide: const BorderSide(color: Colors.red, width: 2));

  @override
  TextStyle get errorStyle => lang != 'ar'
      ? GoogleFonts.roboto(fontSize: 12)
      : GoogleFonts.cairo(fontSize: 10);

  @override
  String? get hintText => hint;

  @override
  Widget? get label => labelTxt == null
      ? super.label
      : Text(
          labelTxt ?? '',
          style: labelStyle,
        );

  @override
  TextStyle get labelStyle => lang != 'ar'
      ? GoogleFonts.roboto(fontSize: 16, color: hintColor ?? Colors.black54)
      : GoogleFonts.cairo(fontSize: 14, color: hintColor ?? Colors.black54);

  @override
  TextStyle? get hintStyle => lang != 'ar'
      ? GoogleFonts.roboto(fontSize: 16, color: hintColor ?? Colors.black54)
      : GoogleFonts.cairo(fontSize: 14, color: hintColor ?? Colors.black54);

  @override
  EdgeInsetsGeometry get contentPadding =>
      padding ?? const EdgeInsets.symmetric(horizontal: 10, vertical: 14);

  @override
  bool get filled => true;

  @override
  Color get fillColor => customFillColor ?? Colors.white;

  @override
  bool get alignLabelWithHint => true;
}
