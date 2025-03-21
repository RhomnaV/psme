import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/constants.dart';

class ApiService {
  // GET Request
  // static Future<List<dynamic>> fetchUsers() async {
  //   final response = await http.get(Uri.parse(verifyOTP));

  //   if (response.statusCode == 200) {
  //     return jsonDecode(response.body);
  //   } else {
  //     throw Exception('Failed to load users');
  //   }
  // }

  // POST Request (Login)
  static Future<Map<String, dynamic>> loginUser(String email, String password) async {
    final response = await http.post(
      Uri.parse(login),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "password": password}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Login failed');
    }
  }

     static Future<Map<String, dynamic>> sendOTPUser(String email) async {
    try {
      final response = await http.post(
        Uri.parse(sendOTP), // Ensure `sendOTP` is a valid API URL
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"emailid": email}),
      );

      // ✅ Decode JSON response
      final Map<String, dynamic> jsonData = jsonDecode(response.body);

      // ✅ Debug the response
      print("📩 API Response: $jsonData");

      // ✅ Check if `resultKey` exists and equals 1
      if (jsonData.containsKey('resultKey') && jsonData['resultKey'] == 1) {
        return jsonData;
      } else {
        return {"success": false, "message": jsonData['message'] ?? "Failed to send OTP"};
      }
    } catch (e) {
      return {"success": false, "message": "Error: $e"};
    }
  }

  static Future<Map<String, dynamic>> verifyOTPUser(String otp, String email) async {
    try {
      final response = await http.post(
        Uri.parse(verifyOTP), // Ensure `verifyOTP` is a valid API URL
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"emailid": email, "otp": otp}),
      );

      // ✅ Decode JSON response
      final Map<String, dynamic> jsonData = jsonDecode(response.body);

      // ✅ Debug the response
      print("🔍 API Response: $jsonData");

      // ✅ Check if `resultKey` exists and equals 1
      if (jsonData.containsKey('resultKey') && jsonData['resultKey'] == 1) {
        return jsonData; // OTP verified successfully
      } else {
        return {"success": false, "message": jsonData['message'] ?? "Failed to verify OTP"};
      }
    } catch (e) {
      return {"success": false, "message": "Error: $e"};
    }
  }
}
