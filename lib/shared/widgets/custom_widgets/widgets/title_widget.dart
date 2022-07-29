import 'package:base_flutter/shared/constants/app_colors.dart';
import 'package:base_flutter/shared/widgets/custom_widgets/custom_widgets.dart';
import 'package:base_flutter/shared/widgets/custom_widgets/widgets/General.dart';
import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  final String title, text;
  TitleWidget({required this.title, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyText(
          title: title,
          size: 12.0,
          fontWeight: FontWeight.bold,
        ),
        GeneralWidget.sizeBoxVertical(10.0),
        MyText(
          title: text,
          size: 12.0,
          color: AppColors.greyblack.withOpacity(0.7),
        ),
      ],
    );
  }
}
