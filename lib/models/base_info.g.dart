// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BaseInfoImpl _$$BaseInfoImplFromJson(Map<String, dynamic> json) =>
    _$BaseInfoImpl(
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      gender: json['gender'] as String,
      birthdate: json['birthdate'] as String,
      role: json['role'] as String,
      address: json['address'] as String?,
      profile_image: json['profile_image'] as String?,
      banner_image: json['banner_image'] as String?,
    );

Map<String, dynamic> _$$BaseInfoImplToJson(_$BaseInfoImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'gender': instance.gender,
      'birthdate': instance.birthdate,
      'role': instance.role,
      'address': instance.address,
      'profile_image': instance.profile_image,
      'banner_image': instance.banner_image,
    };
