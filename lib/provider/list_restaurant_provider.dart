import 'dart:async';

import 'package:restaurant_app_submission_dicoding/data/api/api_service.dart';
import 'package:restaurant_app_submission_dicoding/data/model/restaurant.dart';
import 'package:flutter/material.dart';

enum ResultState { loading, noData, hasData, error }

class ListRestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  ListRestaurantProvider({required this.apiService}) {
    _fetchAllRestaurant();
  }

  String _message = '';
  String get message => _message;

  late RestaurantList _restaurantListResult;
  RestaurantList get restaurantList => _restaurantListResult;

  late ResultState _state;
  ResultState get state => _state;

  Future<dynamic> refreshRestaurant() async {
    _fetchAllRestaurant();
  }

  Future<dynamic> _fetchAllRestaurant() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final result = await apiService.getAllRestaurant();
      if (result.restaurant.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantListResult = result;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
