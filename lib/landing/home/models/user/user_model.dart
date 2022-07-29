import 'package:base_flutter/landing/home/models/post/post_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  int albumId;
  int userId;
  List<PostModel> posts;
  String name;
  String url;

  String thumbnailUrl;
  UserModel(
      {required this.albumId,
      required this.name,
      required this.thumbnailUrl,
      required this.url,
      required this.userId,
      this.posts = const []});

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
