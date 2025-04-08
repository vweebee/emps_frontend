import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://<your-ngrok-or-server-url>';

  // 1. Homepage
  static Future<http.Response> getHomePage() async {
    return await http.get(Uri.parse('$baseUrl/'));
  }

  // 2. Sign Up
  static Future<http.Response> signUp(String email, String password) async {
    return await http.post(
      Uri.parse('$baseUrl/signup'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );
  }

  // 3. Verify OTP
  static Future<http.Response> verifyOtp(String email, String otp) async {
    return await http.post(
      Uri.parse('$baseUrl/verify-otp'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'otp': otp}),
    );
  }

  // 4. Resend OTP
  static Future<http.Response> resendOtp(String email) async {
    return await http.post(
      Uri.parse('$baseUrl/resend-otp'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email}),
    );
  }

  // 5. Forgot Password
  static Future<http.Response> forgotPassword(String email) async {
    return await http.post(
      Uri.parse('$baseUrl/forgot-password'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email}),
    );
  }

  // 6. Reset Password
  static Future<http.Response> resetPassword(String token, String newPassword) async {
    return await http.post(
      Uri.parse('$baseUrl/reset-password/$token'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'new_password': newPassword}),
    );
  }

  // 7. Login
  static Future<http.Response> login(String email, String password) async {
    return await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );
  }

  // 8. Google Login
  static Future<http.Response> loginWithGoogle(String idToken) async {
    return await http.post(
      Uri.parse('$baseUrl/login/google'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'id_token': idToken}),
    );
  }

  // 9. Logout
  static Future<http.Response> logout(String token) async {
    return await http.post(
      Uri.parse('$baseUrl/logout'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
  }

  // 10. Delete Account
  static Future<http.Response> deleteAccount(String token) async {
    return await http.delete(
      Uri.parse('$baseUrl/delete-account'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
  }

  // 11. Get Garment Image
  static Future<http.Response> getGarmentImage(String filename) async {
    return await http.get(Uri.parse('$baseUrl/get_image/$filename'));
  }

  // 12. Upload Garment
  static Future<http.StreamedResponse> uploadGarment(
    String token,
    String filePath,
    Map<String, String> additionalFields,
  ) async {
    var uri = Uri.parse('$baseUrl/upload');
    var request = http.MultipartRequest('POST', uri)
      ..headers['Authorization'] = 'Bearer $token'
      ..files.add(await http.MultipartFile.fromPath('image', filePath));

    request.fields.addAll(additionalFields);

    return await request.send();
  }

  // 13. Delete Garment
  static Future<http.Response> deleteGarment(String token, String garmentId) async {
    return await http.post(
      Uri.parse('$baseUrl/delete'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({'garment_id': garmentId}),
    );
  }

  // 14. Edit Garment
  static Future<http.Response> editGarment(
    String token,
    String garmentId,
    Map<String, dynamic> updates,
  ) async {
    return await http.post(
      Uri.parse('$baseUrl/edit'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({'garment_id': garmentId, ...updates}),
    );
  }
}
