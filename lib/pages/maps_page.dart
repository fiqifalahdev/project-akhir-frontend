import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend_tambakku/logic/states_new.dart';
import 'package:frontend_tambakku/util/location.dart';
import 'package:frontend_tambakku/util/styles.dart';
import 'package:geolocator/geolocator.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class MapsPage extends StatefulWidget {
  const MapsPage({super.key});

  @override
  State<MapsPage> createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  // Get location provider in state

  LocationServices locationServices = LocationServices();
  late Position position;
  late CameraPosition _cameraPosition;
  late MapboxMapController mapController;
  late String? token;

  void _getToken() {
    token = dotenv.env['PUBLIC_ACCESS_TOKEN'];
  }

  Future<void> _onMapCreated(MapboxMapController controller) async {
    mapController = controller;
  }

  _onStyleLoadedCallback() async {}

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getToken();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final longlat = ref.watch(locationProvider);

      print("longlat : $longlat");

      return SafeArea(
        child: Stack(
          children: [
            Positioned(
                top: 0,
                left: 0,
                bottom: 0,
                right: 0,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: MapboxMap(
                    accessToken: token!,
                    initialCameraPosition: CameraPosition(
                      zoom: 17,
                      target:
                          LatLng(longlat['latitude']!, longlat['longitude']!),
                    ),
                    onMapCreated: _onMapCreated,
                    myLocationEnabled: true,
                    onStyleLoadedCallback: _onStyleLoadedCallback,
                    myLocationTrackingMode: MyLocationTrackingMode.TrackingGPS,
                    minMaxZoomPreference: const MinMaxZoomPreference(14, 20),
                  ),
                )),
            // Positioned(
            //   top: 0,
            //   left: 0,
            //   bottom: 0,
            //   right: 0,
            //   child: SizedBox(
            //       width: MediaQuery.of(context).size.width,
            //       height: MediaQuery.of(context).size.height,
            //       child: FutureBuilder(
            //           future: Future.wait([locationServices.getLocation()]),
            //           builder: (context, snapshot) {
            //             if (snapshot.hasData) {
            //               // Contoh get longitude di future builder
            //               // print(snapshot.data?[0].longitude);
            //               print(
            //                   "${snapshot.data![0].latitude} : Lat,  ${snapshot.data![0].longitude} Long");
            //               // ======== Map ========= //
            //               return MapboxMap(
            //                 accessToken: token,
            //                 onMapCreated: _onMapCreated,
            //                 initialCameraPosition: CameraPosition(
            //                   zoom: 17,
            //                   target: LatLng(snapshot.data![0].latitude,
            //                       snapshot.data![0].longitude),
            //                 ),
            //                 // myLocationEnabled: true,
            //               );
            //             } else {
            //               return Row(
            //                 // crossAxisAlignment: CrossAxisAlignment.end,
            //                 mainAxisAlignment: MainAxisAlignment.center,
            //                 children: [
            //                   const Text(
            //                     "Tunggu Sebentar yaa",
            //                     style: TextStyle(
            //                         fontWeight: FontWeight.w600, fontSize: 20),
            //                   ),
            //                   const SizedBox(
            //                     width: 10,
            //                   ),
            //                   LoadingAnimationWidget.waveDots(
            //                       color: CustomColors.primary, size: 20)
            //                 ],
            //               );
            //             }
            //           })),
            // ),
            Positioned(
              top: 20,
              left: 20,
              child: Container(
                decoration: BoxDecoration(
                  color: CustomColors.putih,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: const [CustomColors.boxShadow],
                ),
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context, 0);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    color: CustomColors.primary,
                  ),
                  iconSize: 30,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
