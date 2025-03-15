import 'dart:convert';

import 'package:ecommerce_crafty_bay/data/models/complete_profile_model.dart';
import 'package:ecommerce_crafty_bay/data/models/read_profile_data.dart';
import 'package:ecommerce_crafty_bay/presentation/ui/screens/auth/verify_email_screen.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  static String? token;
  CompleteProfileModel? completeProfileModel;
  ReadProfileModel? readProfileData;

  Future<void> saveUserDetails(
      String t, ReadProfileModel? p, CompleteProfileModel? cp) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString("token", t);
    if (p != null) {
      await sharedPreferences.setString("readProfile", jsonEncode(p.toJson()));
    }
    if (cp != null) {
      await sharedPreferences.setString(
          "completeProfile", jsonEncode(cp.toJson()));
    }
    token = t;
    readProfileData = p;
    completeProfileModel = cp;
  }

  Future<void> initialize() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    token = sharedPreferences.getString("token") ?? "";
    readProfileData = await _getProfile();
    completeProfileModel = await _getCompleteProfile();
  }

  Future<bool> isLoggedIn() async {
    await initialize();
    return token != null && token!.isNotEmpty;
  }

  bool get isTokenNotNull => token != null && token!.isNotEmpty;

  Future<ReadProfileModel?> _getProfile() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final String? strProfile = sharedPreferences.getString("readProfile");
    if (strProfile == null || strProfile.isEmpty) return null;
    return ReadProfileModel.fromJson(jsonDecode(strProfile));
  }

  Future<CompleteProfileModel?> _getCompleteProfile() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final String? strProfile = sharedPreferences.getString("completeProfile");
    if (strProfile == null || strProfile.isEmpty) return null;
    return CompleteProfileModel.fromJson(jsonDecode(strProfile));
  }

  static Future<void> clearAuthData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.remove("token");
    await sharedPreferences.remove("readProfile");
    await sharedPreferences.remove("completeProfile");
    token = null;
  }

  static Future<void> goToLogin() async {
    Get.offAll(() => const VerifyEmailScreen());
  }
}
