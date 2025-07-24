import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:google_sign_in/google_sign_in.dart';

class ApiService {
  static const String baseUrl = "http://10.0.2.2:5000";

  static Future<Map<String, dynamic>?> login(String email, String password) async {
    final url = Uri.parse('$baseUrl/login');
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "password": password}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return null;
    }
  }

  static Future<bool> register(String email, String password) async {
    final url = Uri.parse('$baseUrl/register');
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "email": email,
        "password": password,
        "name": "User Default", // tambahkan kolom name sesuai kebutuhan
      }),
    );

    return response.statusCode == 201;
  }

  static Future<bool> inputMenstruasi(int userId, String startDate, int cycleLength, int duration) async {
    final url = Uri.parse('$baseUrl/input-menstruasi');
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "user_id": userId,
        "start_date": startDate,
        "cycle_length": cycleLength,
        "duration": duration,
      }),
    );

    return response.statusCode == 200;
  }

  // ✅ Tambahan untuk Point 2
  static final GoogleSignIn _googleSignIn = GoogleSignIn();

  static Future<GoogleSignInAccount?> signInWithGoogle() async {
    try {
      final account = await _googleSignIn.signIn();
      return account;
    } catch (e) {
      print("Error login Google: $e");
      return null;
    }
  }
}
