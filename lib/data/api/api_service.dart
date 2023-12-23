import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restaurant_app_submission_dicoding/data/model/restaurant.dart';

class ApiService {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev';

  Future<RestaurantList> getAllRestaurant() async {
    final response = await http.get(Uri.parse("$_baseUrl/list"));
    if (response.statusCode == 200) {
      final allRestaurant = RestaurantList.fromJson(json.decode(response.body));
      return allRestaurant;
    } else {
      throw Exception('Failed to load restaurants');
    }
  }

  Future<RestaurantDetail> getDetailRestaurant(String id) async {
    final response = await http.get(Uri.parse("$_baseUrl/detail/$id"));
    if (response.statusCode == 200) {
      final detailRestaurant =
          RestaurantDetail.fromJson(json.decode(response.body));
      return detailRestaurant;
    } else {
      throw Exception('Failed to load restaurants');
    }
  }

  Future<RestaurantList> getSearchRestaurant(String query) async {
    final response = await http.get(Uri.parse("$_baseUrl/search?q=$query"));
    if (response.statusCode == 200) {
      final searchRestaurant =
          RestaurantList.fromJson(json.decode(response.body));
      return searchRestaurant;
    } else {
      throw Exception('Failed to load restaurants');
    }
  }

  Future<CustomerGetReviews> addReviewRestaurant(
      CustomerAddReview review) async {
    final response = await http.post(
      Uri.parse("$_baseUrl/review"),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(review.toJson()),
    );
    if (response.statusCode == 201) {
      final reviewsRestaurant =
          CustomerGetReviews.fromJson(json.decode(response.body));
      return reviewsRestaurant;
    } else {
      throw Exception('Failed to load restaurants');
    }
  }
}
