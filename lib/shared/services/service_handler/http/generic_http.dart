import 'package:base_flutter/shared/services/service_handler/http_handler/dio.imports.dart';
import 'package:flutter/material.dart';

enum ReturnType { Model, List, Type }

enum MethodType { Get, Post, Put, Patch, Delete }

class GenericHttp<T> {
  final BuildContext context;

  GenericHttp(this.context);

  Future<dynamic> callApi(
      {required ReturnType returnType,
      required MethodType methodType,
      required String endpoint,
      Function(dynamic data)? returnDataFun,
      Map<String, dynamic>? json,
      Map<String, String>? headers,
      String? baseUrl,
      bool? showLoader = false,
      Function(dynamic data)? fromJsonFunc,
      bool refresh = true}) async {
    var dataJson = json ?? {};

    switch (methodType) {
      case MethodType.Get:
        return _getData(
            name: endpoint,
            returnType: returnType,
            refresh: refresh,
            baseUrl: baseUrl,
            headers: headers,
            dataKeyFun: returnDataFun,
            toJsonFunc: fromJsonFunc);
      case MethodType.Post:
        return _postData(
            name: endpoint,
            baseUrl: baseUrl,
            returnType: returnType,
            json: dataJson,
            showLoader: showLoader,
            dataKeyFun: returnDataFun,
            toJsonFunc: fromJsonFunc);
      case MethodType.Patch:
        return _patchData(
            name: endpoint,
            returnType: returnType,
            json: dataJson,
            showLoader: showLoader,
            dataKeyFun: returnDataFun,
            toJsonFunc: fromJsonFunc);
      case MethodType.Put:
        return _putData(
            name: endpoint,
            returnType: returnType,
            json: dataJson,
            showLoader: showLoader,
            dataKeyFun: returnDataFun,
            toJsonFunc: fromJsonFunc);
      case MethodType.Delete:
        return _deleteData(
            name: endpoint,
            returnType: returnType,
            json: dataJson,
            showLoader: showLoader,
            dataKeyFun: returnDataFun,
            toJsonFunc: fromJsonFunc);
    }
  }

  Future<dynamic> _getData({
    required ReturnType returnType,
    required String name,
    Function(dynamic data)? dataKeyFun,
    bool refresh = true,
    String? baseUrl,
    Map<String, String>? headers,
    Function(dynamic data)? toJsonFunc,
  }) async {
    var data =
        await DioHelper(context: context, forceRefresh: refresh, baseUrl: baseUrl, headers: headers).get(url: name);
    return _returnDataFromType(data, returnType, toJsonFunc ?? (val) {}, dataKeyFun);
  }

  Future<dynamic> _postData({
    required ReturnType returnType,
    required String name,
    String? baseUrl,
    Function(dynamic data)? dataKeyFun,
    Map<String, dynamic> json = const {},
    bool? showLoader,
    Function(dynamic data)? toJsonFunc,
  }) async {
    var data = await DioHelper(
      context: context,
      baseUrl: baseUrl,
    ).post(url: name, body: json, showLoader: showLoader ?? true);
    return _returnDataFromType(data, returnType, toJsonFunc ?? (val) {}, dataKeyFun);
  }

  Future<dynamic> _putData({
    required ReturnType returnType,
    required String name,
    Function(dynamic data)? dataKeyFun,
    Map<String, dynamic> json = const {},
    bool? showLoader,
    Function(dynamic data)? toJsonFunc,
  }) async {
    var data = await DioHelper(
      context: context,
    ).put(url: name, body: json, showLoader: showLoader ?? true);
    return _returnDataFromType(data, returnType, toJsonFunc ?? (val) {}, dataKeyFun);
  }

  Future<dynamic> _patchData({
    required ReturnType returnType,
    required String name,
    Function(dynamic data)? dataKeyFun,
    Map<String, dynamic> json = const {},
    bool? showLoader,
    Function(dynamic data)? toJsonFunc,
  }) async {
    var data = await DioHelper(
      context: context,
    ).patch(url: name, body: json, showLoader: showLoader ?? true);
    return _returnDataFromType(data, returnType, toJsonFunc ?? (val) {}, dataKeyFun);
  }

  Future<dynamic> _deleteData({
    required ReturnType returnType,
    required String name,
    Function(dynamic data)? dataKeyFun,
    Map<String, dynamic> json = const {},
    bool? showLoader,
    Function(dynamic data)? toJsonFunc,
  }) async {
    var data = await DioHelper(
      context: context,
    ).delete(url: name, body: json, showLoader: showLoader ?? true);
    return _returnDataFromType(data, returnType, toJsonFunc ?? (val) {}, dataKeyFun);
  }

  dynamic _returnDataFromType(
    dynamic data,
    ReturnType returnType,
    Function(dynamic data) toJsonFunc,
    Function(dynamic data)? dataKeyFun,
  ) async {
    switch (returnType) {
      case ReturnType.Type:
        return dataKeyFun == null ? data : Function.apply(dataKeyFun, [data]);
      case ReturnType.Model:
        return Function.apply(toJsonFunc, [
          dataKeyFun == null ? data : Function.apply(dataKeyFun, [data])
        ]);

      case ReturnType.List:
        return List<T>.from(
          dataKeyFun == null
              ? data
              : Function.apply(dataKeyFun, [data]).map(
                  (e) => Function.apply(toJsonFunc, [e]),
                ),
        );
    }
  }
}
