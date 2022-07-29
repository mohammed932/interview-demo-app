part of 'main_data.imports.dart';

class MainData {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.grey,
    // scaffoldBackgroundColor: AppColors.lightGrey.withOpacity(0.1),
    focusColor: AppColors.primary,
    primaryColor: AppColors.primary,
    fontFamily: 'Almarai',
    appBarTheme: const AppBarTheme(
        toolbarTextStyle: TextStyle(color: Colors.red),
        backgroundColor: AppColors.primary,
        iconTheme: IconThemeData(
          color: Colors.black,
        )),
    textTheme: const TextTheme(
      subtitle1: TextStyle(fontFamily: 'Almarai-Bold', fontSize: 14),
    ),
  );

  static List<BlocProvider> providers(BuildContext context) => [
        BlocProvider<AuthCubit>(
          create: (BuildContext context) => AuthCubit(),
        ),
      ];
}
