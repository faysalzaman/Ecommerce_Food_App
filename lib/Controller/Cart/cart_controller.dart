// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:food_ecommerce_app/Model/Cart/GetCartByUserIdModel.dart';
import 'package:food_ecommerce_app/Model/Cart/IsInCartModel.dart';
import 'package:food_ecommerce_app/Model/api_response.dart';
import 'package:food_ecommerce_app/Utils/api_manager.dart';
import 'package:food_ecommerce_app/Utils/constants.dart';

class CartController {
  static Future<ApiResponse<IsInCartModel>> getIsInCart(
    String foodId,
    String userId,
  ) async {
    var url =
        "${AppUrls.baseUrl}/get-foodid-to-addtocart?userId=$userId&foodId=$foodId";

    try {
      var response = await ApiManager.getRequest(url);
      var data = jsonDecode(response.body);
      print(response.statusCode);

      if (response.statusCode == 200 || response.statusCode == 201) {
        IsInCartModel foods = IsInCartModel.fromJson(data["data"]);
        return ApiResponse.fromJson(data, (data) => foods);
      } else {
        String error = data['message'];
        throw Exception(error);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<ApiResponse<List<GetCartByUserIdModel>>> getCartByUserId(
    String userId,
    String page,
    String pageSize,
  ) async {
    var url =
        "${AppUrls.baseUrl}/get-food-item-to-addtocart/$userId?page=$page&pageSize=$pageSize";

    try {
      var response = await ApiManager.getRequest(url);
      var data = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        List<GetCartByUserIdModel> foods = [];
        data["data"].forEach((v) {
          foods.add(GetCartByUserIdModel.fromJson(v));
        });
        return ApiResponse.fromJson(data, (data) => foods);
      } else {
        String error = data['message'];
        throw Exception(error);
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
