import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:frontend_tambakku/models/appointmentrequest.dart';
import 'package:frontend_tambakku/models/base_info.dart';
import 'package:frontend_tambakku/models/feeds.dart';
import 'package:frontend_tambakku/models/user.dart';
import 'package:frontend_tambakku/util/main_util.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

// =================================================================================
// ==================================== Headers ====================================
// =================================================================================

Map<String, String> headers = {
  'Content-Type': 'application/json',
  'Accept': 'application/json',
};

// =================================================================================
// ============================= Authentication Provider ===========================
// =================================================================================

// Make a registration provider
final registrationProvider = StateNotifierProvider<RegistrationState, User>(
  // Call the notifier here
  (ref) => RegistrationState(ref),
);

// Define a state notifier to manage the registration process
class RegistrationState extends StateNotifier<User> {
  final Ref ref;
  // Default state in constructor
  RegistrationState(this.ref)
      : super(const User(
            name: '',
            email: '',
            password: '',
            password_confirmation: '',
            phone: '',
            birthdate: '',
            gender: '',
            role: ''));

  // Define a method to register a user
  Future<String> register(User user) async {
    try {
      print("User : ${user.toJson()}");
      // Perform the registration process here (e.g., make an HTTP request)
      // You can use packages like http or dio to make HTTP requests
      final response = await http.post(
        Uri.parse(MainUtil().registerUrl),
        headers: headers,
        body: jsonEncode(user.toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Registration successful
        print(jsonDecode(response.body)['data']);
        state = User.fromJson(jsonDecode(response.body)['data']);
        print(state);
        final String token = jsonDecode(response.body)['token'];

        // save token to shared preferences
        ref.read(tokenProvider.notifier).setToken(token);

        return "Pendaftaran Berhasil!";
      } else {
        // Registration failed
        print(response.body);
        throw "${jsonDecode(response.body)['message']}";
      }
    } catch (error, stackTrace) {
      // Handle any errors that occur during registration
      print("Stack Trace : ${stackTrace.toString()}");
      throw error.toString();
    }
  }

  // Define a method to login a user
  Future<void> login(String email, String password) async {
    try {
      print('email: $email, password: $password');
      final body = jsonEncode({
        'email': email,
        'password': password,
      });

      final response = await http.post(Uri.parse(MainUtil().loginUrl),
          body: body, headers: headers);

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Registration successful

        state = User.fromJson(jsonDecode(response.body)['data']);
        final String token = jsonDecode(response.body)['token'];

        // save token to shared preferences
        // final prefs = await SharedPreferences.getInstance();

        // prefs.setString('token', token);
        ref.read(tokenProvider.notifier).setToken(token);
      } else {
        // Registration failed
        throw Exception("Failed to login user: ${response.body}");
      }
    } catch (error) {
      // Handle any errors that occur during registration
      throw Exception('Failed to login user: $error');
    }
  }

  // Define a method to logout a user
  Future<String> logout() async {
    try {
      // final prefs = await SharedPreferences.getInstance();
      // final token = prefs.get('token');
      final token = ref.watch(tokenProvider);

      final response = await http.post(Uri.parse(MainUtil().logoutUrl),
          headers: {'Authorization': 'Bearer $token'});

      final json = jsonDecode(response.body);

      print(json);

      if (response.statusCode != 200 && response.statusCode != 201) {
        // if the response is not successful, throw an exception
        throw Exception("Failed to logout user: ${json['message']}");
      }

      if (response.statusCode == 401) {
        throw Exception("Internal Server Error : User unauthenticated");
      }
      // prefs.remove('token');

      ref.read(tokenProvider.notifier).removeToken();
      state = state.copyWith(
          name: '',
          email: '',
          password: '',
          password_confirmation: '',
          phone: '',
          birthdate: '',
          gender: '');

      print(state);

      return json['message'];
    } catch (error) {
      throw Exception('Failed to logout user: $error');
    }
  }
}

// =================================================================================
// =================================== Token Provider ==============================
// =================================================================================

