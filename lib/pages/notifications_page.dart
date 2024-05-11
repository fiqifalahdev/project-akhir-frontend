import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:frontend_tambakku/pages/layout.dart';
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

    RemoteMessage message = arguments as RemoteMessage;
    // Get the message from the arguments
    print("Message: ${message.notification?.title}");

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
}
