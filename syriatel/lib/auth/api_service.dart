import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../services/storage_service.dart';
import '../view/login.dart';
import '../models/offers.dart';
import '../models/activated_packages.dart';
import '../models/profile_model.dart';
import '../models/register_model.dart';
import '../models/login_model.dart';

class ApiService {
  static const String baseUrl = 'http://172.20.10.2:8000/api';

  // ✅ دالة عامة للتعامل مع الأخطاء وخاصة 401
  static void handleApiError(int statusCode) {
    if (statusCode == 401) {
      StorageService.clearTokens();
      Get.offAll(() => Login());
    }
  }

  // ✅ GET request مع معالجة 401
  static Future<http.Response> getRequest(String url, String token) async {
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 401) handleApiError(401);
    return response;
  }

  // ✅ POST request مع معالجة 401
  static Future<http.Response> postRequest(String url, String token, Map body) async {
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(body),
    );

    if (response.statusCode == 401) handleApiError(401);
    return response;
  }

  // ✅ PUT request مع معالجة 401
  static Future<http.Response> putRequest(String url, String token, Map body) async {
    final response = await http.put(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(body),
    );

    if (response.statusCode == 401) handleApiError(401);
    return response;
  }

  // ✅ جلب الملف الشخصي
  static Future<ProfileModel?> getProfile(String token) async {
    final response = await getRequest('$baseUrl/profile/', token);
    if (response.statusCode == 200) {
      return ProfileModel.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  // ✅ تحديث الملف الشخصي
  static Future<http.Response> updateProfile(String token, ProfileModel profile) async {
    return await putRequest('$baseUrl/profile/update', token, profile.toJson());
  }

  // ✅ تسجيل مستخدم جديد
  static Future<http.Response> registerUser(RegisterRequestModel model) async {
    return await http.post(
      Uri.parse('$baseUrl/register/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(model.toJson()),
    );
  }

  // ✅ تسجيل الدخول
  static Future<http.Response> loginUser(LoginRequestModel model) async {
    return await http.post(
      Uri.parse('$baseUrl/login/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(model.toJson()),
    );
  }

  // ✅ جلب العروض
  static Future<List<OfferModel>> getOffers(String token) async {
    final response = await getRequest('$baseUrl/suggested-packages/', token);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final offersList = data['offers'] as List;
      return offersList.map((e) => OfferModel.fromJson(e)).toList();
    }
    return [];
  }

  // ✅ جلب الباقات المفعلة
  static Future<List<ActivatedPackageModel>> getActivatedPackages(String token) async {
    final response = await getRequest('$baseUrl/package/activated/', token);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List;
      return data.map((e) => ActivatedPackageModel.fromJson(e)).toList();
    }
    return [];
  }

  // ✅ قبول باقة
  static Future<bool> acceptPackage(String token, int packageId) async {
    final response = await postRequest('$baseUrl/package/$packageId/accept/', token, {});
    return response.statusCode == 200 || response.statusCode == 201;
  }

  // ✅ تفعيل باقة مخصصة
  static Future<bool> activateClusterPackage({
    required String token,
    required double internet,
    required int calls,
    required int sms,
  }) async {
    final body = {
      "internet": internet,
      "calls": calls,
      "sms": sms,
    };
    final response = await postRequest('$baseUrl/custom-packages/create-and-activate/', token, body);
    return response.statusCode == 201;
  }
  static Future<http.Response> logout(String refresh) async {
    final token = StorageService.getToken();
     print('====== $refresh');
    if (token == null || token.isEmpty) {
      return Future.error('Access token not found');
    }

    final response = await http.post(
      Uri.parse('$baseUrl/logout'),
      body: jsonEncode({
        'refresh' : refresh
      }),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',  // إرسال الـ access token فقط
      },
    );

    if (response.statusCode != 205) {
      print('Logout failed: ${response.statusCode} - ${response.body}');
    }

    return response;
  }}