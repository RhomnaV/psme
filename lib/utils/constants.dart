import 'package:flutter_dotenv/flutter_dotenv.dart';

final String baseUrl = dotenv.env['API_URL'] ?? '';
final String login = "$baseUrl/login";
final String sendOTP = "$baseUrl/otp/sendOTPtoMail";
final String verifyOTP = "$baseUrl/otp/verifyOTP";