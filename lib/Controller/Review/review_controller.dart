import 'dart:convert';

import 'package:food_ecommerce_app/Model/Review/get_all_review_model.dart';
import 'package:food_ecommerce_app/Model/api_response.dart';
import 'package:food_ecommerce_app/Utils/api_manager.dart';
import 'package:food_ecommerce_app/Utils/constants.dart';

class ReviewController {
  static Future<ApiResponse> postReview(
    String userId,
    String foodId,
    String text,
  ) async {
    var url = "${AppUrls.baseUrl}/add/post/review";

    try {
      var response = await ApiManager.postRequest(
        {"userId": userId, "foodId": foodId, "text": text},
        url,
        headers: {"Content-Type": "application/json"},
      );
      var data = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return ApiResponse.fromJson(data, (data) => null);
      } else {
        String error = data['message'];
        throw Exception(error);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<ApiResponse> getAllReview(
    String foodId,
    String page,
    String pageSize,
  ) async {
    var url =
        "${AppUrls.baseUrl}/get/all/reviews/by/$foodId?page=$page&pageSize=$pageSize&sort=createdAt&order=desc";

    var response = await ApiManager.getRequest(url);
    var data = jsonDecode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      List<GetAllReviewModel> reviews = [];
      var dataReviews = data['data'] as List;
      for (var element in dataReviews) {
        reviews.add(GetAllReviewModel.fromJson(element));
      }
      return ApiResponse.fromJson(data, (data) => reviews);
    } else if (data['status'] == 200 && data['data'] == null) {
      List<GetAllReviewModel> l = [];
      return ApiResponse.fromJson(data, (data) => l);
    } else {
      String error = data['message'];
      throw Exception(error);
    }
  }

  static Future<ApiResponse<int>> getLengthReview(String foodId) async {
    var url = "${AppUrls.baseUrl}/get/all/reviews/length/by/$foodId";

    var response = await ApiManager.getRequest(url);
    var data = jsonDecode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      int leng = data['data']['length'];
      print(leng);
      return ApiResponse.fromJson(data, (d) => leng);
    } else {
      String error = data['message'];
      throw Exception(error);
    }
  }
}
