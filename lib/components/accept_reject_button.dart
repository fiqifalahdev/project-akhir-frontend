import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend_tambakku/components/loading_widget.dart';
import 'package:frontend_tambakku/logic/states_new.dart';
import 'package:frontend_tambakku/util/styles.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:quickalert/quickalert.dart';

class UpdateButton extends StatefulWidget {
  final int status;
  final String appointmentId;
  const UpdateButton(
      {super.key, required this.status, required this.appointmentId});

  @override
  State<UpdateButton> createState() => _UpdateButtonState();
}

class _UpdateButtonState extends State<UpdateButton> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      return TextButton.icon(
        style: ButtonStyle(
            backgroundColor: isLoading
                ? MaterialStateProperty.all<Color>(Colors.grey)
                : widget.status == 1
                    ? MaterialStateProperty.all<Color>(
                        CustomColors.acceptButton)
                    : MaterialStateProperty.all<Color>(Colors.red),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            minimumSize: MaterialStateProperty.all(const Size(30, 30)),
            enableFeedback: !isLoading),
        onPressed: () {
          setState(() {
            isLoading = true;
          });

          ref.read(incomingRequestProvider.notifier).updateAppointment({
            "status": widget.status,
            "appointment_id": widget.appointmentId
          }).then((value) {
            if (value != null) {
              // Show alert using riverpod
              // ref.read(quickAlertProvider.notifier).state = true;
              QuickAlert.show(
                  context: context,
                  type: QuickAlertType.success,
                  title: "Berhasil",
                  text: value);

              setState(() {
                isLoading = false;
              });
            } else {
              // Show alert using riverpod
              // ref.read(quickAlertProvider.notifier).state = true;
              QuickAlert.show(
                  context: context,
                  type: QuickAlertType.error,
                  title: "Gagal",
                  text: "Terjadi kesalahan");

              setState(() {
                isLoading = false;
              });
            }
          });

          setState(() {});
        },
        icon: Icon(
          widget.status == 1 ? Icons.check : Icons.close,
          color: CustomColors.putih,
          size: 20,
        ),
        label: Text(
          widget.status == 1 ? "Terima" : "Tolak",
          style: const TextStyle(color: CustomColors.putih),
        ),
      );
    });
  }
}
