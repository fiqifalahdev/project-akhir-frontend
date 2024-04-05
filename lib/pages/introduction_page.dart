import 'package:flutter/material.dart';
import 'package:frontend_tambakku/pages/login_page.dart';
import 'package:frontend_tambakku/util/styles.dart';

// ================== Introduction Page ===================
// Nanti ditambahkan Stepper dan 2 halaman lagi untuk intro
// ========================================================

class IntroductionPage extends StatefulWidget {
  const IntroductionPage({super.key});

  @override
  State<IntroductionPage> createState() => _IntroductionPageState();
}

class _IntroductionPageState extends State<IntroductionPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset("lib/assets/intro-mancing.png"),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.all(15),
              child: Text(
                "Hubungkan dan Cari Pembudidaya Sekarang! ",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.all(15),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()));
                },
                style: ElevatedButton.styleFrom(
                  textStyle: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: CustomColors.primary,
                ),
                child: const Text("Selanjutnya",
                    style: TextStyle(
                        fontSize: 16,
                        color: CustomColors.putih,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat')),
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              "2024.",
              style: TextStyle(
                  fontFamily: 'MontSerrat',
                  fontSize: 12,
                  fontWeight: FontWeight.bold),
            )
          ]),
    ));
  }
}
