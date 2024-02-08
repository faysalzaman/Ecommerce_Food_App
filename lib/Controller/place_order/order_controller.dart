// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:food_ecommerce_app/Model/Order/OrderItemByOrderIdModel.dart';
import 'package:food_ecommerce_app/Model/Order/OrdersByUserIdModel.dart';
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

  static Future<List<OrdersByUserIdModel>> getOrdersByUserId(
    String userId,
    String page,
    String pageSize,
  ) async {
    var url =
        "${AppUrls.baseUrl}/get-order-by-userid/$userId?page=$page&pageSize=$pageSize";
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    print(url);

    var response = await ApiManager.getRequest(url, headers: headers);
    var data = jsonDecode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      List<OrdersByUserIdModel> randomFiveItemsModel = (data["data"] as List)
          .map((e) => OrdersByUserIdModel.fromJson(e))
          .toList();
      return randomFiveItemsModel;
    } else {
      String error = data['message'];
      throw Exception(error);
    }
  }

  static Future<List<OrderItemByOrderIdModel>> getOrderItemsByOrderId(
    String orderId,
  ) async {
    var url = "${AppUrls.baseUrl}/get-allorder-item-byorderid/$orderId";
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    var response = await ApiManager.getRequest(url, headers: headers);
    var data = jsonDecode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      List<OrderItemByOrderIdModel> randomFiveItemsModel =
          (data["data"] as List)
              .map((e) => OrderItemByOrderIdModel.fromJson(e))
              .toList();
      return randomFiveItemsModel;
    } else {
      String error = data['message'];
      throw Exception(error);
    }
  }
}
