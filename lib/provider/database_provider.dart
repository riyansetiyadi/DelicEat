import 'package:flutter/foundation.dart';
import 'package:restaurant_app_submission_dicoding/data/db/database_helper.dart';
import 'package:restaurant_app_submission_dicoding/data/model/restaurant.dart';
import 'package:restaurant_app_submission_dicoding/utils/result_state.dart';

class DatabaseProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelper;

  DatabaseProvider({required this.databaseHelper}) {
    _getFavorites();
  }

  late ResultState _state;
  ResultState get state => _state;

  String _message = '';
  String get message => _message;

  List<Restaurant> _favorites = [];
  List<Restaurant> get favorites => _favorites;

  Future<dynamic> refreshRestaurant() async {
    _getFavorites();
  }

  void _getFavorites() async {
    _favorites = await databaseHelper.getFavorites();
    if (_favorites.isNotEmpty) {
      _state = ResultState.hasData;
    } else {
      _state = ResultState.noData;
      _message = 'Empty Data';
    }
    notifyListeners();
  }

  Future<String> addFavorites(Restaurant restaurant) async {
    try {
      await databaseHelper.insertFavorite(restaurant);
      _getFavorites();
      return _message = 'The restaurant has been added to your favorites.';
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Failed to add restaurant to favorites.';
    }
  }

  Future<bool> isFavorite(String id) async {
    final favoriteArticle = await databaseHelper.getFavoriteById(id);
    return favoriteArticle.isNotEmpty;
  }

  Future<String> removeFavorite(String id) async {
    try {
      await databaseHelper.removeFavorite(id);
      _getFavorites();
      return _message = 'The restaurant has been removed from your favorites.';
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Failed to remove restaurant from favorites.';
    }
  }
}
