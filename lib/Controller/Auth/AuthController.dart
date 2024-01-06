// ignore_for_file: file_names, avoid_print

import 'dart:convert';
import 'package:food_ecommerce_app/Model/Auth/LoginModel.dart';
import 'package:http/http.dart' as http;

import 'package:food_ecommerce_app/Utils/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';

class AuthController {
  static Future<void> signUp(
    String email,
    String password,
  ) async {
    var url = Uri.parse("${AppUrls.baseUrl}/signUp");

    var headers = {"Content-Type": "application/json"};
    var body = {"email": email, "password": password};

    try {
      var response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(body),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.statusCode);
      } else {
        print(response.statusCode);
        var data = jsonDecode(response.body);
        String msg = data['message'];
        throw Exception(msg);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<String> sendOtp(String email) async {
    var url = Uri.parse("${AppUrls.baseUrl}/resend-otp");

    var headers = {"Content-Type": "application/json"};
    var body = {"email": email};

    try {
      var response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(body),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = jsonDecode(response.body);
        String otp = data["data"]["Otp"].toString();
        print(otp);
        return otp;
      } else {
        var data = jsonDecode(response.body);
        String msg = data['message'];
        throw Exception(msg);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<void> varifyOtp(String email, String otp) async {
    var url = Uri.parse("${AppUrls.baseUrl}/emailVrifyOtp");

    var headers = {"Content-Type": "application/json"};
    var body = {"email": email, "code": otp};

    try {
      var response =
          await http.post(url, headers: headers, body: jsonEncode(body));

      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.statusCode);
      } else {
        var data = jsonDecode(response.body);
        String msg = data['message'];
        throw Exception(msg);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<LoginModel> login(String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var url = Uri.parse("${AppUrls.baseUrl}/Login");

    var headers = {"Content-Type": "application/json"};
    var body = {"email": email, "password": password};

    try {
      var response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(body),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = jsonDecode(response.body);

        String token = data['data']['accessToken'].toString();
        String userId = data['data']['_id'].toString();

        print("Token: $token");
        print("UserId: $userId");

        await prefs.setString("token", token);
        await prefs.setString("userId", userId);

        return LoginModel.fromJson(data);
      } else {
        var data = jsonDecode(response.body);
        String msg = data['message'];
        throw Exception(msg);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<void> completeProfile(
    String fullName,
    String phoneNo,
    XFile imageFile,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String userId = prefs.getString("userId").toString();
    String token = prefs.getString("token").toString();

    var url = Uri.parse("${AppUrls.baseUrl}/update-user/$userId");
    Map<String, String> headers = {
      'authorization': 'Bearer $token',
      'Content-Type': 'multipart/form-data',
    };

    var request = http.MultipartRequest('PUT', url);

    request.fields['fullname'] = fullName;
    request.fields['Phone'] = phoneNo;
    request.headers.addAll(headers);
    var pic = await http.MultipartFile.fromPath("ProfileImage", imageFile.path);
    request.files.add(pic);

    var response = await request.send();

    if (response.statusCode == 200 || response.statusCode == 201) {
      print(response.statusCode);
    } else {
      var data = jsonDecode(response.toString());
      String msg = data['message'];
      throw Exception(msg);
    }
  }

  static Future<bool> refreshToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token").toString();
    String userId = prefs.getString("userId").toString();

    var url = Uri.parse("${AppUrls.baseUrl}/refresh-token");
    var headers = {
      "Content-Type": "application/json",
      "authorization": "Bearer $token",
    };
    var body = {"_id": userId};

    try {
      var response =
          await http.post(url, headers: headers, body: jsonEncode(body));
      print(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = jsonDecode(response.body);
        bool isAuthorized = data['data']['isAuthorized'];
        return isAuthorized;
      } else {
        var data = jsonDecode(response.body);
        String error = data['message'];
        throw Exception(error);
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
