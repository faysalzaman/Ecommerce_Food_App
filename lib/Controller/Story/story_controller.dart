import 'dart:convert';

import 'package:food_ecommerce_app/Model/Story/FetchStoryModel.dart';
import 'package:food_ecommerce_app/Utils/api_manager.dart';
import 'package:food_ecommerce_app/Utils/constants.dart';

class StoryController {
  static Future<List<FetchStoryModel>> getOrderItemsByOrderId(
    String orderId,
  ) async {
    var url = "${AppUrls.baseUrl}/get/store/of/a/product";
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    var response = await ApiManager.getRequest(url, headers: headers);
    var data = jsonDecode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      List<FetchStoryModel> randomFiveItemsModel = (data["data"] as List)
          .map((e) => FetchStoryModel.fromJson(e))
          .toList();
      return randomFiveItemsModel;
    } else {
      String error = data['message'];
      throw Exception(error);
    }
  }

  static Future<void> getStory(String foodId) async {
    var url = "${AppUrls.baseUrl}/View/stores?_id=$foodId";
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    var response = await ApiManager.bodyLessPut(url, headers: headers);
    var data = jsonDecode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return data;
    } else {
      String error = data['message'];
      throw Exception(error);
    }
  }
}
