import 'dart:convert';

class Restaurant {
    final String id;
    final String name;
    final String description;
    final String pictureId;
    final String city;
    final double rating;
    final Menus menus;

    Restaurant({
        required this.id,
        required this.name,
        required this.description,
        required this.pictureId,
        required this.city,
        required this.rating,
        required this.menus,
    });

    factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        pictureId: json["pictureId"],
        city: json["city"],
        rating: json["rating"]?.toDouble(),
        menus: Menus.fromJson(json["menus"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "pictureId": pictureId,
        "city": city,
        "rating": rating,
        "menus": menus.toJson(),
    };
}

class Menus {
    final List<MenuItems> foods;
    final List<MenuItems> drinks;

    Menus({
        required this.foods,
        required this.drinks,
    });

    factory Menus.fromJson(Map<String, dynamic> json) => Menus(
        foods: List<MenuItems>.from(json["foods"].map((x) => MenuItems.fromJson(x))),
        drinks: List<MenuItems>.from(json["drinks"].map((x) => MenuItems.fromJson(x))),
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

List<Restaurant> parseRestaurants(String? json) {
  if (json == null) {
    return [];
  }

  final List parsed = jsonDecode(json)['restaurants'];
  return parsed.map((json) => Restaurant.fromJson(json)).toList();
}