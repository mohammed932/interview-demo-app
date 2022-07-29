import 'package:base_flutter/shared/widgets/custom_widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingButton extends StatelessWidget {
  final GlobalKey<CustomButtonState> btnKey;
  final String title;
  final Function()? onTap;
  final Color? textColor;
  final Color? color;
  final Color? borderColor;
  final double? borderRadius;
  final EdgeInsets? margin;
  final double? width;
  final double? height;
  final double? fontSize;
  final String? fontFamily;
  final FontWeight? fontWeight;

  LoadingButton({
    required this.title,
    this.onTap,
    this.color,
    this.textColor,
    this.borderRadius,
    this.margin,
    this.borderColor,
    this.fontFamily,
    this.fontSize,
    this.width,
    this.height,
    this.fontWeight,
    required this.btnKey,
  });

  @override
  Widget build(BuildContext context) {
    Color border = color ?? WidgetUtils.primaryColor;
    return Container(
      margin: margin ?? const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        children: [
          CustomButtonAnimation(
            key: btnKey,
            onTap: onTap!,
            width: width ?? MediaQuery.of(context).size.width,
            minWidth: 45,
            height: height ?? 45,
            color: color ?? WidgetUtils.primaryColor,
            borderRadius: borderRadius ?? 10,
            borderSide: BorderSide(color: borderColor ?? border, width: 1),
            child: MyText(
              title: '$title',
              size: fontSize ?? 11,
              color: textColor ?? Colors.white,
              fontFamily: fontFamily,
              fontWeight: fontWeight,
            ),
            loader: Container(
              padding: const EdgeInsets.all(10),
              child: const SpinKitRotatingCircle(
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
