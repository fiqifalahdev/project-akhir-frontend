// class User {
//   // required Data
//   final String name;
//   final String email;
//   final String password;
//   final String phone;
//   final String gender;
//   final String birthdate;
//   // Additional Data
//   final String? address;
//   final String? long;
//   final String? lat;
//   final String? kelId;
//   final String? about;
//   final String? profileImage;
//   final String? bannerImage;

//   // Construct and assign user data
//   User(
//       {required this.name,
//       required this.email,
//       required this.password,
//       required this.phone,
//       required this.gender,
//       required this.birthdate,
//       this.address,
//       this.long,
//       this.lat,
//       this.kelId,
//       this.about,
//       this.profileImage,
//       this.bannerImage});

//   // Get User data from JSON
//   factory User.fromJson(Map<String, dynamic> json) {
//     return User(
//       name: json['name'],
//       phone: json['phone'],
//       gender: json['gender'],
//       birthdate: json['birthdate'],
//       email: json['email'],
//       password: json['password'],
//       address: json['address'],
//       long: json['long'],
//       lat: json['lat'],
//       kelId: json['kelId'],
//       about: json['about'],
//       profileImage: json['profileImage'],
//       bannerImage: json['bannerImage'],
//     );
//   }

//   // Convert User data to JSON
//   Map<String, dynamic> toJson() => {
//         'name': name,
//         'phone': phone,
//         'gender': birthdate,
//         'email': email,
//         'password': password,
//         'address': address,
//         'long': long,
//         'lat': lat,
//         'kelId': kelId,
//         'about': about,
//         'profileImage': profileImage,
//         'bannerImage': bannerImage,
//       };
// }

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const factory User(
      {required String name,
      required String email,
      required String password,
      required String? password_confirmation,
      required String phone,
      required String gender,
      required String birthdate,
      String? address,
      String? long,
      String? lat,
      String? kelId,
      String? about,
      String? profileImage,
      String? bannerImage}) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
