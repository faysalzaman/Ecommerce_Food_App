// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:food_ecommerce_app/Model/Items/FoodsByCategoryModel.dart';
import 'package:food_ecommerce_app/Model/api_response.dart';
import 'package:food_ecommerce_app/Utils/api_manager.dart';
import 'package:food_ecommerce_app/Utils/constants.dart';

abstract class FoodController {
  static Future<ApiResponse<List<FoodsByCategoryModel>>> getFoodsByCategoryId(
    String categoryId,
    String page,
    String pageSize,
  ) async {
    var url =
        "${AppUrls.baseUrl}/get-food-items-by-category-id/$categoryId?page=$page&pageSize=$pageSize";

    try {
      var response = await ApiManager.getRequest(url);
      var data = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        List<FoodsByCategoryModel> foods = [];
        data["data"].forEach((v) {
          foods.add(FoodsByCategoryModel.fromJson(v));
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
