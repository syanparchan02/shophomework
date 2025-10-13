import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';


@JsonSerializable()
class UserModel {
  final String email;
  final String username;
  final String password;
  final String phone;

  UserModel(this.email, this.username, this.password, this.phone);

  // fromJson
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  // toJson
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
