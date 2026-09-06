// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointmentrequest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppointmentRequestImpl _$$AppointmentRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$AppointmentRequestImpl(
      appointment_date: DateTime.parse(json['appointment_date'] as String),
      appointment_time: json['appointment_time'] as String,
      requester_id: json['requester_id'] as int?,
      recipient_id: json['recipient_id'] as int?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$$AppointmentRequestImplToJson(
        _$AppointmentRequestImpl instance) =>
    <String, dynamic>{
      'appointment_date': instance.appointment_date.toIso8601String(),
      'appointment_time': instance.appointment_time,
      'requester_id': instance.requester_id,
      'recipient_id': instance.recipient_id,
      'status': instance.status,
    };
