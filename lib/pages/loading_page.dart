import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend_tambakku/logic/states_new.dart';
import 'package:frontend_tambakku/pages/layout.dart';
import 'package:frontend_tambakku/pages/login_page.dart';
import 'package:frontend_tambakku/util/styles.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingScreen extends ConsumerStatefulWidget {
  const LoadingScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoadingScreenState();
}

//================================ Loading Screen ==========================//
/// Flow :
/// Ketika Selesai login atau register, maka akan diarahkan ke halaman ini
/// Halaman ini akan menampilkan loading screen sambil menunggu data dari server
///
/// Fetch data base_info user dari server
///
///
class _LoadingScreenState extends ConsumerState<LoadingScreen> {
  Future<void> _getBaseInfo() async {
    final token = await ref.watch(tokenProvider.future);

    // Cek apakah token sudah ada belum jika ada arahkan ke Homepage jika belum ke login
    token.isEmpty
        ? Future.delayed(
            const Duration(seconds: 3),
            () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const LoginPage()));
            },
          )
        : Future.delayed(
            const Duration(seconds: 3),
            () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const Layout()));
            },
          );
  }

  @override
  Widget build(BuildContext context) {
    _getBaseInfo();

    return Scaffold(
        body: Stack(children: [
      Image.asset(
        "lib/assets/register-bg.png",
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      ),
      Center(
        child: SizedBox(
          width: 400,
          height: 400,
          child: Image.asset('lib/assets/loading-screen.gif'),
        ),
      ),
      Positioned(
        top: 550,
        left: 50,
        child: Row(
          // crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Text(
              "Tunggu Sebentar yaa",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
            ),
            const SizedBox(
              width: 10,
            ),
            LoadingAnimationWidget.waveDots(
                color: CustomColors.primary, size: 20)
          ],
        ),
      )
    ]));
  }
}
