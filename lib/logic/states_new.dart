import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend_tambakku/models/base_info.dart';
import 'package:frontend_tambakku/models/user.dart';
import 'package:frontend_tambakku/util/main_util.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
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
  (ref) => RegistrationState(),
);

// Define a state notifier to manage the registration process
class RegistrationState extends StateNotifier<User> {
  // Default state in constructor
  RegistrationState()
      : super(User(
            name: '',
            email: '',
            password: '',
            passwordConfirmation: '',
            phone: '',
            birthdate: '',
            gender: ''));

  // Define a method to register a user
  Future<void> register(User user) async {
    try {
      // Perform the registration process here (e.g., make an HTTP request)
      // You can use packages like http or dio to make HTTP requests
      final response = await http.post(
        Uri.parse(MainUtil().registerUrl),
        headers: headers,
        body: jsonEncode(user.toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Registration successful

        state = User.fromJson(jsonDecode(response.body)['data']);
        final String token = jsonDecode(response.body)['token'];

        // save token to shared preferences
        final prefs = await SharedPreferences.getInstance();

        prefs.setString('token', token);
      } else {
        // Registration failed
        throw Exception("Failed to register user: ${response.body}");
      }
    } catch (error) {
      // Handle any errors that occur during registration
      throw Exception('Failed to register user: $error');
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
        final prefs = await SharedPreferences.getInstance();

        prefs.setString('token', token);
      } else {
        // Registration failed
        throw Exception("Failed to login user: ${response.body}");
      }
    } catch (error) {
      // Handle any errors that occur during registration
      throw Exception('Failed to login user: $error');
    }
  }
}

// =================================================================================
// =================================== Token Provider ==============================
// =================================================================================

// Make a token provider;
final tokenProvider = FutureProvider<String>((ref) async {
  final prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token') ?? '';

  print("Token : $token");

  ref.read(getBaseInfoProvider.notifier).getBaseInfo(token);

  return token;
});

// =================================================================================
// =================================== Base Info ===================================
// =================================================================================
// Define a state notifier to manage the base info process

final getBaseInfoProvider = StateNotifierProvider<BaseInfoState, BaseInfo>(
  (ref) => BaseInfoState(),
);

class BaseInfoState extends StateNotifier<BaseInfo> {
  BaseInfoState()
      : super(const BaseInfo(
            name: '',
            email: '',
            phone: '',
            birthdate: '',
            gender: '',
            role: '',
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

      print(json);

      state = state.copyWith(
          name: json['name'],
          email: json['email'],
          phone: json['phone'],
          gender: json['gender'],
          birthdate: json['birthdate'],
          role: json['role'],
          profileImage: json['profile_image'],
          address: json['address']);

      print(state);
    } catch (error) {
      throw Exception('Failed to get base info: $error');
    }
  }

  // Update profile method
  Future<void> updateProfile(Map<String, dynamic> data, String token) async {
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

      // print("request.fields: ${request.fields}");
      // print("request.files: ${request.files}");

      final response = await request.send();

      // print(response.statusCode);
      // print(await response.stream.bytesToString());

      if (response.statusCode == 200 || response.statusCode == 201) {
        final json = jsonDecode(await response.stream.bytesToString());

        state = state.copyWith(
          name: data['name'],
          phone: data['phone'],
          email: data['email'],
          role: data['role'],
          gender: data['gender'],
          birthdate: data['birthdate'],
          address: data['address'],
          profileImage: data['profile_image'],
        );

        print(state);
      } else {
        throw Exception(
            "Failed to update profile: ${await response.stream.bytesToString()}");
      }
    } catch (e) {
      throw Exception('Failed to update profile: $e');
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
  return AddressProvider();
});

class AddressProvider extends StateNotifier<String> {
  AddressProvider() : super('');

  void setAddress(String address) {
    state = address;
  }
}
