import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend_tambakku/pages/introduction_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:frontend_tambakku/firebase_options.dart';
import 'package:frontend_tambakku/pages/layout.dart';
import 'package:frontend_tambakku/pages/notifications_page.dart';
import 'package:frontend_tambakku/util/firebase_api.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  FirebaseApi().initFirebase();

  await dotenv.load(fileName: 'lib/assets/config/.env');
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tambakku APP 1.0.0',
      theme: ThemeData(fontFamily: 'Montserrat'),
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      initialRoute: '/',
      routes: {
        '/': (context) => const IntroductionPage(),
        '/home': (context) => Layout(
              index: 0,
            ), // Homepage
        '/maps': (context) => Layout(
              index: 1,
            ), // MapsPage
        '/profile': (context) => Layout(
              index: 3,
            ), // ProfilePage
        '/notification': (context) => const NotificationPage(),
      },
    );
  }
}
