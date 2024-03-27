import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'user.freezed.dart';

part 'user.g.dart';

@freezed
class User with _$User {
  const factory User(
      {required String name,
      required String email,
      required String? password,
      required String? password_confirmation,
      required String phone,
      required String gender,
      required String birthdate,
      String? role,
      String? address,
      String? about,
      String? profile_image,
      String? banner_image}) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

// factory User.fromJson(Map<String, dynamic> json) {
// return User(
// name: json['name'],
// email: json['email'],
// password: json['password'] ?? '',
// password_confirmation: json['password_confirmation'] ?? '',
// phone: json['phone'],
// gender: json['gender'],
// birthdate: json['birthdate'],
// address: json['address'] ?? '',
// about: json['about'] ?? '',
// profileImage: json['profile_image'] ?? '',
// bannerImage: json['banner_image'] ?? ''
// );
// }
