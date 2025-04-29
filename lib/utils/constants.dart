import 'package:flutter_dotenv/flutter_dotenv.dart';

final String baseUrl =
    'https://psme-sandbox-api.smartpay.ph/public/index.php/api' ?? '';

//Login & Registration
final String login = "$baseUrl/login";
final String sendOTP = "$baseUrl/otp/sendOTPtoMail";
final String verifyOTP = "$baseUrl/otp/verifyOTP";

//Events
final String events = "$baseUrl/getEvent?filter=";
final String activePrcLicenceType = "$baseUrl/getActivePrcLicenceType";
final String sector = "$baseUrl/getSector";
final String suffix = "$baseUrl/getSuffix";
final String activeChapter = "$baseUrl/getActiveChapter";
final String country = "$baseUrl/getCountry";
final String memberType = "$baseUrl/getActiveMemberType";

String getEventByIdUrl(int id) {
  return "$baseUrl/getEventbyId?id=$id";
}
