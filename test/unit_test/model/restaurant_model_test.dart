import 'package:flutter_test/flutter_test.dart';
import 'package:deliceat/data/model/restaurant.dart';
import 'package:deliceat/utils/date_time_helper.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  DateTimeHelper dateTimeHelper = DateTimeHelper();

  group('Restaurant Model Test', () {
    late Map<String, dynamic> jsonRestaurantList;
    late RestaurantList restaurantList;
    late Map<String, dynamic> jsonRestaurant;
    late Restaurant restaurant;

    setUp(() {
      // Arrange
      jsonRestaurantList = {
        "error": false,
        "message": "success",
        "count": 2,
        "restaurants": [
          {
            "id": "rqdv5juczeskfw1e867",
            "name": "Melting Pot",
            "description":
                "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet.",
            "pictureId": "14",
            "city": "Medan",
            "rating": 4.2,
          },
          {
            "id": "rqdv5juczeskfw1e867",
            "name": "Melting Pot",
            "description":
                "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet.",
            "pictureId": "14",
            "city": "Medan",
            "rating": 4.2,
          },
        ]
      };

      restaurantList = RestaurantList(
          error: false,
          message: "success",
          count: 2,
          restaurant: [
            Restaurant(
              id: 'rqdv5juczeskfw1e867',
              name: 'Melting Pot',
              description:
                  'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet.',
              pictureId: '14',
              city: 'Medan',
              rating: 4.2,
              address: "Jln. Pandeglang no 19",
              categories: [
                Category(name: "Italia"),
                Category(name: "Modern"),
              ],
              menus: Menu(
                foods: [
                  MenuItems(name: "Paket rosemary"),
                  MenuItems(name: "Toastie salmon"),
                ],
                drinks: [
                  MenuItems(name: "Es krim"),
                  MenuItems(name: "Sirup"),
                ],
              ),
              customerReviews: [
                CustomerReview(
                    name: "Ahmad",
                    review: "Tidak rekomendasi untuk pelajar!",
                    date: dateTimeHelper
                        .convertStringToDateTime("13 November 2019")),
              ],
            ),
            Restaurant(
              id: 'rqdv5juczeskfw1e867',
              name: 'Melting Pot',
              description:
                  'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet.',
              pictureId: '14',
              city: 'Medan',
              rating: 4.2,
              address: "Jln. Pandeglang no 19",
              categories: [
                Category(name: "Italia"),
                Category(name: "Modern"),
              ],
              menus: Menu(
                foods: [
                  MenuItems(name: "Paket rosemary"),
                  MenuItems(name: "Toastie salmon"),
                ],
                drinks: [
                  MenuItems(name: "Es krim"),
                  MenuItems(name: "Sirup"),
                ],
              ),
              customerReviews: [
                CustomerReview(
                    name: "Ahmad",
                    review: "Tidak rekomendasi untuk pelajar!",
                    date: dateTimeHelper
                        .convertStringToDateTime("13 November 2019")),
              ],
            )
          ]);

      jsonRestaurant = {
        "error": false,
        "message": "success",
        "restaurant": {
          "id": "rqdv5juczeskfw1e867",
          "name": "Melting Pot",
          "description":
              "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet.",
          "city": "Medan",
          "address": "Jln. Pandeglang no 19",
          "pictureId": "14",
          "categories": [
            {"name": "Italia"},
            {"name": "Modern"}
          ],
          "menus": {
            "foods": [
              {"name": "Paket rosemary"},
              {"name": "Toastie salmon"}
            ],
            "drinks": [
              {"name": "Es krim"},
              {"name": "Sirup"}
            ]
          },
          "rating": 4.2,
          "customerReviews": [
            {
              "name": "Ahmad",
              "review": "Tidak rekomendasi untuk pelajar!",
              "date": "13 November 2019"
            }
          ]
        }
      };

      restaurant = Restaurant(
        id: 'rqdv5juczeskfw1e867',
        name: 'Melting Pot',
        description:
            'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet.',
        pictureId: '14',
        city: 'Medan',
        rating: 4.2,
        address: "Jln. Pandeglang no 19",
        categories: [
          Category(name: "Italia"),
          Category(name: "Modern"),
        ],
        menus: Menu(
          foods: [
            MenuItems(name: "Paket rosemary"),
            MenuItems(name: "Toastie salmon"),
          ],
          drinks: [
            MenuItems(name: "Es krim"),
            MenuItems(name: "Sirup"),
          ],
        ),
        customerReviews: [
          CustomerReview(
              name: "Ahmad",
              review: "Tidak rekomendasi untuk pelajar!",
              date: dateTimeHelper.convertStringToDateTime("13 November 2019")),
        ],
      );
    });

    test('RestaurantList.fromJson should correctly parse JSON', () {
      // Act
      RestaurantList result = RestaurantList.fromJson(jsonRestaurantList);

      // Assert
      expect(result.error, false);
      expect(result.message, "success");
      expect(result.count, 2);
      expect(result.restaurant.runtimeType, equals(List<Restaurant>));
      expect(result.restaurant.length, 2);
    });

    test('RestaurantList.toJson should correctly convert to JSON', () {
      // Act
      Map<String, dynamic> result = restaurantList.toJson();

      // Assert
      expect(result["error"], false);
      expect(result["message"], "success");
      expect(result["count"], 2);
      expect(result["restaurants"].length, 2);
    });

    test('Restaurant.fromJson should correctly parse JSON', () {
      // Act
      Restaurant result = Restaurant.fromJson(jsonRestaurant["restaurant"]);

      // Assert
      expect(result.id, "rqdv5juczeskfw1e867");
      expect(result.name, "Melting Pot");
      expect(result.description,
          "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet.");
      expect(result.pictureId, "14");
      expect(result.city, "Medan");
      expect(result.rating, 4.2);
      expect(result.address, "Jln. Pandeglang no 19");

      // Categories
      expect(result.categories!.length, 2);
      expect(result.categories![0].name, "Italia");
      expect(result.categories![1].name, "Modern");

      // Menus
      expect(result.menus!.foods.length, 2);
      expect(result.menus!.foods[0].name, "Paket rosemary");
      expect(result.menus!.foods[1].name, "Toastie salmon");
      expect(result.menus!.drinks.length, 2);
      expect(result.menus!.drinks[0].name, "Es krim");
      expect(result.menus!.drinks[1].name, "Sirup");

      // Customer Reviews
      expect(result.customerReviews!.length, 1);
      expect(result.customerReviews![0].name, "Ahmad");
      expect(result.customerReviews![0].review,
          "Tidak rekomendasi untuk pelajar!");
      expect(result.customerReviews![0].date,
          dateTimeHelper.convertStringToDateTime("13 November 2019"));
    });

    test('toJson should correctly convert to JSON', () {
      // Act
      Map<String, dynamic> result = restaurant.toJson();

      // Assert
      expect(result["id"], "rqdv5juczeskfw1e867");
      expect(result["name"], "Melting Pot");
      expect(result["description"],
          "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet.");
      expect(result["pictureId"], "14");
      expect(result["city"], "Medan");
      expect(result["rating"], 4.2);
      expect(result["address"], "Jln. Pandeglang no 19");

      // Categories
      expect(result["categories"].length, 2);
      expect(result["categories"][0]["name"], "Italia");
      expect(result["categories"][1]["name"], "Modern");

      // Menus
      expect(result["menus"]["foods"].length, 2);
      expect(result["menus"]["foods"][0]["name"], "Paket rosemary");
      expect(result["menus"]["foods"][1]["name"], "Toastie salmon");
      expect(result["menus"]["drinks"].length, 2);
      expect(result["menus"]["drinks"][0]["name"], "Es krim");
      expect(result["menus"]["drinks"][1]["name"], "Sirup");

      // Customer Reviews
      expect(result["customerReviews"].length, 1);
      expect(result["customerReviews"][0]["name"], "Ahmad");
      expect(result["customerReviews"][0]["review"],
          "Tidak rekomendasi untuk pelajar!");
      expect(result["customerReviews"][0]["date"], "13 November 2019");
    });
  });
}
