import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/constants.dart';
import '../models/event.dart';
import '../models/country.dart';
import '../models/chapter.dart'; // ✅ Import Chapter model

class ApiService {
  static Future<List<dynamic>> fetchPRCLicense() async {
    try {
      final response = await http.get(Uri.parse(activePrcLicenceType));
      final Map<String, dynamic> jsonData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        if (jsonData.containsKey('resultKey') && jsonData['resultKey'] == 1) {
          final dynamic resultValue = jsonData['resultValue'];
          return resultValue is List ? resultValue : [];
        }
      }
      throw Exception('Failed to License Type');
    } catch (e) {
      print("Error fetching License Type: $e");
      return [];
    }
  }

  static Future<List<Country>> fetchCountry() async {
    try {
      final response = await http.get(Uri.parse(country));

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = jsonDecode(response.body);

        if (jsonData.containsKey('resultKey') && jsonData['resultKey'] == 1) {
          return (jsonData['resultValue'] as List)
              .map((json) => Country.fromJson(json as Map<String, dynamic>))
              .toList();
        }
      }
      throw Exception('Failed to fetch Country data');
    } catch (e) {
      print("Error fetching Country: $e");
      return [];
    }
  }

  // ✅ Fetch Chapter data
  static Future<List<Chapter>> fetchChapters() async {
    try {
      final response = await http.get(
        Uri.parse(
          activeChapter,
        ), // 🔁 Replaced chapterEndpoint with activeChapter
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = jsonDecode(response.body);

        if (jsonData.containsKey('resultKey') && jsonData['resultKey'] == 1) {
          return (jsonData['resultValue'] as List)
              .map((json) => Chapter.fromJson(json as Map<String, dynamic>))
              .toList();
        }
      }
      throw Exception('Failed to fetch Chapter data');
    } catch (e) {
      print("Error fetching Chapters: $e");
      return [];
    }
  }

  static Future<List<Event>> _fetchEventsFromAPI(
    String url, {
    bool singleEvent = false,
  }) async {
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = jsonDecode(response.body);

        if (jsonData.containsKey('resultKey') && jsonData['resultKey'] == 1) {
          final dynamic resultValue = jsonData['resultValue'];

          final List<dynamic> eventList =
              (resultValue is List) ? resultValue : [resultValue];

          if (singleEvent && eventList.isNotEmpty) {
            return [Event.fromJson(eventList.first)];
          }

          return eventList.map((event) => Event.fromJson(event)).toList();
        }
      }

      throw Exception("Failed to load events: ${response.statusCode}");
    } catch (e) {
      print("Error fetching events: $e");
      return [];
    }
  }

  static Future<List<Event>> fetchEvents() async {
    return await _fetchEventsFromAPI(events);
  }

  static Future<Event?> fetchEventByID(int eventID) async {
    String url = getEventByIdUrl(eventID);
    print("Fetching event details from URL: $url");

    List<Event> events = await _fetchEventsFromAPI(url, singleEvent: true);
    return events.isNotEmpty ? events.first : null;
  }

  static Future<Map<String, dynamic>> loginUser(
    String email,
    String password,
  ) async {
    try {
      final response = await http.post(
        Uri.parse(login),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "username": email,
          "password": password,
          "isadminuser": false,
        }),
      );

      final Map<String, dynamic> responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        if (responseData['success'] == true) {
          await _setSession(responseData);
          return responseData;
        } else {
          throw Exception(responseData['message'] ?? 'Login failed');
        }
      } else {
        throw Exception(
          responseData['message'] ??
              'Login failed with status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<void> _setSession(Map<String, dynamic> userData) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString('access_token', userData['access_token'] ?? '');
    await prefs.setString('token_type', userData['token_type'] ?? '');

    if (userData['userinfo'] != null && userData['userinfo'].isNotEmpty) {
      await prefs.setString('user', jsonEncode(userData['userinfo'][0]));
    }
  }

  static Future<Map<String, dynamic>?> getSession() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final String? token = prefs.getString('access_token');
    final String? tokenType = prefs.getString('token_type');
    final String? user = prefs.getString('user');

    if (token != null && user != null) {
      return {
        "access_token": token,
        "token_type": tokenType,
        "user": jsonDecode(user),
      };
    }
    return null;
  }

  static Future<void> clearSession() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('access_token');
    await prefs.remove('token_type');
    await prefs.remove('user');
  }

  static Future<Map<String, dynamic>> sendOTPUser(String email) async {
    try {
      final response = await http.post(
        Uri.parse(sendOTP),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"emailid": email}),
      );

      final Map<String, dynamic> jsonData = jsonDecode(response.body);

      if (jsonData.containsKey('resultKey') && jsonData['resultKey'] == 1) {
        return jsonData;
      } else {
        return {
          "success": false,
          "message": jsonData['message'] ?? "Failed to send OTP",
        };
      }
    } catch (e) {
      return {"success": false, "message": "Error: $e"};
    }
  }

  static Future<Map<String, dynamic>> verifyOTPUser(
    String otp,
    String email,
  ) async {
    try {
      final response = await http.post(
        Uri.parse(verifyOTP),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"emailid": email, "otp": otp}),
      );

      final Map<String, dynamic> jsonData = jsonDecode(response.body);

      print("🔍 API Response: $jsonData");

      if (jsonData.containsKey('resultKey') && jsonData['resultKey'] == 1) {
        return jsonData;
      } else {
        return {
          "success": false,
          "message": jsonData['message'] ?? "Failed to verify OTP",
        };
      }
    } catch (e) {
      return {"success": false, "message": "Error: $e"};
    }
  }
}
