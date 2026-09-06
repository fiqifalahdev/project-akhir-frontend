// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'appointmentrequest.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AppointmentRequest _$AppointmentRequestFromJson(Map<String, dynamic> json) {
  return _AppointmentRequest.fromJson(json);
}

/// @nodoc
mixin _$AppointmentRequest {
  DateTime get appointment_date => throw _privateConstructorUsedError;
  String get appointment_time => throw _privateConstructorUsedError;
  int? get requester_id => throw _privateConstructorUsedError;
  int? get recipient_id => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AppointmentRequestCopyWith<AppointmentRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppointmentRequestCopyWith<$Res> {
  factory $AppointmentRequestCopyWith(
          AppointmentRequest value, $Res Function(AppointmentRequest) then) =
      _$AppointmentRequestCopyWithImpl<$Res, AppointmentRequest>;
  @useResult
  $Res call(
      {DateTime appointment_date,
      String appointment_time,
      int? requester_id,
      int? recipient_id,
      String? status});
}

/// @nodoc
class _$AppointmentRequestCopyWithImpl<$Res, $Val extends AppointmentRequest>
    implements $AppointmentRequestCopyWith<$Res> {
  _$AppointmentRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? appointment_date = null,
    Object? appointment_time = null,
    Object? requester_id = freezed,
    Object? recipient_id = freezed,
    Object? status = freezed,
  }) {
    return _then(_value.copyWith(
      appointment_date: null == appointment_date
          ? _value.appointment_date
          : appointment_date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      appointment_time: null == appointment_time
          ? _value.appointment_time
          : appointment_time // ignore: cast_nullable_to_non_nullable
              as String,
      requester_id: freezed == requester_id
          ? _value.requester_id
          : requester_id // ignore: cast_nullable_to_non_nullable
              as int?,
      recipient_id: freezed == recipient_id
          ? _value.recipient_id
          : recipient_id // ignore: cast_nullable_to_non_nullable
              as int?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AppointmentRequestImplCopyWith<$Res>
    implements $AppointmentRequestCopyWith<$Res> {
  factory _$$AppointmentRequestImplCopyWith(_$AppointmentRequestImpl value,
          $Res Function(_$AppointmentRequestImpl) then) =
      __$$AppointmentRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DateTime appointment_date,
      String appointment_time,
      int? requester_id,
      int? recipient_id,
      String? status});
}

/// @nodoc
class __$$AppointmentRequestImplCopyWithImpl<$Res>
    extends _$AppointmentRequestCopyWithImpl<$Res, _$AppointmentRequestImpl>
    implements _$$AppointmentRequestImplCopyWith<$Res> {
  __$$AppointmentRequestImplCopyWithImpl(_$AppointmentRequestImpl _value,
      $Res Function(_$AppointmentRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? appointment_date = null,
    Object? appointment_time = null,
    Object? requester_id = freezed,
    Object? recipient_id = freezed,
    Object? status = freezed,
  }) {
    return _then(_$AppointmentRequestImpl(
      appointment_date: null == appointment_date
          ? _value.appointment_date
          : appointment_date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      appointment_time: null == appointment_time
          ? _value.appointment_time
          : appointment_time // ignore: cast_nullable_to_non_nullable
              as String,
      requester_id: freezed == requester_id
          ? _value.requester_id
          : requester_id // ignore: cast_nullable_to_non_nullable
              as int?,
      recipient_id: freezed == recipient_id
          ? _value.recipient_id
          : recipient_id // ignore: cast_nullable_to_non_nullable
              as int?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AppointmentRequestImpl implements _AppointmentRequest {
  const _$AppointmentRequestImpl(
      {required this.appointment_date,
      required this.appointment_time,
      this.requester_id,
      this.recipient_id,
      this.status});

  factory _$AppointmentRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppointmentRequestImplFromJson(json);

  @override
  final DateTime appointment_date;
  @override
  final String appointment_time;
  @override
  final int? requester_id;
  @override
  final int? recipient_id;
  @override
  final String? status;

  @override
  String toString() {
    return 'AppointmentRequest(appointment_date: $appointment_date, appointment_time: $appointment_time, requester_id: $requester_id, recipient_id: $recipient_id, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppointmentRequestImpl &&
            (identical(other.appointment_date, appointment_date) ||
                other.appointment_date == appointment_date) &&
            (identical(other.appointment_time, appointment_time) ||
                other.appointment_time == appointment_time) &&
            (identical(other.requester_id, requester_id) ||
                other.requester_id == requester_id) &&
            (identical(other.recipient_id, recipient_id) ||
                other.recipient_id == recipient_id) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, appointment_date,
      appointment_time, requester_id, recipient_id, status);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AppointmentRequestImplCopyWith<_$AppointmentRequestImpl> get copyWith =>
      __$$AppointmentRequestImplCopyWithImpl<_$AppointmentRequestImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AppointmentRequestImplToJson(
      this,
    );
  }
}

abstract class _AppointmentRequest implements AppointmentRequest {
  const factory _AppointmentRequest(
      {required final DateTime appointment_date,
      required final String appointment_time,
      final int? requester_id,
      final int? recipient_id,
      final String? status}) = _$AppointmentRequestImpl;

  factory _AppointmentRequest.fromJson(Map<String, dynamic> json) =
      _$AppointmentRequestImpl.fromJson;

  @override
  DateTime get appointment_date;
  @override
  String get appointment_time;
  @override
  int? get requester_id;
  @override
  int? get recipient_id;
  @override
  String? get status;
  @override
  @JsonKey(ignore: true)
  _$$AppointmentRequestImplCopyWith<_$AppointmentRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
