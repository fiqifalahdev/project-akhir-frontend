import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend_tambakku/logic/states_new.dart';
import 'package:frontend_tambakku/util/styles.dart';
import 'package:geocoding/geocoding.dart';
import 'package:latlong2/latlong.dart';

class LocationPage extends ConsumerStatefulWidget {
  const LocationPage({super.key});

  @override
  ConsumerState<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends ConsumerState<LocationPage>
    with TickerProviderStateMixin {
  late String? token;
  late double? defaultLat;
  late double? defaultLong;
  late double? lat;
  late double? long;

  // ============ Map Controller ===========
  late final AnimatedMapController controller = AnimatedMapController(
    vsync: this,
    duration: const Duration(milliseconds: 500),
    curve: Curves.easeInOut,
  );

  // Single marker to hold the user's location
  Marker? userMarker;

  void _getToken() {
    token = dotenv.env['PUBLIC_ACCESS_TOKEN'];
  }

  // Get user coordinates from the provider (lat, long)
  void _getCurrentLocation() async {
    final longlat = ref.read(locationProvider);

    print("longlat : $longlat");

    defaultLat = longlat['latitude'];
    defaultLong = longlat['longitude'];

    print("lat : $defaultLat");
    print("long : $defaultLong");
  }

  // Function to set the marker
  void _setMarker(LatLng position) {
    setState(() {
      userMarker = Marker(
        width: 35.0,
        height: 35.0,
        point: position,
        child: GestureDetector(
          onTap: () {
            print(
                "Marker tapped at ${position.latitude}, ${position.longitude}");
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50),
              boxShadow: const [CustomColors.boxShadow],
            ),
            child: const Icon(
              Icons.circle,
              color: CustomColors.primary,
              size: 30.0,
            ),
          ),
        ),
      );
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getToken();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context, 0);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: CustomColors.putih,
          ),
          iconSize: 20,
        ),
        title: const Text(
          "Lokasi Alamat Anda",
          style:
              TextStyle(color: CustomColors.putih, fontWeight: FontWeight.w600),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: CustomColors.darkBlue,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: FlutterMap(
                mapController: controller.mapController,
                options: MapOptions(
                  initialCenter: LatLng(defaultLat!, defaultLong!),
                  initialZoom: 15.0,
                  onTap: (tapPosition, point) {
                    _setMarker(point);

                    ref
                        .read(locationProvider.notifier)
                        .setLongLat(point.latitude, point.longitude);

                    lat = point.latitude;
                    long = point.longitude;

                    print(point.toString());
                  },
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://api.mapbox.com/styles/v1/fiqifalah/cluxu0d1o003i01qzhjvd6dxs/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiZmlxaWZhbGFoIiwiYSI6ImNsdTJ5em8wczB0bjgya252dnI4dWl3eHIifQ.TMchcRAVp_OJt1UaFPxDvg',
                    userAgentPackageName: 'com.example.app',
                    additionalOptions: {
                      'accessToken': token!,
                      'id': 'mapbox.mapbox-streets-v8',
                    },
                  ),
                  if (userMarker != null) MarkerLayer(markers: [userMarker!]),
                ],
              ),
            ),
          ),
          // Button to confirm the location
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: ElevatedButton(
              onPressed: () async {
                // final location = ref.watch(locationProvider);

                List<Placemark> listOfAddress =
                    await placemarkFromCoordinates(lat!, long!);

                Placemark placemark = listOfAddress[0];

                String address =
                    "${placemark.street}, ${placemark.subLocality}, ${placemark.locality}, ${placemark.subAdministrativeArea}, ${placemark.administrativeArea}, ${placemark.postalCode}, ${placemark.country}";

                ref.read(addressProvider.notifier).state = address;

                Navigator.pop(context, 1);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: CustomColors.primary,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                "Pilih Lokasi",
                style: TextStyle(
                  color: CustomColors.putih,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
