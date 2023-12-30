import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:provider/provider.dart';
import 'package:deliceat/data/model/restaurant.dart';
import 'package:deliceat/provider/database_provider.dart';
import 'package:deliceat/widgets/restaurant_list_view_widget.dart';

import '../mock/database_helper.mocks.dart';

RestaurantList restaurantList =
    RestaurantList(error: false, message: "success", count: 2, restaurant: [
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
          date: dateTimeHelper.convertStringToDateTime("13 November 2019")),
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
          date: dateTimeHelper.convertStringToDateTime("13 November 2019")),
    ],
  )
]);

MockDatabaseHelper mockDatabaseHelper = MockDatabaseHelper();

Widget createRestaurantListViewWidget() => ChangeNotifierProvider(
    create: (_) => DatabaseProvider(databaseHelper: mockDatabaseHelper),
    child:
        MaterialApp(home: Scaffold(body: RestaurantListView(restaurantList: restaurantList))));

void main() {
  group("Restaurant List View Widget Tes", () {
    testWidgets("Testing if ListView shows up", (widgetTester) async {
      when(mockDatabaseHelper.getFavorites())
          .thenAnswer((_) => Future.value([]));
      await mockNetworkImagesFor(() => widgetTester.pumpWidget(createRestaurantListViewWidget()));
      expect(find.byType(ListView), findsOneWidget);
    });
  });
}
