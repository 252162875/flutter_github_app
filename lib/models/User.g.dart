// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'User.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
      json['login'] as String,
      json['avatar_url'] as String,
      json['type'] as String,
      json['name'] as String,
      json['company'] as String,
      json['blog'] as String,
      json['location'] as String,
      json['email'] as String,
      json['bio'] as String,
      json['public_repos'] as int,
      json['followers'] as int,
      json['following'] as int,
      json['created_at'] as String,
      json['updated_at'] as String,
      json['total_private_repos'] as int,
      json['owned_private_repos'] as int);
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'login': instance.login,
      'avatar_url': instance.avatarUrl,
      'type': instance.type,
      'name': instance.name,
      'company': instance.company,
      'blog': instance.blog,
      'location': instance.location,
      'email': instance.email,
      'bio': instance.bio,
      'public_repos': instance.publicRepos,
      'followers': instance.followers,
      'following': instance.following,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'total_private_repos': instance.totalPrivateRepos,
      'owned_private_repos': instance.ownedPrivateRepos
    };
