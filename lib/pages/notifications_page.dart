import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:frontend_tambakku/util/styles.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => NotificationPageState();
}

class NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    // Get Arguments from routing that defined in FirebaseAPI when it get a message
    final arguments = ModalRoute.of(context)!.settings.arguments;

    late RemoteMessage message = arguments as RemoteMessage;
    // Get the message from the arguments
    // print("Message: ${message.notification?.title}");

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
          title: const Text(
            'Notifikasi anda',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          ),
          backgroundColor: CustomColors.primary,
          centerTitle: true,
          leading: IconButton(
            icon:
                const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
            onPressed: () {
              print("OKE");
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/home',
                (route) {
                  return false;
                },
              );
            },
          )),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              message.notification?.title ?? "No Title",
              style: const TextStyle(fontSize: 20),
            ),
            Text(
              message.notification?.body ?? "No Body",
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    ));
  }
  // @override
  // Widget build(BuildContext context) {
  //   return Material(
  //     child: Container(
  //       child: EasyDateTimeLine(
  //         initialDate: DateTime.now(),
  //         onDateChange: (selectedDate) {
  //           //`selectedDate` the new date selected.
  //         },
  //         dayProps: const EasyDayProps(
  //           height: 56.0,
  //           // You must specify the width in this case.
  //           width: 124.0,
  //         ),
  //         headerProps: const EasyHeaderProps(
  //           dateFormatter: DateFormatter.fullDateMonthAsStrDY(),
  //         ),
  //         locale: 'id_ID',
  //         itemBuilder: (BuildContext context, String dayNumber, dayName,
  //             monthName, fullDate, isSelected) {
  //           return Container(
  //             //the same width that provided previously.
  //             width: 124.0,
  //             padding: const EdgeInsets.symmetric(horizontal: 8.0),
  //             decoration: BoxDecoration(
  //               color: isSelected ? CustomColors.primary : null,
  //               borderRadius: BorderRadius.circular(16.0),
  //             ),
  //             child: Column(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: [
  //                 const SizedBox(
  //                   width: 8.0,
  //                 ),
  //                 Text(
  //                   dayNumber,
  //                   style: TextStyle(
  //                     fontSize: 20,
  //                     fontWeight: FontWeight.bold,
  //                     color:
  //                         isSelected ? Colors.white : const Color(0xff393646),
  //                   ),
  //                 ),
  //                 const SizedBox(
  //                   width: 8.0,
  //                 ),
  //                 Text(
  //                   dayName,
  //                   style: TextStyle(
  //                     fontSize: 12,
  //                     color:
  //                         isSelected ? Colors.white : const Color(0xff6D5D6E),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           );
  //         },
  //       ),
  //     ),
  //   );
  // }
}
