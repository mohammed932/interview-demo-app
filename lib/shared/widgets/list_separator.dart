import 'package:base_flutter/shared/constants/app_colors.dart';
import 'package:flutter/material.dart';

class ListSeparator extends StatelessWidget {
  const ListSeparator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      color: AppColors.primary,
    );
  }
}
