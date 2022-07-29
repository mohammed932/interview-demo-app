import 'dart:developer';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:base_flutter/shared/constants/api_names.dart';
import 'package:base_flutter/shared/models/error_response.dart';
import 'package:base_flutter/shared/utilities/routers/router.imports.gr.dart';
import 'package:base_flutter/shared/utilities/utils_functions/loading_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tf_dio_cache/dio_http_cache.dart';

part 'dio_helper_status.dart';
