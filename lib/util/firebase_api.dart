import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:frontend_tambakku/main.dart';

/// Class that used for Firebase API
/// it contains logic and how the apps accept the Firebase API functions.
///
/// This class is used in the main.dart file

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Handling a background title: ${message.notification?.title}');
  print('Handling a background body: ${message.notification?.body}');
}

class FirebaseApi {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  void handleMessage(RemoteMessage? message) async {
    if (message == null) return;

    print("Masuk SINI bang");

    navigatorKey.currentState!.pushNamed('/notification', arguments: message);
  }

  Future<void> initPushNotification() async {
    _firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessage.listen(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  }

  void initFirebase() async {
    _firebaseMessaging.requestPermission();

    final token = await _firebaseMessaging.getToken();
    print('FCM Token: $token');

    initPushNotification();
  }
}
