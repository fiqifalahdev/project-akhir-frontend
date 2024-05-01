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
      birthdate: json['birthdate'] as String,
      gender: json['gender'] as String,
      role: json['role'] as String,
    );

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'password': instance.password,
      'password_confirmation': instance.password_confirmation,
      'phone': instance.phone,
      'birthdate': instance.birthdate,
      'gender': instance.gender,
      'role': instance.role,
    };