final tokenProvider = StateNotifierProvider<TokenProviderState, String>(
    (ref) => TokenProviderState(ref));

class TokenProviderState extends StateNotifier<String> {
  final Ref ref;

  TokenProviderState(this.ref) : super('');

  Future<void> setToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);

    ref.read(getBaseInfoProvider.notifier).getBaseInfo(token);
    ref.read(storeFCMTokenProvider.notifier).storeFCMToken(token);

    state = token;
  }

  Future<void> removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');

    state = '';
  }
}

// Make a token provider;
// final tokenProvider = FutureProvider<String>((ref) async {
//   final prefs = await SharedPreferences.getInstance();
//   String token = prefs.getString('token') ?? '';

//   print("Token : $token");

//   ref.read(getBaseInfoProvider.notifier).getBaseInfo(token);

//   return token;
// });

// =================================================================================
// =================================== Base Info ===================================
// =================================================================================
// Define a state notifier to manage the base info process

final userIdProvider =
    StateProvider<int>((ref) => 0); // nanti set id user disini

final getUserDetailProvider =
    FutureProvider.family<Map<String, dynamic>, int>((ref, id) async {
  print("id : $id");
  try {
    final token = ref.watch(tokenProvider);

    final tokenEntries = {'Authorization': 'Bearer $token'};

    headers.addEntries(tokenEntries.entries);

    final response = await http.get(
        Uri.parse('${MainUtil().userProfileDetails}/$id'),
        headers: headers);

    if (response.statusCode == 401) {
      throw 'Internal Server Error : User unauthenticated';
    }

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw 'Gagal mendapatkan data user: ${response.body}';
    }

    final json = jsonDecode(response.body)['data'];

    print("Json : $json");
    return json;
  } catch (e) {
    throw e.toString();
  }
});

final getBaseInfoProvider = StateNotifierProvider<BaseInfoState, BaseInfo>(
  (ref) => BaseInfoState(ref),
);

final latestAppointment = StateProvider<Map<String, dynamic>>((ref) => {});

final appointmentSumProvider = StateProvider<int>((ref) => 0);

class BaseInfoState extends StateNotifier<BaseInfo> {
  final Ref ref;

  BaseInfoState(this.ref)
      : super(const BaseInfo(
            name: '',
            phone: '',
            birthdate: '',
            gender: '',
            role: '',
            about: '',
            profileImage: ''));

  Future<void> getBaseInfo(String token) async {
    try {
      final tokenEntries = <String, String>{'Authorization': 'Bearer $token'};

      headers.addEntries(tokenEntries.entries);

      final response =
          await http.get(Uri.parse(MainUtil().baseInfo), headers: headers);

      if (response.statusCode == 401) {
        throw Exception("Internal Server Error : User unauthenticated");
      }

      final json = jsonDecode(response.body)['data']['detail'];
      final feeds = jsonDecode(response.body)['data']['feeds'];
      ref.read(appointmentSumProvider.notifier).state =
          jsonDecode(response.body)['data']['appointmentSum'];

      print("feeds dari baseInfoProvider : $feeds");
      print("json baseInfo : $json");

      ref
          .read(feedProvider.notifier)
          .getFeeds(feeds); // gabisa ngeread provider

      ref.read(latestAppointment.notifier).state =
          jsonDecode(response.body)['data']['latestAppointment'] ?? {};

      state = state.copyWith(
        name: json['name'],
        phone: json['phone'],
        gender: json['gender'],
        birthdate: json['birthdate'],
        role: json['role'],
        about: json['about'],
        profileImage: json['profile_image'],
        address: json['address'],
      );

      print(state);
    } catch (error, stackTrace) {
      print("Stack Trace : ${stackTrace.toString()}");
      throw Exception('Failed to get base info: $error');
    }
  }

