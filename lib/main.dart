import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend_tambakku/pages/introduction_page.dart';
import 'package:frontend_tambakku/pages/profile_page.dart';
// import 'package:frontend_tambakku/pages/maps_page.dart';

void main() async {
  await dotenv.load(fileName: 'lib/assets/config/.env');
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tambakku APP 1.0.0',
      home: const IntroductionPage(), // Setelah Login Diarahkan ke sini
      // home: const MapsPage(),
      // home: const ProfilePage(),
      theme: ThemeData(fontFamily: 'Montserrat'),
      debugShowCheckedModeBanner: false,
    );
  }
}
