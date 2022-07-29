import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:base_flutter/shared/constants/app_colors.dart';

class LoadingDialog {
  static showLoadingDialog() {
    EasyLoading.show(
        maskType: EasyLoadingMaskType.black,
        dismissOnTap: false,
        indicator: SpinKitCubeGrid(
          size: 40.0,
          itemBuilder: (context, index) {
            return Container(
              height: 10,
              width: 10,
              margin: const EdgeInsets.all(1),
              decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
            );
          },
        ),
        status: 'loading');
  }

  static dismissDialog() {
    EasyLoading.dismiss();
  }

  static showLoadingView({Color? color}) {
    return Center(
      child: SpinKitCubeGrid(
        color: color ?? AppColors.primary,
        size: 40.0,
      ),
    );
  }
}
