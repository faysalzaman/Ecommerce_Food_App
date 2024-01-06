// ignore_for_file: avoid_print

import 'package:food_ecommerce_app/Model/Category/AllCategoriesModel.dart';
import 'package:food_ecommerce_app/Model/Items/FoodsByCategoryModel.dart';
import 'package:food_ecommerce_app/Utils/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CategoriesController {
  static Future<AllCategoriesModel> getAllCategories() async {
    var url = Uri.parse("${AppUrls.baseUrl}/get-catogray");
    var headers = {"Content-Type": "application/json"};

    try {
      var response = await http.get(url, headers: headers);
      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = jsonDecode(response.body);
        AllCategoriesModel randomFiveItemsModel =
            AllCategoriesModel.fromJson(data);

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

  static Future<List<FoodsByCategoryModel>> categoryById(
    String categoryId,
    String page,
    String pageSize,
  ) async {
    var url = Uri.parse(
        "${AppUrls.baseUrl}/get-food-items-by-category-id/$categoryId?page=$page&pageSize=$pageSize");
    var headers = {"Content-Type": "application/json"};

    try {
      var response = await http.get(url, headers: headers);
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.statusCode);
        var data = jsonDecode(response.body);
        List<FoodsByCategoryModel> randomFiveItemsModel = (data["data"] as List)
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
