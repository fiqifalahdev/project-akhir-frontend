import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend_tambakku/logic/states_new.dart';
import 'package:frontend_tambakku/util/location.dart';
import 'package:frontend_tambakku/util/styles.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:loading_animation_widget/loading_animation_widget.dart';
// import 'package:mapbox_gl/mapbox_gl.dart';

class MapsPage extends ConsumerStatefulWidget {
  const MapsPage({super.key});

  @override
  ConsumerState<MapsPage> createState() => _MapsPageState();
}

class _MapsPageState extends ConsumerState<MapsPage>
    with TickerProviderStateMixin {
  late String? token;
  late double? lat;
  late double? long;
  // Nearby User data
  late final nearbyUser = ref.watch(userLocationProvider);
  final List<Marker> markers = [];

  // MapController controller = MapController();
  late final AnimatedMapController controller = AnimatedMapController(
    vsync: this,
    duration: const Duration(milliseconds: 500),
    curve: Curves.easeInOut,
  );

  void _getToken() {
    token = dotenv.env['PUBLIC_ACCESS_TOKEN'];
  }

  // Get user coordinates from the provider (lat, long)
  void _getUserLonglat() async {
    final longlat = ref.watch(locationProvider);

    print("longlat : $longlat");

    lat = longlat['latitude'];
    long = longlat['longitude'];

    print("lat : $lat");
    print("long : $long");
  }

  // function for fetching the nearby user location
  void _getNearbyUserLocation() async {
    final token = ref.watch(tokenProvider);

    ref.read(userLocationProvider.notifier).getUserLocation(token);

    for (var user in nearbyUser) {
      print("User : $user");
      final coordinates = user['coordinates'];

      markers.add(Marker(
          width: 35,
          height: 35,
          point: LatLng(
            double.parse(coordinates['latitude']),
            double.parse(coordinates['longitude']),
          ),
          child: GestureDetector(
            onTap: () {
              print("Marker tapped from nearby user");
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50),
                boxShadow: const [CustomColors.boxShadow],
              ),
              child: const Icon(
                Icons.account_circle_rounded,
                color: CustomColors.primary,
                size: 30.0,
              ),
            ),
          )));

      print("Markers : $markers");
    }
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
    _getUserLonglat();
    _getNearbyUserLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            const Center(
              child: Text("OKE"),
            ),
            Positioned(
                top: 0,
                left: 0,
                bottom: 0,
                right: 0,
                child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: FlutterMap(
                      mapController: controller.mapController,
                      options: MapOptions(
                        initialCenter: LatLng(lat!, long!),
                        initialZoom: 15.0,
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
                        MarkerLayer(
                          markers: [
                            // Set user marker on map using layer itself
                            Marker(
                              width: 35.0,
                              height: 35.0,
                              point: LatLng(lat!, long!),
                              child: GestureDetector(
                                onTap: () {
                                  print("Marker tapped");
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(50),
                                      boxShadow: const [
                                        CustomColors.boxShadow
                                      ]),
                                  child: const Icon(
                                    Icons.circle,
                                    color: CustomColors.primary,
                                    size: 30.0,
                                  ),
                                ),
                              ),
                            ),
                            // ==============================================
                            /*
                                  I think from the code below is needed for showed up the marker base on the data from the API
                                  But i still doesn't know how to implement it

                                  - Fetch User location from Location Table
                                  - Map the fetched data to List<Markers> variables
                                  - Show the markers on the map

                                  // Dummy Data 
                                  final data = [{userId: xx, coordinates: LatLng(lat, long)}, ... etc];
                               */
                            // ==============================================
                            ...markers,
                          ],
                        ),
                        RichAttributionWidget(
                          attributions: [
                            TextSourceAttribution(
                              'OpenStreetMap contributors',
                              onTap: () => launchUrl(Uri.parse(
                                  'https://openstreetmap.org/copyright')),
                            ),
                          ],
                        ),
                      ],
                    ))),
            Positioned(
                bottom: 70,
                right: 20,
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: CustomColors.primary,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: const [CustomColors.boxShadow],
                  ),
                  child: IconButton(
                    onPressed: () {
                      // controller.(LatLng(lat, long), 17.0);
                      controller.mapController.move(LatLng(lat!, long!), 15.0);
                    },
                    icon: const Icon(
                      Icons.my_location,
                      color: CustomColors.putih,
                    ),
                    iconSize: 30,
                  ),
                )),
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
      ),
    );
  }
}
