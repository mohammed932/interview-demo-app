import 'package:base_flutter/shared/widgets/custom_widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyText extends StatelessWidget {
  final String title;
  final Color? color;
  final double? size;
  final double? letterSpace;
  final double? wordSpace;
  final String? fontFamily;
  final double? lineHeight;
  final TextAlign? alien;
  final TextDecoration? decoration;
  final TextOverflow? overflow;
  final FontWeight? fontWeight;

  MyText(
      {required this.title,
      this.color,
      this.size,
      this.lineHeight = 1.3,
      this.alien,
      this.fontFamily,
      this.decoration,
      this.letterSpace,
      this.wordSpace,
      this.overflow,
      this.fontWeight});

  @override
  Widget build(BuildContext context) {
    return Text(
      '$title',
      textAlign: alien ?? TextAlign.start,
      textScaleFactor: 1.2,
      style: TextStyle(
          color: color ?? Colors.black,
          fontSize: size ?? 14,
          height: lineHeight,
          letterSpacing: letterSpace,
          wordSpacing: wordSpace,
          decoration: decoration ?? TextDecoration.none,
          fontWeight: fontWeight ??
              (WidgetUtils.lang == 'ar' ? FontWeight.w500 : FontWeight.w200),
          fontFamily: fontFamily ??
              (WidgetUtils.lang == 'ar'
                  ? GoogleFonts.cairo().fontFamily
                  : GoogleFonts.almarai().fontFamily)),
      overflow: overflow,
    );
  }
}
