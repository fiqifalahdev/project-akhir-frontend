import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend_tambakku/pages/introduction_page.dart';
import 'package:frontend_tambakku/pages/home_page.dart';
import 'package:frontend_tambakku/pages/layout.dart';
import 'package:frontend_tambakku/pages/loading_page.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tambakku APP 1.0.0',
      home: const IntroductionPage(),
      // home: const LoadingScreen(),
      // home: const Layout(), // Setelah Login Diarahkan ke sini
      theme: ThemeData(fontFamily: 'Montserrat'),
      debugShowCheckedModeBanner: false,
    );
  }
}