  // Update profile method
  Future<String> updateProfile(Map<String, dynamic> data, String token) async {
    try {
      // make a multipart request
      final request =
          http.MultipartRequest('POST', Uri.parse(MainUtil().updateProfile));
      request.headers.addAll({
        'Content-Type': 'multipart/form-data',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      });

      // Add file to the request
      if (data['profile_image'] is File) {
        final File file = data['profile_image'];
        request.files.add(
          await http.MultipartFile.fromPath(
            'profile_image', // Field name for the file
            file.path, // Path to the file
            filename: file.path.split('/').last, // Set the file name
          ),
        );
      }

      // Add other fields to the request
      data.remove('profile_image');
      request.fields.addAll(data.map((key, value) => MapEntry(key, value)));

      print("request.fields: ${request.fields}");
      print("request.files: ${request.files}");

      final response = await request.send();

      // print(response.statusCode);
      // print(await response.stream.bytesToString());

      if (response.statusCode == 200 || response.statusCode == 201) {
        final json = jsonDecode(await response.stream.bytesToString());

        state = state.copyWith(
          name: data['name'],
          phone: data['phone'],
          about: data['about'],
          gender: data['gender'],
          birthdate: data['birthdate'],
          address: data['address'],
          profileImage: data['profile_image'],
        );

        print(state);

        return json['message'];
      } else {
        throw "${jsonDecode(await response.stream.bytesToString())['message']}";
      }
    } catch (e) {
      throw e.toString();
    }
  }
}

// =================================================================================
// =============================== File/Image Provider =============================
// =================================================================================

final fileProvider = StateNotifierProvider<FileProvider, File>((ref) {
  return FileProvider();
});

// Make a file/image provider
class FileProvider extends StateNotifier<File> {
  FileProvider() : super(File(''));

  Future<void> pickImage() async {
    try {
      // Pick an image from the gallery=
      // For example:
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) {
        throw Exception('No image selected');
      }

      state = File(image.path);
    } catch (e) {
      throw Exception('Failed to pick image: $e');
    }
  }
}

// =================================================================================
// =========================== User Address Provider ===============================
// =================================================================================

final addressProvider = StateNotifierProvider<AddressProvider, String>((ref) {
  return AddressProvider(ref);
});

class AddressProvider extends StateNotifier<String> {
  final Ref ref;

  AddressProvider(this.ref) : super('');

  // Get http method to post a location address to server
  void setAddress(Map<String, dynamic> params) async {
    Map<String, dynamic> body = {
      'address': params['address'],
      'latitude': params['latitude'],
      'longitude': params['longitude'],
    };

    ref.read(locationProvider.notifier).setLongLat(
        double.parse(params['latitude']), double.parse(params['longitude']));

    // final prefs = await SharedPreferences.getInstance();
    // final token = prefs.get('token');

    final token = ref.watch(tokenProvider);
    print("Tokwen : $token");

    Map<String, String> tokenMap = {"Authorization": "Bearer $token"};

    headers.addEntries(tokenMap.entries);

    // print("=====================================");
    // print("Headers: $headers");
    // print("Body: $body");
    // print("Token: $token");
    // print("=====================================");

    // Make a post request to the server
    final response = await http.post(Uri.parse(MainUtil().postLocation),
        headers: headers, body: jsonEncode(body));

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception("Gagal untuk mengambil lokasi: ${response.body}");
    }

    if (response.statusCode == 401) {
      throw Exception("Internal Server Error : User unauthenticated");
    }

    final json = jsonDecode(response.body);

    // Update the state with the address
    state = params['address'];
  }
}

// =================================================================================
// =============================== Location Provider ==============================
// =================================================================================

final targetLocationProvider = StateProvider<Map<String, dynamic>>((ref) {
  return {
    'latitude': 0, // default value for latitude
    'longitude': 0, // default value for longitude
    'address': ''
  };
});

final locationProvider =
    StateNotifierProvider<LocationProvider, Map<String, double>>((ref) {
  return LocationProvider(ref);
});

class LocationProvider extends StateNotifier<Map<String, double>> {
  final Ref ref;

  LocationProvider(this.ref)
      : super({
          'latitude': -7.4627977511063825, // default value for latitude
          'longitude': 112.72527060114531, // default value for longitude
        });

