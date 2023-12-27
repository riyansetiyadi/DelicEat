import 'dart:async';

import 'package:restaurant_app_submission_dicoding/data/api/api_service.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app_submission_dicoding/data/model/restaurant.dart';
import 'package:restaurant_app_submission_dicoding/utils/result_state.dart';

class ReviewRestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  ReviewRestaurantProvider({
    required this.apiService,
  });

  String _message = '';
  String get message => _message;

  ResultState _state = ResultState.init;
  ResultState get state => _state;
  void resetState() => _state = ResultState.init;

  CustomerGetReviews? _customerReviewsResult;
  CustomerGetReviews? get customerReviews => _customerReviewsResult;

  Future<String> addReviews(String id, String name, String review) async {
    CustomerAddReview dataReview =
        CustomerAddReview(id: id, name: name, review: review);
    try {
      _state = ResultState.loading;
      notifyListeners();
      final result = await apiService.addReviewRestaurant(dataReview);
      if (result.error == true) {
        _state = ResultState.noData;
        notifyListeners();
        _message =
            'Oops! There was an error while saving your review. Please try again later.';
        return _message;
      } else {
        _state = ResultState.hasData;
        _message = 'Your review has been successfully saved!';
        _customerReviewsResult = result;
        notifyListeners();
        return _message;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      _message =
          'Oops! There was an error while saving your review. Please try again later.';
      return _message;
    }
  }
}
