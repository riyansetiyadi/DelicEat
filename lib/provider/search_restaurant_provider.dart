import 'dart:async';

import 'package:deliceat/data/api/api_service.dart';
import 'package:deliceat/data/model/restaurant.dart';
import 'package:flutter/material.dart';
import 'package:deliceat/utils/result_state.dart';

class SearchRestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  SearchRestaurantProvider({
    required this.apiService,
  });

  String _message = '';
  String get message => _message;

  RestaurantList? _restaurantListResult;
  RestaurantList? get restaurantList => _restaurantListResult;

  ResultState _state = ResultState.init;
  ResultState get state => _state;
  void resetState() => _state = ResultState.init;

  Future<dynamic> refreshRestaurant(String query) async {
    _fetchRestaurantByQuery(query);
  }

  Future<dynamic> searchRestaurant(String query) async {
    _fetchRestaurantByQuery(query);
  }

  Future<dynamic> _fetchRestaurantByQuery(String query) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final result = await apiService.getSearchRestaurant(query);
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
