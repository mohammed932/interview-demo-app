// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      albumId: json['albumId'] as int,
      name: json['name'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String,
      url: json['url'] as String,
      userId: json['userId'] as int,
      posts: (json['posts'] as List<dynamic>?)
              ?.map((e) => PostModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'albumId': instance.albumId,
      'userId': instance.userId,
      'posts': instance.posts,
      'name': instance.name,
      'url': instance.url,
      'thumbnailUrl': instance.thumbnailUrl,
    };
