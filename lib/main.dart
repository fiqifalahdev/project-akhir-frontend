import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend_tambakku/pages/appointment_request_page.dart';
import 'package:frontend_tambakku/pages/fish_price.dart';
import 'package:frontend_tambakku/pages/incoming_request_page.dart';
import 'package:frontend_tambakku/pages/introduction_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:frontend_tambakku/firebase_options.dart';
import 'package:frontend_tambakku/pages/layout.dart';
import 'package:frontend_tambakku/pages/maps_page.dart';
import 'package:frontend_tambakku/pages/notifications_page.dart';
import 'package:frontend_tambakku/util/firebase_api.dart';
import 'package:intl/date_symbol_data_local.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await dotenv.load(fileName: 'lib/assets/config/.env');

  await initializeDateFormatting('id_ID', null)
      .then((_) => runApp(const ProviderScope(child: MyApp())));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseApi().initFirebase(ref);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tambakku APP 1.0.0',
      theme: ThemeData(fontFamily: 'Montserrat'),
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      initialRoute: '/',
      routes: {
        '/': (context) => const IntroductionPage(),
        '/home': (context) => Layout(
              index: 0,
            ), // Homepage
        '/maps': (context) => const MapsPage(), // MapsPage
        '/profile': (context) => Layout(
              index: 3,
            ), // ProfilePage
        '/my-appointment': (context) =>
            const AppointmentPage(), // AppointmentPage
        '/incoming-request': (context) => const IncomingRequestPage(),
        '/fish-price': (context) => Layout(
              index: 2,
            ),
        '/notification': (context) => const NotificationPage(),
      },
    );
  }
}
