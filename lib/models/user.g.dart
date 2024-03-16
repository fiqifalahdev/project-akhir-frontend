// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
      name: json['name'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      password_confirmation: json['password_confirmation'] as String?,
      phone: json['phone'] as String,
      gender: json['gender'] as String,
      birthdate: json['birthdate'] as String,
      address: json['address'] as String?,
      long: json['long'] as String?,
      lat: json['lat'] as String?,
      kelId: json['kelId'] as String?,
      about: json['about'] as String?,
      profileImage: json['profileImage'] as String?,
      bannerImage: json['bannerImage'] as String?,
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
      'address': instance.address,
      'long': instance.long,
      'lat': instance.lat,
      'kelId': instance.kelId,
      'about': instance.about,
      'profileImage': instance.profileImage,
      'bannerImage': instance.bannerImage,
    };
