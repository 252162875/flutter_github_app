import 'package:json_annotation/json_annotation.dart';

part 'User.g.dart';

@JsonSerializable()
class User extends Object {
  @JsonKey(name: 'login')
  String login;

  @JsonKey(name: 'avatar_url')
  String avatarUrl;

  @JsonKey(name: 'type')
  String type;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'company')
  String company;

  @JsonKey(name: 'blog')
  String blog;

  @JsonKey(name: 'location')
  String location;

  @JsonKey(name: 'email')
  String email;

  @JsonKey(name: 'bio')
  String bio;

  @JsonKey(name: 'public_repos')
  int publicRepos;

  @JsonKey(name: 'followers')
  int followers;

  @JsonKey(name: 'following')
  int following;

  @JsonKey(name: 'created_at')
  String createdAt;

  @JsonKey(name: 'updated_at')
  String updatedAt;

  @JsonKey(name: 'total_private_repos')
  int totalPrivateRepos;

  @JsonKey(name: 'owned_private_repos')
  int ownedPrivateRepos;

  User(
    this.login,
    this.avatarUrl,
    this.type,
    this.name,
    this.company,
    this.blog,
    this.location,
    this.email,
    this.bio,
    this.publicRepos,
    this.followers,
    this.following,
    this.createdAt,
    this.updatedAt,
    this.totalPrivateRepos,
    this.ownedPrivateRepos,
  );

  factory User.fromJson(Map<String, dynamic> srcJson) =>
      _$UserFromJson(srcJson);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
