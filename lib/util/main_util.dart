class MainUtil {
  final String _baseUrl = 'http://10.0.2.2:8000/api/';

  // Get URL api
  String get baseUrl => _baseUrl;

  // Register
  String get registerUrl => '${_baseUrl}register';

  // login user
  String get loginUrl => '${_baseUrl}login';

  // Get base info
  String get baseInfo => '${_baseUrl}profiles';
}
