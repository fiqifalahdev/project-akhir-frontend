import 'package:freezed_annotation/freezed_annotation.dart';

part 'appointmentrequest.freezed.dart';
part 'appointmentrequest.g.dart';

@freezed
class AppointmentRequest with _$AppointmentRequest {
  const factory AppointmentRequest(
      {required DateTime appointment_date,
      required String appointment_time,
      int? requester_id,
      int? recipient_id,
      String? status}) = _AppointmentRequest;

  factory AppointmentRequest.fromJson(Map<String, dynamic> json) =>
      _$AppointmentRequestFromJson(json);
}
