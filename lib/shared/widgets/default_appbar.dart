import 'package:base_flutter/shared/widgets/custom_widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:base_flutter/shared/constants/app_colors.dart';

class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? leading;
  final List<Widget> actions;
  final double? size;
  final Color? bgColor;
  final Color? backButtonColor;
  final Color? titleColor;
  final hideBackButton;

  DefaultAppBar(
      {required this.title,
      this.actions = const [],
      this.leading,
      this.size,
      this.titleColor = AppColors.black,
      this.backButtonColor = AppColors.black,
      this.bgColor = AppColors.appBarColor,
      this.hideBackButton = false});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: MyText(
        title: title,
        size: 14.0,
        fontWeight: FontWeight.bold,
        color: titleColor ?? AppColors.white,
      ),
      centerTitle: false,
      backgroundColor: bgColor ?? AppColors.primary,
      elevation: 0,
      leadingWidth: hideBackButton ? 0 : null,
      leading: hideBackButton
          ? const SizedBox()
          : leading ??
              IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  size: 25,
                  color: backButtonColor ?? AppColors.white,
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(size ?? 65);
}
