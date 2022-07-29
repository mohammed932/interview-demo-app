import 'package:base_flutter/shared/constants/input_field_style/CustomInputDecoration.dart';
import 'package:base_flutter/shared/constants/input_field_style/CustomInputTextStyle.dart';
import 'package:base_flutter/shared/widgets/custom_widgets/custom_widgets.dart';
import 'package:auto_route/auto_route.dart';
import 'package:base_flutter/shared/blocs/lang_cubit/lang_cubit.dart';
import 'package:base_flutter/shared/constants/app_colors.dart';
import 'package:base_flutter/shared/widgets/loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tf_validator/tf_validator.dart';
import 'package:url_launcher/url_launcher.dart';

part 'utils.dart';
