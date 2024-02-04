// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:food_ecommerce_app/Model/api_response.dart';
import 'package:food_ecommerce_app/Utils/api_manager.dart';
import 'package:food_ecommerce_app/Utils/constants.dart';

class OrderController {
  static Future<ApiResponse> placeOrder(
    String userId,
    String totalPrice,
    String address,
  ) async {
    var url = "${AppUrls.baseUrl}/place-order";

    var response = await ApiManager.postRequest(
      {"userId": userId, "totalPrice": totalPrice, "address": address},
      url,
    );
    var data = jsonDecode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return ApiResponse.fromJson(data, (d) => null);
    } else {
      String error = data['message'];
      throw Exception(error);
    }
  }
}
