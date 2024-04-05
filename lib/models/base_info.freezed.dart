// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'base_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

BaseInfo _$BaseInfoFromJson(Map<String, dynamic> json) {
  return _BaseInfo.fromJson(json);
}

/// @nodoc
mixin _$BaseInfo {
  String get name => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get phone => throw _privateConstructorUsedError;
  String get gender => throw _privateConstructorUsedError;
  String get birthdate => throw _privateConstructorUsedError;
  String get role => throw _privateConstructorUsedError;
  String? get address => throw _privateConstructorUsedError;
  String? get profileImage => throw _privateConstructorUsedError;
  String? get bannerImage => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BaseInfoCopyWith<BaseInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BaseInfoCopyWith<$Res> {
  factory $BaseInfoCopyWith(BaseInfo value, $Res Function(BaseInfo) then) =
      _$BaseInfoCopyWithImpl<$Res, BaseInfo>;
  @useResult
  $Res call(
      {String name,
      String email,
      String phone,
      String gender,
      String birthdate,
      String role,
      String? address,
      String? profileImage,
      String? bannerImage});
}

/// @nodoc
class _$BaseInfoCopyWithImpl<$Res, $Val extends BaseInfo>
    implements $BaseInfoCopyWith<$Res> {
  _$BaseInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? email = null,
    Object? phone = null,
    Object? gender = null,
    Object? birthdate = null,
    Object? role = null,
    Object? address = freezed,
    Object? profileImage = freezed,
    Object? bannerImage = freezed,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      gender: null == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String,
      birthdate: null == birthdate
          ? _value.birthdate
          : birthdate // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      profileImage: freezed == profileImage
          ? _value.profileImage
          : profileImage // ignore: cast_nullable_to_non_nullable
              as String?,
      bannerImage: freezed == bannerImage
          ? _value.bannerImage
          : bannerImage // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BaseInfoImplCopyWith<$Res>
    implements $BaseInfoCopyWith<$Res> {
  factory _$$BaseInfoImplCopyWith(
          _$BaseInfoImpl value, $Res Function(_$BaseInfoImpl) then) =
      __$$BaseInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String email,
      String phone,
      String gender,
      String birthdate,
      String role,
      String? address,
      String? profileImage,
      String? bannerImage});
}

/// @nodoc
class __$$BaseInfoImplCopyWithImpl<$Res>
    extends _$BaseInfoCopyWithImpl<$Res, _$BaseInfoImpl>
    implements _$$BaseInfoImplCopyWith<$Res> {
  __$$BaseInfoImplCopyWithImpl(
      _$BaseInfoImpl _value, $Res Function(_$BaseInfoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? email = null,
    Object? phone = null,
    Object? gender = null,
    Object? birthdate = null,
    Object? role = null,
    Object? address = freezed,
    Object? profileImage = freezed,
    Object? bannerImage = freezed,
  }) {
    return _then(_$BaseInfoImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      gender: null == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String,
      birthdate: null == birthdate
          ? _value.birthdate
          : birthdate // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      profileImage: freezed == profileImage
          ? _value.profileImage
          : profileImage // ignore: cast_nullable_to_non_nullable
              as String?,
      bannerImage: freezed == bannerImage
          ? _value.bannerImage
          : bannerImage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BaseInfoImpl implements _BaseInfo {
  const _$BaseInfoImpl(
      {required this.name,
      required this.email,
      required this.phone,
      required this.gender,
      required this.birthdate,
      required this.role,
      this.address,
      this.profileImage,
      this.bannerImage});

  factory _$BaseInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$BaseInfoImplFromJson(json);

  @override
  final String name;
  @override
  final String email;
  @override
  final String phone;
  @override
  final String gender;
  @override
  final String birthdate;
  @override
  final String role;
  @override
  final String? address;
  @override
  final String? profileImage;
  @override
  final String? bannerImage;

  @override
  String toString() {
    return 'BaseInfo(name: $name, email: $email, phone: $phone, gender: $gender, birthdate: $birthdate, role: $role, address: $address, profileImage: $profileImage, bannerImage: $bannerImage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BaseInfoImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.birthdate, birthdate) ||
                other.birthdate == birthdate) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.profileImage, profileImage) ||
                other.profileImage == profileImage) &&
            (identical(other.bannerImage, bannerImage) ||
                other.bannerImage == bannerImage));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, email, phone, gender,
      birthdate, role, address, profileImage, bannerImage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BaseInfoImplCopyWith<_$BaseInfoImpl> get copyWith =>
      __$$BaseInfoImplCopyWithImpl<_$BaseInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BaseInfoImplToJson(
      this,
    );
  }
}

abstract class _BaseInfo implements BaseInfo {
  const factory _BaseInfo(
      {required final String name,
      required final String email,
      required final String phone,
      required final String gender,
      required final String birthdate,
      required final String role,
      final String? address,
      final String? profileImage,
      final String? bannerImage}) = _$BaseInfoImpl;

  factory _BaseInfo.fromJson(Map<String, dynamic> json) =
      _$BaseInfoImpl.fromJson;

  @override
  String get name;
  @override
  String get email;
  @override
  String get phone;
  @override
  String get gender;
  @override
  String get birthdate;
  @override
  String get role;
  @override
  String? get address;
  @override
  String? get profileImage;
  @override
  String? get bannerImage;
  @override
  @JsonKey(ignore: true)
  _$$BaseInfoImplCopyWith<_$BaseInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
