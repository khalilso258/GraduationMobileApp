import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<void> saveToken(String token) async {
    await _prefs?.setString('token', token);
  }

  static Future<void> saveRefreshToken(String token) async {
    await _prefs?.setString('refresh', token);
  }

  static String? getToken() {
    return _prefs?.getString('token');
  }
  static String? getRefreshToken() {
    return _prefs?.getString('refresh');
  }

  static Future<void> clearTokens() async {
    await _prefs?.remove('token');
  }

  static bool isTokenValid() {
    final token = getToken();
    return token != null && token.isNotEmpty;
  }
}