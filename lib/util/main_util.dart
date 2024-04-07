class MainUtil {
  // final String _baseUrl = 'http://10.0.2.2:8000/api/';
  final String _baseUrl = 'http://192.168.1.226:8000/api/';

  final String _publicDomain = 'http://192.168.1.226:8000/storage/';

  // Get public domain
  String get publicDomain => _publicDomain;

  // Get URL api
  String get baseUrl => _baseUrl;

  // Register
  String get registerUrl => '${_baseUrl}register';

  // login user
  String get loginUrl => '${_baseUrl}login';

  // logout user
  String get logoutUrl => '${_baseUrl}logout';

  // Get base info
  String get baseInfo => '${_baseUrl}profiles';

  // Update Profile data
  String get updateProfile => '${_baseUrl}profiles?_method=PUT';

  // Post user location
  String get postLocation => '${_baseUrl}store/location';
}
