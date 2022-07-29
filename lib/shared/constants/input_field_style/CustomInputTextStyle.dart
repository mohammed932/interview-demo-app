import 'package:base_flutter/shared/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomInputTextStyle extends TextStyle {
  final String lang;
  final Color? textColor;

  CustomInputTextStyle({required this.lang, this.textColor});

  @override
  String get fontFamily => lang == 'ar'
      ? GoogleFonts.cairo().fontFamily!
      : GoogleFonts.almarai().fontFamily!;

  @override
  double get fontSize => lang == 'ar' ? 16 : 20;

  @override
  Color get color => textColor ?? AppColors.black;
}
