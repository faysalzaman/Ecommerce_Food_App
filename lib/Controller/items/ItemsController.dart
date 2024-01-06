// ignore_for_file: file_names

import 'dart:convert';

import 'package:food_ecommerce_app/Model/Items/FoodsByCategoryModel.dart';
import 'package:food_ecommerce_app/Utils/constants.dart';
import 'package:http/http.dart' as http;

class ItemController {
  static Future<List<FoodsByCategoryModel>> getRandomFiveItems() async {
    var url = Uri.parse("${AppUrls.baseUrl}/get-random-five-fooditem");
    var headers = {"Content-Type": "application/json"};

    try {
      var response = await http.get(url, headers: headers);
      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = jsonDecode(response.body);
        // data["data"]
        List<FoodsByCategoryModel> randomFiveItemsModel = (data['data'] as List)
            .map((e) => FoodsByCategoryModel.fromJson(e))
            .toList();
        return randomFiveItemsModel;
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
