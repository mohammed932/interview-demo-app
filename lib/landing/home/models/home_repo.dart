import 'package:base_flutter/landing/home/models/post/post_model.dart';
import 'package:base_flutter/landing/home/models/user/user_model.dart';
import 'package:base_flutter/shared/services/service_handler/dio_helper.dart';
import 'package:flutter/material.dart';

class HomeRepo {
  static Future<List<UserModel>> getUsers({required BuildContext context}) async {
    try {
      List<UserModel> users = await GenericHttp<UserModel>(context).callApi(
        endpoint: 'users',
        returnType: ReturnType.List,
        returnDataFun: (data) => data,
        methodType: MethodType.Get,
        fromJsonFunc: (json) => UserModel.fromJson(json),
      ) as List<UserModel>;
      return users;
    } catch (e) {
      throw e;
    }
  }

  static Future<List<PostModel>> getPosts({required BuildContext context}) async {
    try {
      List<PostModel> users = await GenericHttp<PostModel>(context).callApi(
        endpoint: 'posts',
        returnType: ReturnType.List,
        returnDataFun: (data) => data,
        methodType: MethodType.Get,
        fromJsonFunc: (json) => PostModel.fromJson(json),
      ) as List<PostModel>;
      return users;
    } catch (e) {
      throw e;
    }
  }
}
