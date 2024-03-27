// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

User _$UserFromJson(Map<String, dynamic> json) {
  return _User.fromJson(json);
}

/// @nodoc
mixin _$User {
  String get name => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String? get password => throw _privateConstructorUsedError;
  String? get password_confirmation => throw _privateConstructorUsedError;
  String get phone => throw _privateConstructorUsedError;
  String get gender => throw _privateConstructorUsedError;
  String get birthdate => throw _privateConstructorUsedError;
  String? get role => throw _privateConstructorUsedError;
  String? get address => throw _privateConstructorUsedError;
  String? get about => throw _privateConstructorUsedError;
  String? get profile_image => throw _privateConstructorUsedError;
  String? get banner_image => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserCopyWith<User> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserCopyWith<$Res> {
  factory $UserCopyWith(User value, $Res Function(User) then) =
      _$UserCopyWithImpl<$Res, User>;
  @useResult
  $Res call(
      {String name,
      String email,
      String? password,
      String? password_confirmation,
      String phone,
      String gender,
      String birthdate,
      String? role,
      String? address,
      String? about,
      String? profile_image,
      String? banner_image});
}

/// @nodoc
class _$UserCopyWithImpl<$Res, $Val extends User>
    implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? email = null,
    Object? password = freezed,
    Object? password_confirmation = freezed,
    Object? phone = null,
    Object? gender = null,
    Object? birthdate = null,
    Object? role = freezed,
    Object? address = freezed,
    Object? about = freezed,
    Object? profile_image = freezed,
    Object? banner_image = freezed,
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
      password: freezed == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String?,
      password_confirmation: freezed == password_confirmation
          ? _value.password_confirmation
          : password_confirmation // ignore: cast_nullable_to_non_nullable
              as String?,
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
      role: freezed == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      about: freezed == about
          ? _value.about
          : about // ignore: cast_nullable_to_non_nullable
              as String?,
      profile_image: freezed == profile_image
          ? _value.profile_image
          : profile_image // ignore: cast_nullable_to_non_nullable
              as String?,
      banner_image: freezed == banner_image
          ? _value.banner_image
          : banner_image // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserImplCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$$UserImplCopyWith(
          _$UserImpl value, $Res Function(_$UserImpl) then) =
      __$$UserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String email,
      String? password,
      String? password_confirmation,
      String phone,
      String gender,
      String birthdate,
      String? role,
      String? address,
      String? about,
      String? profile_image,
      String? banner_image});
}

/// @nodoc
class __$$UserImplCopyWithImpl<$Res>
    extends _$UserCopyWithImpl<$Res, _$UserImpl>
    implements _$$UserImplCopyWith<$Res> {
  __$$UserImplCopyWithImpl(_$UserImpl _value, $Res Function(_$UserImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? email = null,
    Object? password = freezed,
    Object? password_confirmation = freezed,
    Object? phone = null,
    Object? gender = null,
    Object? birthdate = null,
    Object? role = freezed,
    Object? address = freezed,
    Object? about = freezed,
    Object? profile_image = freezed,
    Object? banner_image = freezed,
  }) {
    return _then(_$UserImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: freezed == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String?,
      password_confirmation: freezed == password_confirmation
          ? _value.password_confirmation
          : password_confirmation // ignore: cast_nullable_to_non_nullable
              as String?,
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
      role: freezed == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      about: freezed == about
          ? _value.about
          : about // ignore: cast_nullable_to_non_nullable
              as String?,
      profile_image: freezed == profile_image
          ? _value.profile_image
          : profile_image // ignore: cast_nullable_to_non_nullable
              as String?,
      banner_image: freezed == banner_image
          ? _value.banner_image
          : banner_image // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserImpl with DiagnosticableTreeMixin implements _User {
  const _$UserImpl(
      {required this.name,
      required this.email,
      required this.password,
      required this.password_confirmation,
      required this.phone,
      required this.gender,
      required this.birthdate,
      this.role,
      this.address,
      this.about,
      this.profile_image,
      this.banner_image});

  factory _$UserImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserImplFromJson(json);

  @override
  final String name;
  @override
  final String email;
  @override
  final String? password;
  @override
  final String? password_confirmation;
  @override
  final String phone;
  @override
  final String gender;
  @override
  final String birthdate;
  @override
  final String? role;
  @override
  final String? address;
  @override
  final String? about;
  @override
  final String? profile_image;
  @override
  final String? banner_image;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'User(name: $name, email: $email, password: $password, password_confirmation: $password_confirmation, phone: $phone, gender: $gender, birthdate: $birthdate, role: $role, address: $address, about: $about, profile_image: $profile_image, banner_image: $banner_image)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'User'))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('email', email))
      ..add(DiagnosticsProperty('password', password))
      ..add(DiagnosticsProperty('password_confirmation', password_confirmation))
      ..add(DiagnosticsProperty('phone', phone))
      ..add(DiagnosticsProperty('gender', gender))
      ..add(DiagnosticsProperty('birthdate', birthdate))
      ..add(DiagnosticsProperty('role', role))
      ..add(DiagnosticsProperty('address', address))
      ..add(DiagnosticsProperty('about', about))
      ..add(DiagnosticsProperty('profile_image', profile_image))
      ..add(DiagnosticsProperty('banner_image', banner_image));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.password_confirmation, password_confirmation) ||
                other.password_confirmation == password_confirmation) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.birthdate, birthdate) ||
                other.birthdate == birthdate) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.about, about) || other.about == about) &&
            (identical(other.profile_image, profile_image) ||
                other.profile_image == profile_image) &&
            (identical(other.banner_image, banner_image) ||
                other.banner_image == banner_image));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      name,
      email,
      password,
      password_confirmation,
      phone,
      gender,
      birthdate,
      role,
      address,
      about,
      profile_image,
      banner_image);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      __$$UserImplCopyWithImpl<_$UserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserImplToJson(
      this,
    );
  }
}

abstract class _User implements User {
  const factory _User(
      {required final String name,
      required final String email,
      required final String? password,
      required final String? password_confirmation,
      required final String phone,
      required final String gender,
      required final String birthdate,
      final String? role,
      final String? address,
      final String? about,
      final String? profile_image,
      final String? banner_image}) = _$UserImpl;

  factory _User.fromJson(Map<String, dynamic> json) = _$UserImpl.fromJson;

  @override
  String get name;
  @override
  String get email;
  @override
  String? get password;
  @override
  String? get password_confirmation;
  @override
  String get phone;
  @override
  String get gender;
  @override
  String get birthdate;
  @override
  String? get role;
  @override
  String? get address;
  @override
  String? get about;
  @override
  String? get profile_image;
  @override
  String? get banner_image;
  @override
  @JsonKey(ignore: true)
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
