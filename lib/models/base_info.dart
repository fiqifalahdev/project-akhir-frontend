import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'base_info.freezed.dart';

part 'base_info.g.dart';

@freezed
class BaseInfo with _$BaseInfo {
  const factory BaseInfo(
      {required String name,
      required String email,
      required String phone,
      required String gender,
      required String birthdate,
      required String role,
      String? address,
      String? profile_image,
      String? banner_image}) = _BaseInfo;

  factory BaseInfo.fromJson(Map<String, dynamic> json) =>
      _$BaseInfoFromJson(json);
}
