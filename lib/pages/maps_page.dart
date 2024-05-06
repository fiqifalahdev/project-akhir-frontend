import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend_tambakku/logic/states_new.dart';
import 'package:frontend_tambakku/util/location.dart';
import 'package:frontend_tambakku/util/main_util.dart';
import 'package:frontend_tambakku/util/styles.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:quickalert/quickalert.dart';
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
  final List<Marker> markers = [];

  // ============ Direction =================
  bool isDirectionEnabled = false;
  late double? latDestination;
  late double? longDestination;
  late List<dynamic> dummyData = [];

  // Dummy directions data
  // final List<dynamic> dummyData = [
  //   [112.663757, -7.442767],
  //   [112.66363, -7.442724],
  //   [112.663117, -7.44252],
  //   [112.662701, -7.442321],
  //   [112.66233, -7.442125],
  //   [112.662111, -7.441983],
  //   [112.661951, -7.441857],
  //   [112.661732, -7.4417],
  //   [112.66118, -7.441425],
  //   [112.660534, -7.441183],
  //   [112.660447, -7.441166],
  //   [112.660289, -7.44116],
  //   [112.660251, -7.441158],
  //   [112.659796, -7.441169],
  //   [112.65926, -7.441228],
  //   [112.65919, -7.441242],
  //   [112.659155, -7.441269],
  //   [112.659119, -7.441301],
  //   [112.658605, -7.441845],
  //   [112.658529, -7.441914],
  //   [112.658506, -7.441937],
  //   [112.658059, -7.442383],
  //   [112.658013, -7.442405],
  //   [112.657974, -7.442415],
  //   [112.657909, -7.442413],
  //   [112.657145, -7.442304],
  //   [112.656951, -7.442263],
  //   [112.656381, -7.442144],
  //   [112.656173, -7.442061],
  //   [112.65601, -7.442022],
  //   [112.655598, -7.441874],
  //   [112.65489, -7.441652],
  //   [112.654627, -7.441553],
  //   [112.653599, -7.441229],
  //   [112.653428, -7.441175],
  //   [112.652945, -7.441042],
  //   [112.652758, -7.441727],
  //   [112.652544, -7.442541],
  //   [112.652421, -7.442997],
  //   [112.652357, -7.44317],
  //   [112.651737, -7.444783]
  // ];

  // ========================================

  bool isLoading = false;

  // ============ Map Controller ===========
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
  _getNearbyUserLocation() async {
    final token = ref.watch(tokenProvider);

    ref.read(userLocationProvider.notifier).getUserLocation(token);
  }

  _getDirection() async {
    final result = await ref
        .read(directionProvider.notifier)
        .getDirectionMapbox(latDestination!, longDestination!, lat!, long!);

    setState(() {
      dummyData =
          ref.watch(directionProvider)['routes'][0]['geometry']['coordinates'];
    });

    // print(
    // "Result : ${ref.watch(directionProvider)['routes'][0]['geometry']['coordinates']}");

    print('dummyData : $dummyData');
    print('isNotEmpty : ${dummyData.isNotEmpty}?');
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
    _getNearbyUserLocation(); //
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // Loading Widget
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

                            for (var user
                                in ref.watch(userLocationProvider)) ...[
                              Marker(
                                width: 35.0,
                                height: 35.0,
                                point: LatLng(
                                    double.parse(
                                        user['coordinates']['latitude']),
                                    double.parse(
                                        user['coordinates']['longitude'])),
                                child: GestureDetector(
                                  onTap: () {
                                    ref.read(userIdProvider.notifier).update(
                                        (state) => state = user['userId']);

                                    showFlexibleBottomSheet(
                                        context: context,
                                        builder: _buildBottomSheet);

                                    // Show the marker user profile

                                    // setState(() {
                                    //   isDirectionEnabled = !isDirectionEnabled;
                                    //   latDestination = double.parse(
                                    //       user['coordinates']['latitude']);
                                    //   longDestination = double.parse(
                                    //       user['coordinates']['longitude']);

                                    //   // _getDirection(); // Get Direction from mapbox
                                    // });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(50),
                                        boxShadow: const [
                                          CustomColors.boxShadow
                                        ]),
                                    child: const Icon(
                                      Icons.account_circle_rounded,
                                      color: CustomColors.primary,
                                      size: 30.0,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                        if (isDirectionEnabled || dummyData.isNotEmpty)
                          PolylineLayer(
                            polylines: [
                              Polyline(
                                points: [
                                  for (var data in dummyData) ...[
                                    LatLng(data[1], data[0]),
                                  ]
                                  // LatLng(data[0], data[1]),
                                  // LatLng(lat!, long!),
                                  // LatLng(latDestination!, longDestination!),
                                ],
                                color: CustomColors.primary,
                                strokeWidth: 3.0,
                              ),
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
                    ref.invalidate(directionProvider);
                    ref.invalidate(getUserDetailProvider);
                    ref.invalidate(userLocationProvider);
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

  Widget _buildBottomSheet(
    BuildContext context,
    ScrollController scrollController,
    double bottomSheetOffset,
  ) {
    return Consumer(builder: (context, ref, child) {
      final details = ref.watch(userIdProvider);

      final userDetail = ref.watch(getUserDetailProvider(details)).when(
        data: (data) {
          print("Data : $data");

          final details = data['detail'];
          final feeds = data['feeds'];

          return SafeArea(
            child: Container(
                decoration: const BoxDecoration(
                  color: CustomColors.putih,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: ListView(controller: scrollController, children: [
                  // ======================== App bar ========================
                  Container(
                    color: CustomColors.putih,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 15),
                    child: Column(
                      children: [
                        // ================= User Profile =====================
                        Container(
                          padding: const EdgeInsets.only(
                              top: 18, left: 18, right: 18, bottom: 10),
                          decoration: BoxDecoration(
                            color: CustomColors.putih,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  offset: const Offset(2, 4),
                                  spreadRadius: 2,
                                  blurRadius: 10)
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                // mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            color: CustomColors.darkBlue,
                                            width: 5)),
                                    child: ClipOval(
                                      child: SizedBox.fromSize(
                                          size: const Size.fromRadius(48),
                                          child:
                                              //data.profileImage == null
                                              Image.asset(
                                            "lib/assets/profile-avatar.jpg",
                                            fit: BoxFit.cover,
                                          )
                                          // : Image.network(
                                          //     // set the domain image
                                          //     MainUtil().publicDomain +
                                          //         data.profileImage!,
                                          //     fit: BoxFit.cover,
                                          //   )),
                                          ),
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${details['name']}" ?? "Nama User",
                                        style: const TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold,
                                            color: CustomColors.darkBlue),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "${details['role'] ?? "Peran User"} - ${details['gender'] ?? "Laki-laki"}",
                                        style: const TextStyle(
                                            fontSize: 14.0,
                                            color: CustomColors.darkBlue),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              if (details['about'] != null) ...[
                                const SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  "${details['about']}",
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      color: CustomColors.blackOpacity),
                                ),
                              ],
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                      "Alamat : ${details['address']}" ??
                                          "Alamat User",
                                      style: TextStyle(
                                          fontSize: 14.0,
                                          color: CustomColors.blackOpacity,
                                          fontWeight: FontWeight.w600)),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 15),
                        // ================= Row Of Button ====================
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 60,
                          color: Colors.transparent,
                          child: Row(
                            children: [
                              ElevatedButton.icon(
                                  onPressed: () {
                                    // Ini nanti langsung directions
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: CustomColors.primary,
                                    minimumSize: const Size(100, 40),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  icon: const Icon(Icons.alt_route_outlined,
                                      color: CustomColors.putih),
                                  label: const Text("Rute",
                                      style: TextStyle(
                                          color: CustomColors.putih,
                                          fontWeight: FontWeight.bold))),
                              const SizedBox(width: 10),
                              ElevatedButton.icon(
                                  onPressed: () {
                                    // Ini nanti langsung chat
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: CustomColors.acceptButton,
                                    minimumSize: const Size(100, 40),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  icon: const Icon(Icons.event,
                                      color: CustomColors.putih),
                                  label: const Text("Minta Bertemu",
                                      style: TextStyle(
                                          color: CustomColors.putih,
                                          fontWeight: FontWeight.bold))),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 400,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10),
                      child: GridView.builder(
                        itemCount: feeds.length,
                        itemBuilder: (context, index) {
                          // Render Feed Image
                          return InkWell(
                            onTap: () {
                              print("Masuk Ke detail Produk");
                            },
                            child: Image.network(
                              MainUtil().publicDomain + feeds[index]['image']!,
                              fit: BoxFit.cover,
                            ),
                          );
                        },
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 1,
                        ),
                      ),
                    ),
                  ),
                ])),
          );
        },
        error: (error, stackTrace) {
          print("Stacktrace : $stackTrace");

          return Center(
            child: Text("Error: $error"),
          );
        },
        loading: () {
          return loadingWidget();
        },
      );

      return userDetail;
    });
  }

  Widget loadingWidget() {
    return Container(
      // width: MediaQuery.of(context).size.width,
      // height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.3),
        boxShadow: const [CustomColors.boxShadow],
      ),
      child: Center(
        child: LoadingAnimationWidget.discreteCircle(
            color: CustomColors.primary, size: 40.0),
      ),
    );
  }
}
