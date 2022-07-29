part of 'utils.imports.dart';

class Utils {
  static Future<void> manipulateSplashData(BuildContext context) async {
    initCustomWidgets(language: 'en');
    changeLanguage('en', context);
  }

  static initCustomWidgets({required String language}) {
    WidgetUtils.init(
        style: CustomInputTextStyle(lang: language),
        primary: AppColors.primary,
        language: language,
        inputStyle: (
                {String? label,
                String? hint,
                Widget? prefixIcon,
                Widget? suffixIcon,
                Widget? suffixWidget,
                Widget? prefixWidget,
                Color? hintColor,
                Color? fillColor,
                BorderRadius? radius,
                Color? focusBorderColor,
                EdgeInsets? padding,
                Color? enableColor}) =>
            CustomInputDecoration(
                lang: language,
                labelTxt: label,
                hint: hint,
                prefixIcon: prefixIcon,
                suffixIcon: suffixIcon,
                enableColor: enableColor,
                padding: padding));
  }

  static void changeLanguage(String lang, BuildContext context) {
    WidgetUtils.lang = lang;
    context.read<LangCubit>().onUpdateLanguage(lang);
  }

  static formatDate({required DateTime date, required String sign}) {
    switch (sign) {
      case '-':
        return new DateFormat('yyyy-MM-dd').format(date);
      case '/':
        return new DateFormat('yyyy/MM/dd').format(date);
    }
  }

  static Future<String?> getDeviceId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('deviceId');
  }

  static Future<void> setDeviceId(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('deviceId', token);
  }

  static void launchURL({required String url}) async {
    if (!url.toString().startsWith('https')) {
      url = 'https://' + url;
    }
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      CustomToast.showToastNotification('من فضلك تآكد من الرابط');
    }
  }

  static void copToClipboard({
    required String text,
    required GlobalKey<ScaffoldState> scaffold,
    required BuildContext context,
  }) {
    if (text.trim().isEmpty) {
      CustomToast.showToastNotification(tr(context, 'no_data_to_copy'));
      return;
    } else {
      Clipboard.setData(ClipboardData(text: '$text')).then((value) {
        CustomToast.showToastNotification(tr(context, 'copied_successfully'));
      });
    }
  }

  static String convertDigitsToLatin(String s) {
    var sb = new StringBuffer();
    for (int i = 0; i < s.length; i++) {
      switch (s[i]) {
        //Arabic digits
        case '\u0660':
          sb.write('0');
          break;
        case '\u0661':
          sb.write('1');
          break;
        case '\u0662':
          sb.write('2');
          break;
        case '\u0663':
          sb.write('3');
          break;
        case '\u0664':
          sb.write('4');
          break;
        case '\u0665':
          sb.write('5');
          break;
        case '\u0666':
          sb.write('6');
          break;
        case '\u0667':
          sb.write('7');
          break;
        case '\u0668':
          sb.write('8');
          break;
        case '\u0669':
          sb.write('9');
          break;
        default:
          sb.write(s[i]);
          break;
      }
    }
    return sb.toString();
  }

  static int getColorHexFromStr(String colorStr) {
    colorStr = 'FF' + colorStr;
    colorStr = colorStr.replaceAll('#', '');
    int val = 0;
    int len = colorStr.length;
    for (int i = 0; i < len; i++) {
      int hexDigit = colorStr.codeUnitAt(i);
      if (hexDigit >= 48 && hexDigit <= 57) {
        val += (hexDigit - 48) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 65 && hexDigit <= 70) {
        // A..F
        val += (hexDigit - 55) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 97 && hexDigit <= 102) {
        // a..f
        val += (hexDigit - 87) * (1 << (4 * (len - 1 - i)));
      } else {
        throw const FormatException('An error occurred when converting a color');
      }
    }
    return val;
  }

  static Future<void> showErrorDialog(
      {required BuildContext context, required String error, VoidCallback? callBack, String? callBackTitle}) {
    AlertDialog dialog = AlertDialog(
        contentPadding: EdgeInsets.zero,
        title: Text(tr(context, 'error'), style: const TextStyle(fontSize: 18, fontFamily: 'Almarai')),
        content: Container(
          height: 130,
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(error, style: const TextStyle(fontSize: 16, fontFamily: 'Almarai')),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.3,
                    margin: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: ElevatedButton(
                        onPressed: () => AutoRouter.of(context).pop(),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.redAccent, //background color of button
                          //border width and color
                          elevation: 3, //elevation of button
                          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                          //content padding inside button
                        ),
                        child: MyText(title: tr(context, 'cancel'), color: AppColors.white, size: 12.0)),
                  ),
                  callBackTitle != null
                      ? Container(
                          width: MediaQuery.of(context).size.width * 0.3,
                          margin: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: ElevatedButton(
                              onPressed: callBack!,
                              style: ElevatedButton.styleFrom(
                                primary: AppColors.primary, //background color of button
                                //border width and color
                                elevation: 3, //elevation of button
                                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                                //content padding inside button
                              ),
                              child: MyText(title: callBackTitle, color: AppColors.white, size: 12.0)),
                        )
                      : Container()
                ],
              )
            ],
          ),
        ),
        elevation: 5);

    return showDialog(context: context, builder: (_) => dialog);
  }

  static Future<void> showLogoutDialog({required BuildContext context, required VoidCallback onLogout}) {
    AlertDialog dialog = AlertDialog(
        backgroundColor: AppColors.appBarColor,
        contentPadding: EdgeInsets.zero,
        title:
            Container(child: Text(tr(context, 'logout'), style: const TextStyle(fontSize: 16, fontFamily: 'Almarai'))),
        content: Container(
          color: AppColors.appBarColor,
          height: 140,
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(tr(context, 'r_u_sure_logout'),
                        style: const TextStyle(fontSize: 14, fontFamily: 'Almarai')),
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      color: AppColors.secondary,
                      child: TextButton(
                          onPressed: onLogout,
                          child: Text(tr(context, 'logout'), style: const TextStyle(color: Colors.white))),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.white,
                      child: TextButton(
                          onPressed: () => AutoRouter.of(context).pop(),
                          child: Text(tr(context, 'cancel'), style: const TextStyle(color: Colors.redAccent))),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
        elevation: 5);

    return showDialog(context: context, builder: (_) => dialog);
  }

  static Future<void> showUpdateDialog(BuildContext context, VoidCallback onLogout) {
    AlertDialog dialog = AlertDialog(
        backgroundColor: AppColors.appBarColor,
        contentPadding: EdgeInsets.zero,
        title: Container(
            child: Text(tr(context, 'update_app'), style: const TextStyle(fontSize: 16, fontFamily: 'Almarai'))),
        content: Container(
          color: AppColors.appBarColor,
          height: 140,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(22.0),
                  child: Text(tr(context, 'there_is_new_version'),
                      style: const TextStyle(fontSize: 14, fontFamily: 'Almarai')),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      color: AppColors.secondary,
                      child: TextButton(
                          onPressed: onLogout,
                          child: Text(tr(context, 'update'), style: const TextStyle(color: Colors.white))),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.white,
                      child: TextButton(
                          onPressed: () => AutoRouter.of(context).pop(),
                          child: Text(tr(context, 'cancel'), style: const TextStyle(color: Colors.redAccent))),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
        elevation: 5);

    return showDialog(context: context, builder: (_) => dialog);
  }
}
