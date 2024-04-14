// import 'package:flutter/material.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:frontend_tambakku/util/location.dart';
// import 'package:mapbox_gl/mapbox_gl.dart';

// class MapsPageOld extends StatefulWidget {
//   const MapsPageOld({super.key});

//   @override
//   State<MapsPageOld> createState() => _MapsPageOldState();
// }

// class _MapsPageOldState extends State<MapsPageOld> {
//   LocationServices locationServices = LocationServices();
//   late MapboxMapController mapController;
//   late String? token;

//   void _getToken() {
//     token = dotenv.env['PUBLIC_ACCESS_TOKEN'];
//     print(token);
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     locationServices.getLocation();
//     _getToken();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('Maps Page'),
//         ),
//         body: FutureBuilder(
//             future: Future.wait([locationServices.getLocation()]),
//             builder: (context, snapshot) {
//               if (snapshot.hasData) {
//                 // Contoh get longitude di future builder
//                 // print(snapshot.data?[0].longitude);
//                 print(
//                     "${snapshot.data![0].latitude} : Lat,  ${snapshot.data![0].longitude} Long");
//                 // ======== Map ========= //
//                 return Container(
        
//                   width: MediaQuery.of(context).size.width,
//                   height: MediaQuery.of(context).size.height,
//                   child: MapboxMap(
//                     accessToken: token,
//                     onMapCreated: (controller) {
//                       setState(() {
//                         mapController = controller;
//                       });
//                     },
//                     initialCameraPosition: CameraPosition(
//                       zoom: 17,
//                       target: LatLng(snapshot.data![0].latitude,
//                           snapshot.data![0].longitude),
//                     ),
//                   ),
//                 );
//               } else {
//                 return Text("Loading...");
//               }
//             }));
//   }
// }
