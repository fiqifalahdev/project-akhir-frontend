import 'dart:convert';

import 'package:frontend_tambakku/logic/states.dart';
import 'package:frontend_tambakku/models/base_info.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:http/http.dart' as http;

import '../util/main_util.dart';

// Necessary for code-generation to work
part 'main_states.g.dart';

late BaseInfo userData;

// Get User Base info data
@riverpod
BaseInfo getUserData(GetUserDataRef) {
  return userData;
}

// Fetch the user base Info data with HTTP request
@riverpod
Future<void> getBaseInfo(GetBaseInfoRef ref, String token) async {
  final tokenEntries = <String, String>{'Authorization': 'Bearer $token'};

  headers.addEntries(tokenEntries.entries);

  final response = await http
      .get(Uri.parse(MainUtil().baseInfo), headers: headers)
      .then((value) {
    if (value.statusCode == 401) {
      throw Exception("Internal Server Error : User unauthenticated");
    }

    final json = jsonDecode(value.body)['data']['detail'];

    userData = BaseInfo.fromJson(json);
  });
}