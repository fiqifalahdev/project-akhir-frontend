// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
      name: json['name'] as String,
      email: json['email'] as String,
      password: json['password'] as String?,
      password_confirmation: json['password_confirmation'] as String?,
      phone: json['phone'] as String,
      gender: json['gender'] as String,
      birthdate: json['birthdate'] as String,
      role: json['role'] as String?,
      address: json['address'] as String?,
      about: json['about'] as String?,
      profile_image: json['profile_image'] as String?,
      banner_image: json['banner_image'] as String?,
    );

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'password': instance.password,
      'password_confirmation': instance.password_confirmation,
      'phone': instance.phone,
      'gender': instance.gender,
      'birthdate': instance.birthdate,
      'role': instance.role,
      'address': instance.address,
      'about': instance.about,
      'profile_image': instance.profile_image,
      'banner_image': instance.banner_image,
    };
