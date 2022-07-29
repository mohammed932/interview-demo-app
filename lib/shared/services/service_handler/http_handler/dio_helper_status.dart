part of 'dio.imports.dart';

class DioHelper {
  late Dio _dio;
  late DioCacheManager _manager;
  BuildContext context;
  final bool forceRefresh;
  Map<String, String>? headers;
  DioHelper({this.forceRefresh = true, required this.context, String? baseUrl, this.headers}) {
    _initDio(baseUrl: ApiNames.baseUrl);
  }

  _initDio({String? baseUrl}) async {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiNames.baseUrl,
        connectTimeout: 60 * 1000,
        receiveTimeout: 60 * 1000,
      ),
    )
      ..interceptors.add(_getCacheManager(baseUrl ?? ApiNames.baseUrl).interceptor)
      ..interceptors.add(LogInterceptor(responseBody: true, requestBody: true, logPrint: (data) {}));
  }

  DioCacheManager _getCacheManager(String baseUrl) {
    _manager = DioCacheManager(CacheConfig(baseUrl: baseUrl, defaultRequestMethod: 'POST'));
    return _manager;
  }

  Options _buildCacheOptions() {
    return buildCacheOptions(
      const Duration(days: 3),
      maxStale: const Duration(days: 7),
      forceRefresh: forceRefresh,
      options: Options(extra: {}),
    );
  }

  Future<dynamic> post({required String url, required Map<String, dynamic> body, bool showLoader = true}) async {
    if (showLoader) LoadingDialog.showLoadingDialog();
    _dio.options.headers = await _getHeader();
    Map params = {'params': body};
    try {
      var response = await _dio.post('$url', data: params);
      print('response ${response.statusCode}');
      if (showLoader) LoadingDialog.dismissDialog();
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      } else {
        showErrorMessage(response);
      }
    } on DioError catch (e) {
      if (showLoader) LoadingDialog.dismissDialog();
      throw Exception(ErrorResponse(message: e.message));
    }

    return null;
  }

  Future<dynamic> put({required String url, required Map<String, dynamic> body, bool showLoader = true}) async {
    if (showLoader) LoadingDialog.showLoadingDialog();

    _printRequestBody(body);
    _dio.options.headers = await _getHeader();
    try {
      var response = await _dio.put('$url', data: body);
      print('response ${response.statusCode}');
      if (showLoader) LoadingDialog.dismissDialog();
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      } else {
        showErrorMessage(response);
      }
    } on DioError catch (e) {
      if (showLoader) LoadingDialog.dismissDialog();
      throw Exception(ErrorResponse(message: e.message));
    }

    return null;
  }

  Future<dynamic> patch({required String url, required Map<String, dynamic> body, bool showLoader = true}) async {
    if (showLoader) LoadingDialog.showLoadingDialog();
    _printRequestBody(body);
    _dio.options.headers = await _getHeader();
    try {
      var response = await _dio.patch('$url', data: body);
      print('response ${response.statusCode}');
      if (showLoader) LoadingDialog.dismissDialog();
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      } else {
        showErrorMessage(response);
      }
    } on DioError catch (e) {
      if (showLoader) LoadingDialog.dismissDialog();
      throw Exception(ErrorResponse(message: e.message));
    }

    return null;
  }

  Future<dynamic> delete({required String url, required Map<String, dynamic> body, bool showLoader = true}) async {
    if (showLoader) LoadingDialog.showLoadingDialog();
    _printRequestBody(body);
    _dio.options.headers = await _getHeader();
    try {
      var response = await _dio.delete('$url', data: body);
      print('body response ${response.statusCode}');
      if (showLoader) LoadingDialog.dismissDialog();
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      } else {
        showErrorMessage(response);
      }
    } on DioError catch (e) {
      if (showLoader) LoadingDialog.dismissDialog();
      throw Exception(ErrorResponse(message: e.message));
    }

    return null;
  }

  Future<dynamic> uploadChatFile(String url, Map<String, dynamic> body, {bool showLoader = true}) async {
    if (showLoader) LoadingDialog.showLoadingDialog();
    _printRequestBody(body);
    FormData formData = FormData.fromMap(body);
    body.forEach((key, value) async {
      if ((value) is File) {
        //create multipart using filepath, string or bytes
        MapEntry<String, MultipartFile> pic = MapEntry(
          '$key',
          MultipartFile.fromFileSync(value.path, filename: value.path.split('/').last),
        );
        //add multipart to request
        formData.files.add(pic);
      } else if ((value) is List<File>) {
        List<MapEntry<String, MultipartFile>> files = [];
        value.forEach((element) async {
          MapEntry<String, MultipartFile> pic = MapEntry(
              '$key',
              MultipartFile.fromFileSync(
                element.path,
                filename: element.path.split('/').last,
              ));
          files.add(pic);
        });
        formData.files.addAll(files);
      } else {
        // requestData.addAll({"$key":"$value"});

      }
    });

    _dio.options.headers = await _getHeader();
    //create multipart request for POST or PATCH method

    try {
      var response = await _dio.post('$url', data: formData);
      print('response ${response.statusCode}');
      if (showLoader) LoadingDialog.dismissDialog();
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      } else {
        showErrorMessage(response);
      }
    } on DioError catch (e) {
      if (showLoader) LoadingDialog.dismissDialog();
      throw Exception(ErrorResponse(message: e.message));
    }

    return null;
  }

  void _printRequestBody(Map<String, dynamic> body) {
    print('-------------------------------------------------------------------');
    log('$body');
    print('-------------------------------------------------------------------');
  }

  Future<dynamic> get({required String url}) async {
    try {
      _dio.options.headers = await _getHeader();
      var response = await _dio.get(url, options: _buildCacheOptions());
      print('response ${response.statusCode}');
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      } else {
        showErrorMessage(response);
      }
    } on DioError catch (e) {
      showErrorMessage(e.response);
    }
    return null;
  }

  showErrorMessage(Response? response) {
    if (response == null) {
      print('failed response Check Server');
      // Utils.showErrorDialog(
      //     context: context, error: 'يوجد خطأ في الاتصال بالخادم');
      throw PlatformException(details: ErrorResponse(message: 'result_error'), code: '');
    } else {
      switch (response.statusCode) {
        case 500:
        case 501:
        case 502:
        case 503:
        case 504:
        case 505:
          throw PlatformException(details: ErrorResponse(message: 'result_error'), code: '500');

        case 404:
          throw PlatformException(details: ErrorResponse(message: 'result_error'), code: '500');
        case 401:
        case 301:
        case 302:
          tokenExpired();
          break;
      }
    }
  }

  _getHeader() async {
    final preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString('token');
    var httpHeaders = {
      'Content-type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
    if (headers != null) {
      httpHeaders.addAll(headers!);
    }
    return httpHeaders;
  }

  void tokenExpired() async {
    AutoRouter.of(context).popUntilRouteWithName(HomeScreenRoute.name);
  }
}