  // Get Longitude latitude from user location
  void setLongLat(double latitude, double longitude) async {
    state = {
      'latitude': latitude,
      'longitude': longitude,
    };

    print("Latitude: $latitude, Longitude: $longitude");
    print("State : $state");
  }

  Future<void> getTargetLocation(int userId) async {
    try {
      final token = ref.watch(tokenProvider);

      final tokenEntries = <String, String>{'Authorization': 'Bearer $token'};

      headers.addEntries(tokenEntries.entries);

      final body = {
        'user_id': userId,
      };

      final response = await http.post(Uri.parse(MainUtil().getTargetLocation),
          headers: headers, body: jsonEncode(body));

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception(
            "Gagal untuk mendapatkan lokasi target: ${response.body}");
      }

      if (response.statusCode == 401) {
        throw Exception("Internal Server Error : User unauthenticated");
      }

      final json = jsonDecode(response.body)['data'];

      print("Get target location : $json");

      ref.read(targetLocationProvider.notifier).state = {
        'latitude': double.parse(json['latitude']),
        'longitude': double.parse(json['longitude']),
        'address': json['address']
      };
    } catch (e) {
      throw Exception('Failed to get user location: $e');
    }
  }
}

// Get Nearby User Location //
final userLocationProvider =
    StateNotifierProvider<UserLocation, List<dynamic>>((ref) {
  return UserLocation(ref);
});

class UserLocation extends StateNotifier<List<dynamic>> {
  final Ref ref;

  UserLocation(this.ref) : super([]);

  void getUserLocation(String token) async {
    try {
      final tokenEntries = <String, String>{'Authorization': 'Bearer $token'};
      headers.addEntries(tokenEntries.entries);

      final response =
          await http.get(Uri.parse(MainUtil().getLocation), headers: headers);

      final json = jsonDecode(response.body);

      print(json);

      state = json['data'];

      print("State : $state");
    } catch (e) {
      throw Exception('Failed to get user location: $e');
    }
  }
}

// MapBox Directions API
// Url Request : https://api.mapbox.com/directions/v5/{profile}/{coordinates}

final directionProvider =
    StateNotifierProvider<DirectionState, Map<String, dynamic>>(
        (ref) => DirectionState(ref));

class DirectionState extends StateNotifier<Map<String, dynamic>> {
  final Ref ref;

  DirectionState(this.ref) : super({});

  Future<String> getDirectionMapbox(double latDestination,
      double longDestination, double latCurrent, double longCurrent) async {
    try {
      final token = dotenv.env['PUBLIC_ACCESS_TOKEN'];

      final url =
          'https://api.mapbox.com/directions/v5/mapbox/driving/$longCurrent,$latCurrent;$longDestination,$latDestination?alternatives=true&geometries=geojson&language=id&overview=full&steps=true&access_token=$token';

      final response = await http.get(Uri.parse(url));

      // print('Response : ${response.body}, ${response.statusCode}');

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception("Gagal untuk mendapatkan arah: ${response.body}");
      }

      final json = jsonDecode(response.body);

      state = json;

      // print(
      // 'Directions State : ${state['routes'][0]['geometry']}'); // nanti panggiil variable ini

      return 'Berhasil mendapatkan arah';
    } catch (e) {
      return e.toString();
    }
  }
}

// =================================================================================
// ================================= Feeds Provider ================================
// =================================================================================

final feedProvider = StateNotifierProvider<Feeds, List<Feed>>((ref) {
  return Feeds(ref);
});

class Feeds extends StateNotifier<List<Feed>> {
  final Ref ref;

  Feeds(this.ref) : super([]);

