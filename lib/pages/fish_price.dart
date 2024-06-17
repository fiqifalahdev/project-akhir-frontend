import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:frontend_tambakku/util/styles.dart';
import 'package:url_launcher/url_launcher.dart';

class FishPrice extends StatefulWidget {
  const FishPrice({super.key});

  @override
  State<FishPrice> createState() => _FishPriceState();
}

class _FishPriceState extends State<FishPrice> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.all(20),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Dapatkan Informasi Terkini Tentang Harga Ikan!",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            const Text(
              "Ingin tahu harga ikan terbaru di pasaran? \n\nKunjungi Harga Ikan Terbaru untuk mendapatkan informasi terkini dan akurat tentang berbagai jenis ikan.  \n\nDengan data yang selalu diperbarui, Anda bisa memastikan mendapatkan harga terbaik untuk kebutuhan Anda.",
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(
              height: 15,
            ),
            RichText(
              text: TextSpan(
                children: [
                  const TextSpan(
                    text: 'Klik ',
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                  TextSpan(
                    text: 'di sini ',
                    style: const TextStyle(
                        color: CustomColors.primary,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat'),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        // Tindakan ketika teks diklik
                        launchUrl(Uri.parse(
                            "https://fishinfojatim.net/HargaPedagang"));
                      },
                  ),
                  const TextSpan(
                    text: 'untuk melihat harga ikan!',
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
