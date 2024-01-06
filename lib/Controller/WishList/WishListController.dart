// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:food_ecommerce_app/Model/WishList/IsInFavoriteModel.dart';
import 'package:food_ecommerce_app/Model/api_response.dart';
import 'package:food_ecommerce_app/Utils/api_manager.dart';
import 'package:food_ecommerce_app/Utils/constants.dart';

class WishListController {
  static Future<ApiResponse<IsInFavoriteModel>> getIsFavorite(
    String foodId,
    String userId,
  ) async {
    var url =
        "${AppUrls.baseUrl}/get-foodid-to-wishlist/?userId=$userId&foodId=$foodId";

    print(url);

    try {
      var response = await ApiManager.getRequest(url);
      var data = jsonDecode(response.body);
      print(response.statusCode);
      if (response.statusCode == 200 || response.statusCode == 201) {
        IsInFavoriteModel foods = IsInFavoriteModel.fromJson(data["data"]);
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