  // Store Products Feed to server
  Future<String> postFeed(String caption, File image) async {
    print("Caption : $caption");
    print("Image : $image");
    try {
      // final prefs = await SharedPreferences.getInstance();
      // final token = prefs.get('token');

      final token = ref.watch(tokenProvider);

      Map<String, String> headers = {
        'Content-Type': 'multipart/form-data',
        'Accept': 'application/json',
        "Authorization": "Bearer $token"
      };

      Map<String, dynamic> body = {
        'caption': caption,
        'image': image.path,
      };

      print("body : $body");

      // Make a post request to the server
      final request =
          http.MultipartRequest('POST', Uri.parse(MainUtil().postFeeds));

      request.headers.addAll(headers);

      request.files.add(
        await http.MultipartFile.fromPath(
          'image', // Field name for the file
          image.path, // Path to the file
          filename: image.path.split('/').last, // Set the file name
        ),
      );

      request.fields.addAll(body.map((key, value) => MapEntry(key, value)));

      final response = await request.send();

      if (response.statusCode != 200 && response.statusCode != 201) {
        final responseMsg = jsonDecode(await response.stream.bytesToString());
        print(responseMsg);
        throw "Gagal Menambahkan Produk : ${responseMsg["message"]}";
      }

      if (response.statusCode == 401) {
        throw "Internal Server Error : User unauthenticated";
      }

      final json = jsonDecode(await response.stream.bytesToString());

      print("state : $state");

      return 'Berhasil Menambahkan Produk';
    } catch (e) {
      throw e.toString();
    }
  }

  // Get all Feeds from baseInfo Provider
  void getFeeds(dynamic data) {
    final feeds = (data as List).map((e) {
      return Feed.fromJson(e as Map<String, dynamic>);
    }).toList();

    state = feeds; // Perbaiki baris ini
  }
}

// =================================================================================
// =============================== Appointment Provider ============================
// =================================================================================

// Set selected Date Provider
final selectedDateProvider = StateProvider<DateTime>((ref) => DateTime.now());

final selectedTimeProvider = StateProvider<String>((ref) => '');

final appointments = StateProvider<List<dynamic>>((ref) {
  return [];
});

final incomingRequestProvider =
    StateNotifierProvider<IncomingRequest, List<dynamic>>((ref) {
  return IncomingRequest(ref);
});

class IncomingRequest extends StateNotifier<List<dynamic>> {
  final Ref ref;

  IncomingRequest(this.ref) : super([]);

  Future<String> getIncomingRequest() async {
    try {
      final token = ref.watch(tokenProvider);

      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        "Authorization": "Bearer $token"
      };

      final response = await http.get(Uri.parse(MainUtil().getIncomingRequest),
          headers: headers);

      if (response.statusCode != 200 && response.statusCode != 201) {
        final responseMsg = jsonDecode(response.body);

        throw "Gagal Mengirimkan Permintaan Janji Temu : ${responseMsg["message"]}";
      }

      if (response.statusCode == 401) {
        throw "Internal Server Error : User unauthenticated";
      }

      final json = jsonDecode(response.body)['data']['appointments'];

      print(json);

      state = json;

      return 'Berhasil Mengambil Data Permintaan Masuk';
    } catch (e) {
      throw e.toString();
    }
  }

  Future<String> updateAppointment(Map<String, dynamic> params) async {
    try {
      final token = ref.watch(tokenProvider);

      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        "Authorization": "Bearer $token"
      };

      final body = {};

      if (params['status'] == 1) {
        body.addAll({
          'status': 1,
        });
      } else {
        body.addAll({
          'status': 0,
        });
      }

      final response = await http.post(
          Uri.parse(
              '${MainUtil().updateAppointment}/${params["appointment_id"]}'),
          headers: headers,
          body: jsonEncode(body));

      if (response.statusCode != 200 && response.statusCode != 201) {
        final responseMsg = jsonDecode(response.body);

        throw "Gagal Mengupdate Janji Temu : ${responseMsg["message"]}";
      }

      if (response.statusCode == 401) {
        throw "Internal Server Error : User unauthenticated";
      }

      final json = jsonDecode(response.body);

      state = state
          .where((element) =>
              element['appointment_id'] != params['appointment_id'])
          .toList();

      ref.read(appointmentSumProvider.notifier).state -= 1;

      return 'Berhasil ${params['status'] == 1 ? 'Menerima' : 'Menolak'} Janji Temu';
    } catch (e) {
      throw e.toString();
    }
  }
}

