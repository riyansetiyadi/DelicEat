import 'dart:async';

import 'package:restaurant_app_submission_dicoding/data/api/api_service.dart';
import 'package:restaurant_app_submission_dicoding/data/model/restaurant.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app_submission_dicoding/utils/result_state.dart';

class DetailRestaurantProvider extends ChangeNotifier {
  final ApiService apiService;
  final String idRestaurant;

  DetailRestaurantProvider(
      {required this.apiService, required this.idRestaurant}) {
    _fetchDetailRestaurant(idRestaurant);
  }

  String _message = '';
  String get message => _message;

  late RestaurantDetail _restaurantDetailResult;
  RestaurantDetail get restaurantDetail => _restaurantDetailResult;

  late ResultState _state;
  ResultState get state => _state;

  Future<dynamic> _fetchDetailRestaurant(String id) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final result = await apiService.getDetailRestaurant(id);
      if (result.error == true) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantDetailResult = result;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
