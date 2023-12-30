import 'package:deliceat/utils/date_time_helper.dart';

DateTimeHelper dateTimeHelper = DateTimeHelper();

class RestaurantList {
  final bool error;
  final String? message;
  final int? count;
  final int? founded;
  final List<Restaurant> restaurant;

  RestaurantList({
    required this.error,
    this.message,
    this.count,
    this.founded,
    required this.restaurant,
  });

  factory RestaurantList.fromJson(Map<String, dynamic> json) => RestaurantList(
        error: json["error"],
        message: json.containsKey('message') ? json["message"] : null,
        count: json.containsKey('count') ? json["count"] : null,
        founded: json.containsKey('founded') ? json["founded"] : null,
        restaurant: List<Restaurant>.from(
            (json["restaurants"] as List).map((x) => Restaurant.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "count": count,
        "founded": founded,
        "restaurants": List<dynamic>.from(restaurant.map((x) => x.toJson()))
      };
}

class RestaurantDetail {
  final bool error;
  final String message;
  final Restaurant restaurant;

  RestaurantDetail({
    required this.error,
    required this.message,
    required this.restaurant,
  });

  factory RestaurantDetail.fromJson(Map<String, dynamic> json) =>
      RestaurantDetail(
        error: json["error"],
        message: json["message"],
        restaurant: Restaurant.fromJson(json["restaurant"]),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "restaurant": restaurant,
      };
}

class Restaurant {
  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final double rating;
  final String? address;
  final List<Category>? categories;
  final Menu? menus;
  final List<CustomerReview>? customerReviews;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
    this.address,
    this.categories,
    this.menus,
    this.customerReviews,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        pictureId: json["pictureId"],
        city: json["city"],
        rating: json["rating"] is String
            ? double.tryParse(json["rating"]) ?? 0.0
            : json["rating"]?.toDouble(),
        address: json.containsKey('address')
            ? json['address'] != null
                ? json["address"]
                : null
            : null,
        categories: json.containsKey('categories')
            ? json['categories'] != null
                ? List<Category>.from(
                    json["categories"].map((x) => Category.fromJson(x)))
                : null
            : null,
        menus: json.containsKey('menus')
            ? json['menus'] != null
                ? Menu.fromJson(json["menus"])
                : null
            : null,
        customerReviews: json.containsKey('customerReviews')
            ? json['customerReviews'] != null
                ? List<CustomerReview>.from(json["customerReviews"]
                    .map((x) => CustomerReview.fromJson(x)))
                : null
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "pictureId": pictureId,
        "city": city,
        "rating": rating,
        "address": address,
        "categories": categories != null
            ? List<dynamic>.from(categories!.map((x) => x.toJson()))
            : null,
        "menus": menus?.toJson(),
        "customerReviews": customerReviews != null
            ? List<dynamic>.from(customerReviews!.map((x) => x.toJson()))
            : null,
      };
}

class Category {
  final String name;

  Category({
    required this.name,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}

class Menu {
  final List<MenuItems> foods;
  final List<MenuItems> drinks;

  Menu({
    required this.foods,
    required this.drinks,
  });

  factory Menu.fromJson(Map<String, dynamic> json) => Menu(
        foods: List<MenuItems>.from(
            json["foods"].map((x) => MenuItems.fromJson(x))),
        drinks: List<MenuItems>.from(
            json["drinks"].map((x) => MenuItems.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "foods": List<dynamic>.from(foods.map((x) => x.toJson())),
        "drinks": List<dynamic>.from(drinks.map((x) => x.toJson())),
      };
}

class MenuItems {
  final String name;

  MenuItems({
    required this.name,
  });

  factory MenuItems.fromJson(Map<String, dynamic> json) => MenuItems(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}

class CustomerReview {
  final String name;
  final String review;
  final DateTime date;

  CustomerReview({
    required this.name,
    required this.review,
    required this.date,
  });

  factory CustomerReview.fromJson(Map<String, dynamic> json) => CustomerReview(
        name: json["name"],
        review: json["review"],
        date: dateTimeHelper.convertStringToDateTime(json["date"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "review": review,
        "date": dateTimeHelper.convertDateTimeToString(date),
      };
}

class CustomerAddReview {
  final String id;
  final String name;
  final String review;

  CustomerAddReview({
    required this.id,
    required this.name,
    required this.review,
  });

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "review": review,
      };
}

class CustomerGetReviews {
  final bool error;
  final String message;
  final List<CustomerReview> customerReviews;

  CustomerGetReviews({
    required this.error,
    required this.message,
    required this.customerReviews,
  });

  factory CustomerGetReviews.fromJson(Map<String, dynamic> json) =>
      CustomerGetReviews(
        error: json["error"],
        message: json["message"],
        customerReviews: List<CustomerReview>.from(
            json["customerReviews"].map((x) => CustomerReview.fromJson(x))),
      );
}
