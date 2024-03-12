import 'package:flutter/material.dart';
import 'package:frontend_tambakku/pages/introduction_page.dart';
import 'package:frontend_tambakku/pages/login_page.dart';
import 'package:frontend_tambakku/pages/register_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tambakku APP 1.0.0',
      home: const IntroductionPage(),
      // home: const LoginPage(),
      // home: const RegisterPage(),
      theme: ThemeData(fontFamily: 'Montserrat'),
      debugShowCheckedModeBanner: false,
    );
  }
}
