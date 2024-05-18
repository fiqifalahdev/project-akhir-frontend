import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomColors {
  static const Color primary = Color(0xff227BE5);
  static const Color darkBlue = Color(0xff02306A);
  static const Color lightBlue = Color(0xff6CC3FF);
  static Color blackOpacity = Colors.black.withOpacity(0.7);
  static const Color acceptButton = Color.fromARGB(255, 22, 193, 42);
  static const Color putih = Colors.white;
  static const Color kuningGradient = Color(0xffFFF4E0);
  static const Color kuningMustard = Color(0xffFFB025);
  static const Color teksAbu = Color(0xff94A2AB);

  static const BoxShadow boxShadow = BoxShadow(
      color: Color.fromARGB(25, 0, 0, 0),
      offset: Offset(2, 4),
      spreadRadius: 4,
      blurRadius: 15);

  static ButtonStyle outlinedButtonStyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color?>(Colors.white),
    foregroundColor: MaterialStateProperty.all<Color?>(Colors.white),
    overlayColor: MaterialStateProperty.all<Color?>(
        CustomColors.lightBlue.withOpacity(0.2)),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
        side: const BorderSide(color: CustomColors.primary),
      ),
    ),
  );
}
