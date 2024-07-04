class MainUtil {
  // final String _baseUrl = 'http://10.0.2.2:8000/api/';
  final String _baseUrl = 'http://192.168.1.226:8000/api/';
  // final String _baseUrl = 'http://tambakku-app.fiqifalahdev.org/api/';

  // final String _publicDomain = 'http://10.0.2.2:8000/storage/';
  final String _publicDomain = 'http://192.168.1.226:8000/storage/';
  // final String _publicDomain = 'http://tambakku-app.fiqifalahdev.org/storage/';

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
  String get userProfileDetails => '${_baseUrl}profiles'; // + /{id}p`
  String get allUserData => '${_baseUrl}get/all-users';

  // Update Profile data
  String get updateProfile => '${_baseUrl}profiles?_method=PUT';

  // Post user location
  String get postLocation => '${_baseUrl}store/location';
  String get getLocation => '${_baseUrl}locations';
  String get getCurrentLocation => '${_baseUrl}get/current-location';
  String get getTargetLocation => '${_baseUrl}locations/target';

  // Store Products
  String get postFeeds => '${_baseUrl}store/feeds';

  // Store Appointment
  String get postAppointment => '${_baseUrl}store/appointment-request';
  String get getAppointmentByAuthUser => '${_baseUrl}get/appointment-request';
  String get getIncomingRequest => '${_baseUrl}get/appointment-recipient';
  String get updateAppointment => '${_baseUrl}update/appointment-request';

  // Store user devices token
  String get storeDevicesToken => '${_baseUrl}store/user-token';
}
