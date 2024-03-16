import 'dart:convert';

import 'package:frontend_tambakku/models/user.dart';
import 'package:frontend_tambakku/util/main_util.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

part 'states.g.dart';

Map<String, String> headers = {
  'Content-Type': 'application/json',
  'Accept': 'application/json',
};

// authentication provider
@riverpod
class AuthNotifier extends _$AuthNotifier {
  @override
  Future<User> build() async {
    final response =
        await http.get(Uri.parse('http://10.0.2.2:8000/api/base_info'));

    final json = jsonDecode(response.body);

    return User.fromJson(json);
  }

  // Retrieve Token from device storage
  Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    return token.toString();
  }

  Future<void> registerUser(User user) async {
    final response = await http.post(
      Uri.parse(MainUtil().registerUrl),
      headers: headers,
      body: jsonEncode(user.toJson()),
    );

    final json = jsonDecode(response.body)['data'];
    final String token = jsonDecode(response.body)['token'];

    // save token to shared preferences
    final prefs = await SharedPreferences.getInstance();

    prefs.setString('token', token);

    _setUserAuthData(json);
  }

  Future<void> loginUser(String email, String password) async {
    print('email: $email, password: $password');

    final body = jsonEncode({
      'email': email,
      'password': password,
    });

    final response = await http.post(Uri.parse(MainUtil().loginUrl),
        body: body, headers: headers);

    print("Response: ${response.body}");

    final json = jsonDecode(response.body)['data'];

    final String token = jsonDecode(response.body)['token'];

    // save token to shared preferences
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);

    _setUserAuthData(json);
  }

  void _setUserAuthData(dynamic json) {
    User.fromJson({
      "name": json['name'] as String,
      "email": json['email'] as String,
      "phone": json['phone'] as String,
      "gender": json['gender'] as String,
      "birthdate": json['birthdate'] as String,
      "password": '',
      "password_confirmation": '',
      "address": '',
      "long": '',
      "lat": '',
      "kelId": '',
      "about": '',
      "profileImage": '',
      "bannerImage": '',
    });
  }
}

// Code Generator Command // 
// dart run build_runner build