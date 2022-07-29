import 'package:base_flutter/shared/constants/app_colors.dart';
import 'package:base_flutter/shared/widgets/custom_widgets/custom_widgets.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CustomToast {
  static showConfirmDialog(
      {required BuildContext context,
      required String title,
      required Function() confirm}) {
    return showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return _alertDialog(title, confirm, context, "تأكيد");
      },
    );
  }

  static showAuthDialog({required BuildContext context}) {
    return showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return _alertDialog(
            "قم بتسجيل الدخول للمتابعة", () {}, context, "دخول");
      },
    );
  }

  static Widget _alertDialog(
      String title, Function()? confirm, BuildContext context, String okText) {
    return CupertinoAlertDialog(
      title: MyText(
        title: title,
        size: 14,
        color: AppColors.black,
      ),
      // content: MyText(title: title,size: 12,color: MyColors.blackOpacity,),
      actions: [
        CupertinoDialogAction(
          child: MyText(
            title: "رجوع",
            size: 14,
            color: AppColors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        CupertinoDialogAction(
          child: MyText(
            title: okText,
            size: 12,
            color: AppColors.black,
          ),
          onPressed: confirm,
        ),
      ],
    );
  }

  static showToastNotification(msg,
      {Color? color, Color? textColor, ToastGravity? toastGravity}) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: toastGravity ?? ToastGravity.BOTTOM,
        backgroundColor: color ?? AppColors.primary,
        textColor: textColor ?? Colors.white,
        fontSize: 16.0);
  }

  static showSimpleToast(
      {required String msg, Color? color, Color? textColor}) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: color ?? AppColors.primary,
        textColor: textColor ?? Colors.white,
        fontSize: 16.0);
  }
}
