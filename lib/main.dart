import 'package:base_flutter/shared/blocs/internet_connection/internet_connection_cubit.dart';
import 'package:base_flutter/shared/blocs/lang_cubit/lang_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'shared/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => LangCubit()),
        BlocProvider(create: (BuildContext context) => InternetConnectionCubit())
      ],
      child: Phoenix(
        child: MyApp(),
      ),
    ),
  );
}
