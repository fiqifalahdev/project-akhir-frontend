import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend_tambakku/logic/states_new.dart';
import 'package:frontend_tambakku/pages/layout.dart';
import 'package:frontend_tambakku/pages/login_page.dart';
import 'package:frontend_tambakku/util/location.dart';
import 'package:frontend_tambakku/util/styles.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
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
  // Get user location permission
  LocationServices locationServices = LocationServices();

  Future<void> _getUserLocation() async {
    final location = ref.watch(locationProvider);

    ref.read(addressProvider.notifier).setAddress({
      'address': ref.watch(addressProvider),
      'latitude': location['latitude'].toString(),
      'longitude': location['longitude'].toString()
    });
  }

  Future<void> _getBaseInfo() async {
    final token = ref.watch(tokenProvider);
    // Cek apakah token sudah ada belum jika ada arahkan ke Homepage jika belum ke login
    token.isEmpty
        ? Future.delayed(
            const Duration(seconds: 7),
            () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const LoginPage()));
            },
          )
        : Future.delayed(
            const Duration(seconds: 7),
            () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Layout(
                            index: 0,
                          )));
            },
          );
  }

  Future<void> _getIncomingRequest() async {
    ref.read(incomingRequestProvider.notifier).getIncomingRequest();
  }

  @override
  Widget build(BuildContext context) {
    _getBaseInfo();
    _getUserLocation();
    _getIncomingRequest();

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
        top: 650,
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
