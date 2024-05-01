import 'package:freezed_annotation/freezed_annotation.dart';

part 'base_info.freezed.dart';
part 'base_info.g.dart';

@freezed
class BaseInfo with _$BaseInfo {
  const factory BaseInfo({
    required String name,
    required String phone,
    required String gender,
    required String birthdate,
    String? email,
    String? role,
    String? about,
    String? address,
    String? profileImage,
    String? bannerImage,
  }) = _BaseInfo;

  factory BaseInfo.fromJson(Map<String, dynamic> json) =>
      _$BaseInfoFromJson(json);
}
