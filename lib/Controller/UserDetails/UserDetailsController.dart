import 'dart:convert';

import 'package:food_ecommerce_app/Model/UserDetails/UserDetailsModel.dart';
import 'package:food_ecommerce_app/Utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:nb_utils/nb_utils.dart';

class UserDetailsController {
  static Future<UserDetailsModel> fetchUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString("userId").toString();
    String token = prefs.getString("token").toString();

    final url = Uri.parse("${AppUrls.baseUrl}/get-user-detail/$userId");

    Map<String, String> headers = {"authorization": "Bearer $token"};

    try {
      var response = await http.get(url, headers: headers);
      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = jsonDecode(response.body);
        var mdl = UserDetailsModel.fromJson(data);
        return mdl;
      } else {
        var data = jsonDecode(response.body);
        String msg = data['message'];
        throw Exception(msg);
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
