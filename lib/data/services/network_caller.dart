import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ecommerce_crafty_bay/data/models/response_data.dart';
import 'package:ecommerce_crafty_bay/presentation/state_holders/auth_controller.dart';
import 'package:http/http.dart' as http;

class NetworkCaller {
  Future<bool> isConnected() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  ResponseData _handleError(int statusCode, {String? message}) {
    log("Network Error: $message");
    return ResponseData(
      isSuccess: false,
      statusCode: statusCode,
      responseData: "",
      errorMessage: message ?? "Something went wrong!",
    );
  }

  Future<ResponseData> _handleUnauthorized() async {
    log("Unauthorized Access - Redirecting to Login");
    await AuthController.clearAuthData();
    AuthController.goToLogin();
    return _handleError(401, message: "Unauthorized. Redirecting to login.");
  }

  Future<ResponseData> _handleRequest(
      Future<http.Response> Function() request) async {
    if (!await isConnected()) {
      return _handleError(0, message: "No Internet Connection!");
    }

    try {
      final response = await request();
      log("Status Code: ${response.statusCode}");
      log("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        try {
          final dynamic decodedResponse = jsonDecode(response.body);
          if (decodedResponse is List) {
            return ResponseData(
              isSuccess: true,
              statusCode: response.statusCode,
              responseData: decodedResponse,
            );
          } else if (decodedResponse is Map<String, dynamic>) {
            return ResponseData(
              isSuccess: true,
              statusCode: response.statusCode,
              responseData: decodedResponse,
            );
          } else {
            return _handleError(response.statusCode,
                message: "Unexpected response format!");
          }
        } catch (e) {
          return _handleError(response.statusCode,
              message: "Invalid response format!");
        }
      } else if (response.statusCode == 401) {
        return _handleUnauthorized();
      } else {
        return _handleError(response.statusCode,
            message: "Server error: ${response.statusCode}");
      }
    } on SocketException {
      return _handleError(0,
          message: "Network error! Please check your connection.");
    } on FormatException {
      return _handleError(0, message: "Invalid response format!");
    } catch (e) {
      log("Exception: $e");
      return _handleError(0, message: "Unexpected error occurred!");
    }
  }

  Future<ResponseData> getRequest(String url, {String? token}) async {
    String? authToken = token ?? AuthController.token;
    log("GET Request: $url");
    log("Token: ${authToken != null && authToken.isNotEmpty ? authToken.substring(0, 5) : "No Token"}...");

    return _handleRequest(() async {
      return await http.get(
        Uri.parse(url),
        headers: {"token": authToken ?? "", "Content-type": "application/json"},
      );
    });
  }

  Future<ResponseData> postRequest(String url,
      {Map<String, dynamic>? body, String? token}) async {
    String? authToken = token ?? AuthController.token;
    log("POST Request: $url");
    log("Body: ${jsonEncode(body)}");

    return _handleRequest(() async {
      return await http.post(
        Uri.parse(url),
        body: jsonEncode(body),
        headers: {"token": authToken ?? "", "Content-type": "application/json"},
      );
    });
  }
}