final sendAppointmentProvider =
    StateNotifierProvider<AppointmentProvider, AppointmentRequest>(
        (ref) => AppointmentProvider(ref));

class AppointmentProvider extends StateNotifier<AppointmentRequest> {
  final Ref ref;

  AppointmentProvider(this.ref)
      : super(AppointmentRequest(
            appointment_date: DateTime.now(),
            appointment_time: '',
            requester_id: 0,
            recipient_id: 0,
            status: ''));

  Future<String> getAppointment() async {
    try {
      final token = ref.watch(tokenProvider);

      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        "Authorization": "Bearer $token"
      };

      final response = await http.get(
          Uri.parse(MainUtil().getAppointmentByAuthUser),
          headers: headers);

      if (response.statusCode != 200 && response.statusCode != 201) {
        final responseMsg = jsonDecode(response.body);

        throw "Gagal Mengambil Data Janji Temu : ${responseMsg["message"]}";
      }

      if (response.statusCode == 401) {
        throw "Internal Server Error : User unauthenticated";
      }

      final json = jsonDecode(response.body)['data'];

      print(json);

      ref.read(appointments.notifier).state = json;

      return 'Berhasil Mengambil Data Janji Temu';
    } catch (e) {
      throw e.toString();
    }
  }

  Future<String> sendAppointment() async {
    try {
      final token = ref.watch(tokenProvider);

      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        "Authorization": "Bearer $token"
      };

      final formattedDate =
          DateFormat('yyyy-MM-dd').format(ref.watch(selectedDateProvider));

      Map<String, dynamic> body = {
        'appointment_date': formattedDate.toString(),
        'appointment_time': ref.watch(selectedTimeProvider),
        'recipient_id': ref.watch(userIdProvider),
        'status': "pending",
      };

      print(body);

      final response = await http.post(Uri.parse(MainUtil().postAppointment),
          headers: headers, body: jsonEncode(body));

      if (response.statusCode != 200 && response.statusCode != 201) {
        final responseMsg = jsonDecode(response.body);

        throw "Gagal Mengirimkan Permintaan Janji Temu : ${responseMsg["message"]}";
      }

      if (response.statusCode == 401) {
        throw "Internal Server Error : User unauthenticated";
      }

      final json = jsonDecode(response.body);

      state = AppointmentRequest.fromJson(json['data']);

      return 'Berhasil Mengirimkan Permintaan Janji Temu';
    } catch (e) {
      throw e.toString();
    }
  }
}

// =============================================================================
// ========================== Notification Provider ============================
// =============================================================================

final fcmTokenProvider = StateProvider<String>((ref) => '');

final storeFCMTokenProvider =
    StateNotifierProvider<StoreFCMToken, String>((ref) => StoreFCMToken(ref));

class StoreFCMToken extends StateNotifier<String> {
  final Ref ref;

  StoreFCMToken(this.ref) : super('');

  Future<String> storeFCMToken(String authToken) async {
    try {
      final fcmToken = ref.watch(fcmTokenProvider);

      final tokenEntries = <String, String>{
        'Authorization': 'Bearer $authToken'
      };

      headers.addEntries(tokenEntries.entries);

      final body = {
        'device_token': fcmToken,
      };

      final response = await http.post(Uri.parse(MainUtil().storeDevicesToken),
          headers: headers, body: jsonEncode(body));

      if (response.statusCode != 200 && response.statusCode != 201) {
        final responseMsg = jsonDecode(response.body);

        throw "Gagal Menyimpan FCM Token : ${responseMsg["message"]}";
      }

      if (response.statusCode == 401) {
        throw "Internal Server Error : User unauthenticated";
      }

      final json = jsonDecode(response.body);

      state = json['message'];

      print('Store FCM Token : $state');

      return 'Berhasil Menyimpan FCM Token';
    } catch (e) {
      throw e.toString();
    }
  }
}
