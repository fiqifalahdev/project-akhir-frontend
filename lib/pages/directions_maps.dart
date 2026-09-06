import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend_tambakku/logic/states_new.dart';
import 'package:frontend_tambakku/util/styles.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_mapbox_navigation/flutter_mapbox_navigation.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class DirectionsMapsPage extends ConsumerStatefulWidget {
  final int userId;
  final double? lat;
  final double? long;
  final double? latDestination;
  final double? longDestination;
  final String address;

  final List<dynamic> coordinatesGeometry;

  const DirectionsMapsPage({
    super.key,
    required this.userId,
    required this.lat,
    required this.long,
    required this.latDestination,
    required this.longDestination,
    required this.address,
    required this.coordinatesGeometry,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DirectionsMapsPageState();
}

class _DirectionsMapsPageState extends ConsumerState<DirectionsMapsPage>
    with TickerProviderStateMixin {
  // ============ Flutter MapBox Navigation ===========
  String? _instruction;
  late MapBoxOptions _navigationOption;
  bool _isMultipleStop = false;
  double? _distanceRemaining, _durationRemaining;
  MapBoxNavigationViewController? _controller;
  bool _routeBuilt = false;
  bool _isNavigating = false;
  bool _inFreeDrive = false;

  late final WayPoint _home;
  late final WayPoint _target;

  // Nanti Ubah WayPoint ini sesuai dengan data yang diambil dari database
  // fixing bug Reproduce :
  // 1. Tombol Rute di AppointmentsPage Error ketika pertama kali klik
  // 2. Pada saat masuk ke DirectionsMapsPage, Polylines tidak muncul, baru ketika di back dan masuk lagi polylines muncul
  // 3. Mengganti WayPoint yang ada di _home dan _store

  late String? token;
// ============ Map Controller ===========
  late final AnimatedMapController controller = AnimatedMapController(
    vsync: this,
    duration: const Duration(milliseconds: 500),
    curve: Curves.easeInOut,
  );

  void _getToken() {
    token = dotenv.env['PUBLIC_ACCESS_TOKEN'];
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initialize() async {
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    _navigationOption = MapBoxNavigation.instance.getDefaultOptions();
    _navigationOption.simulateRoute = true;
    _navigationOption.language = "en";
    //_navigationOption.initialLatitude = 36.1175275;
    //_navigationOption.initialLongitude = -115.1839524;
    MapBoxNavigation.instance.registerRouteEventListener(_onEmbeddedRouteEvent);

    String? platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await MapBoxNavigation.instance.getPlatformVersion();
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getToken();

    // auth user coordinates
    _home = WayPoint(
        name: "Home",
        latitude: widget.lat,
        longitude: widget.long,
        isSilent: false);

    // target user coordinates
    _target = WayPoint(
        name: "Store",
        latitude: widget.latDestination,
        longitude: widget.longDestination,
        isSilent: false);

    print("_home: $_home");
    print("_target: $_target");
    initialize();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context, 0);
              ref.invalidate(directionProvider);
              ref.invalidate(getUserDetailProvider);
              ref.invalidate(userLocationProvider);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: CustomColors.putih,
            ),
            iconSize: 20,
          ),
          title: const Text(
            "Peta",
            style: TextStyle(
                color: CustomColors.putih, fontWeight: FontWeight.w600),
          ),
          automaticallyImplyLeading: false,
          backgroundColor: CustomColors.darkBlue,
          elevation: 0,
        ),
        body: Stack(children: [
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
                  initialCenter: LatLng(
                      (widget.lat! + widget.latDestination!) / 2,
                      (widget.long! + widget.longDestination!) / 2),
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
                  MarkerLayer(markers: [
                    Marker(
                      width: 35.0,
                      height: 35.0,
                      point: LatLng(widget.lat!, widget.long!),
                      child: GestureDetector(
                        onTap: () {
                          print("Marker tapped");
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(50),
                              boxShadow: const [CustomColors.boxShadow]),
                          child: const Icon(
                            Icons.circle,
                            color: CustomColors.primary,
                            size: 30.0,
                          ),
                        ),
                      ),
                    ),
                    Marker(
                      width: 35.0,
                      height: 35.0,
                      point: LatLng(
                          widget.latDestination!, widget.longDestination!),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50),
                            boxShadow: const [CustomColors.boxShadow]),
                        child: const Icon(
                          Icons.account_circle_rounded,
                          color: CustomColors.primary,
                          size: 30.0,
                        ),
                      ),
                    ),
                  ]),
                  if (widget.coordinatesGeometry.isNotEmpty)
                    PolylineLayer(
                      polylines: [
                        Polyline(
                          points: [
                            for (var data in widget.coordinatesGeometry) ...[
                              LatLng(data[1], data[0]),
                            ]
                          ],
                          color: CustomColors.primary,
                          strokeWidth: 3.0,
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
          Positioned(
              child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                            color: CustomColors.darkBlue,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [CustomColors.boxShadow]),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: CustomColors.putih,
                                  borderRadius: BorderRadius.circular(25)),
                              child: const Icon(
                                Icons.circle,
                                color: CustomColors.primary,
                                size: 20,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Text(
                              "Lokasi Anda",
                              style: TextStyle(
                                  color: CustomColors.putih,
                                  fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                            color: CustomColors.darkBlue,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [CustomColors.boxShadow]),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: CustomColors.putih,
                                      borderRadius: BorderRadius.circular(25)),
                                  child: const Icon(
                                    Icons.account_circle_rounded,
                                    color: CustomColors.primary,
                                    size: 20,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Text(
                                  "Lokasi Tujuan",
                                  style: TextStyle(
                                      color: CustomColors.putih,
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                child: Text(
                                  widget.address,
                                  style: const TextStyle(
                                      color: CustomColors.putih,
                                      fontWeight: FontWeight.w600),
                                ))
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            var wayPoints = <WayPoint>[];
                            wayPoints.add(_home);
                            wayPoints.add(_target);
                            var opt = MapBoxOptions.from(_navigationOption);
                            opt.simulateRoute = true;
                            opt.voiceInstructionsEnabled = true;
                            opt.bannerInstructionsEnabled = true;
                            opt.units = VoiceUnits.metric;
                            opt.language = "id_ID";
                            await MapBoxNavigation.instance.startNavigation(
                                wayPoints: wayPoints, options: opt);
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: CustomColors.primary,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8))),
                          child: const Text(
                            "Mulai Navigasi",
                            style: TextStyle(color: CustomColors.putih),
                          ))
                    ],
                  )))
        ]),
      ),
    );
  }

  Future<void> _onEmbeddedRouteEvent(e) async {
    _distanceRemaining = await MapBoxNavigation.instance.getDistanceRemaining();
    _durationRemaining = await MapBoxNavigation.instance.getDurationRemaining();

    switch (e.eventType) {
      case MapBoxEvent.progress_change:
        var progressEvent = e.data as RouteProgressEvent;
        if (progressEvent.currentStepInstruction != null) {
          _instruction = progressEvent.currentStepInstruction;
        }
        break;
      case MapBoxEvent.route_building:
      case MapBoxEvent.route_built:
        setState(() {
          _routeBuilt = true;
        });
        break;
      case MapBoxEvent.route_build_failed:
        setState(() {
          _routeBuilt = false;
        });
        break;
      case MapBoxEvent.navigation_running:
        setState(() {
          _isNavigating = true;
        });
        break;
      case MapBoxEvent.on_arrival:
        if (!_isMultipleStop) {
          await Future.delayed(const Duration(seconds: 3));
          await _controller?.finishNavigation();
        } else {}
        break;
      case MapBoxEvent.navigation_finished:
      case MapBoxEvent.navigation_cancelled:
        setState(() {
          _routeBuilt = false;
          _isNavigating = false;
        });
        break;
      default:
        break;
    }
    setState(() {});
  }
}
