import 'dart:async';

import 'package:restaurant_app_submission_dicoding/data/api/api_service.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app_submission_dicoding/data/model/restaurant.dart';

enum ReviewState { init, loading, noData, hasData, error }

class ReviewRestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  ReviewRestaurantProvider({
    required this.apiService,
  });

  String _message = '';
  String get message => _message;

  ReviewState _state = ReviewState.init;
  ReviewState get state => _state;

  CustomerGetReviews? _customerReviewsResult;
  CustomerGetReviews? get customerReviews => _customerReviewsResult;

  Future<String> addReviews(String id, String name, String review) async {
    CustomerAddReview dataReview =
        CustomerAddReview(id: id, name: name, review: review);
    try {
      _state = ReviewState.loading;
      notifyListeners();
      final result = await apiService.addReviewRestaurant(dataReview);
      if (result.error == true) {
        _state = ReviewState.noData;
        notifyListeners();
        _message =
            'Oops! There was an error while saving your review. Please try again later.';
        return _message;
      } else {
        _state = ReviewState.hasData;
        _message = 'Your review has been successfully saved!';
        _customerReviewsResult = result;
        notifyListeners();
        return _message;
      }
    } catch (e) {
      _state = ReviewState.error;
      notifyListeners();
      _message =
          'Oops! There was an error while saving your review. Please try again later.';
      return _message;
    }
  }
}
