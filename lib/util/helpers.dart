import 'package:url_launcher/url_launcher.dart';

class Helpers {
  void launchWhatsapp(String phone, String message) {
    String convertedPhone = _convertPhone(phone);

    print('Phone: $convertedPhone');

    final uri = Uri.encodeFull("https://wa.me/$convertedPhone?text=$message");
    launchUrl(Uri.parse(uri));
  }

  String _convertPhone(String phone) {
    // Remove first 0 in phone number and change it to 62
    if (phone.startsWith('0')) {
      phone = phone.replaceAll(RegExp(r"\s+\b|\b\s"), ""); // Remove spaces

      return '+62${phone.substring(1)}';
    }

    return phone;
  }

  String removeSeconds(String time) {
    // Split the time string by the colon
    List<String> parts = time.split(':');
    // Return the first two parts joined by a colon
    return '${parts[0]}:${parts[1]}';
  }
}
