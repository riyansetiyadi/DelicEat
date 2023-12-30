import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:deliceat/common/navigation.dart';
import 'package:deliceat/common/styles.dart';
import 'package:deliceat/data/model/restaurant.dart';
import 'package:deliceat/provider/database_provider.dart';
import 'package:deliceat/ui/restaurant_detail_page.dart';
import 'package:deliceat/widgets/platform_widget.dart';

class RestaurantListView extends StatelessWidget {
  const RestaurantListView({
    super.key,
    required this.restaurantList,
  });

  final RestaurantList? restaurantList;

  @override
  Widget build(BuildContext context) {
    if (restaurantList != null) {
      return PlatformWidget(
        androidBuilder: _buildAndroid,
        iosBuilder: _buildIos,
      );
    }
    return Center(
      child: Text(
        'No data available.',
        style: Theme.of(context).textTheme.bodyMedium,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return Scrollbar(
      child: _buildListViewRestaurant(),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoScrollbar(
      child: _buildListViewRestaurant(),
    );
  }

  ListView _buildListViewRestaurant() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount:
          restaurantList?.founded ?? restaurantList?.restaurant.length ?? 0,
      itemBuilder: (context, index) {
        var restaurant = restaurantList!.restaurant[index];
        return Consumer<DatabaseProvider>(builder: (context, provider, child) {
          return FutureBuilder<bool>(
              future: provider.isFavorite(restaurant.id),
              builder: (context, snapshot) {
                var isFavorite = snapshot.data ?? false;
                return Card(
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.grey, width: 0.5),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: defaultTargetPlatform == TargetPlatform.iOS
                      ? _buildListTileIos(
                          restaurant, context, isFavorite, provider)
                      : _buildListTileAndroid(
                          restaurant, context, isFavorite, provider),
                );
              });
        });
      },
    );
  }

  CupertinoListTile _buildListTileIos(Restaurant restaurant,
      BuildContext context, bool isFavorite, DatabaseProvider provider) {
    return CupertinoListTile(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
      ),
      leadingSize: 100,
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(16.0),
        child: SizedBox(
          width: 100,
          child: Hero(
              tag: restaurant.pictureId,
              child: Image.network(
                'https://restaurant-api.dicoding.dev/images/small/${restaurant.pictureId}',
                fit: BoxFit.cover,
              )),
        ),
      ),
      title: Text(
        restaurant.name,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      subtitle: Column(
        children: [
          Row(children: [
            const Icon(
              CupertinoIcons.location,
              color: secondaryColor,
              size: 15,
            ),
            Text(restaurant.city, style: Theme.of(context).textTheme.bodySmall),
          ]),
          Row(children: [
            const Icon(
              CupertinoIcons.star_fill,
              color: Colors.yellowAccent,
              size: 15,
            ),
            Text(restaurant.rating.toString(),
                style: Theme.of(context).textTheme.bodySmall),
          ]),
        ],
      ),
      trailing: isFavorite
          ? IconButton(
              icon: const Icon(CupertinoIcons.heart_fill),
              color: Colors.redAccent,
              onPressed: () {
                provider.removeFavorite(restaurant.id).then((message) {
                  final snackBar = SnackBar(
                    content: Text(
                      message,
                    ),
                    duration: const Duration(seconds: 3),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                });
              })
          : IconButton(
              icon: const Icon(CupertinoIcons.heart),
              color: Colors.grey,
              onPressed: () {
                provider.addFavorites(restaurant).then((message) {
                  final snackBar = SnackBar(
                    content: Text(
                      message,
                    ),
                    duration: const Duration(seconds: 3),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                });
              },
            ),
      onTap: () => Navigation.intentWithData(
          RestaurantDetailPage.routeName, restaurant.id),
    );
  }

  ListTile _buildListTileAndroid(Restaurant restaurant, BuildContext context,
      bool isFavorite, DatabaseProvider provider) {
    return ListTile(
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(16.0),
        child: SizedBox(
          width: 100,
          child: Hero(
              tag: restaurant.pictureId,
              child: Image.network(
                'https://restaurant-api.dicoding.dev/images/small/${restaurant.pictureId}',
                fit: BoxFit.cover,
              )),
        ),
      ),
      title: Text(
        restaurant.name,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      subtitle: Column(
        children: [
          Row(children: [
            const Icon(
              Icons.location_on_outlined,
              color: secondaryColor,
              size: 15,
            ),
            Text(restaurant.city, style: Theme.of(context).textTheme.bodySmall),
          ]),
          Row(children: [
            const Icon(
              Icons.star_rate_rounded,
              color: Colors.yellowAccent,
              size: 15,
            ),
            Text(restaurant.rating.toString(),
                style: Theme.of(context).textTheme.bodySmall),
          ]),
        ],
      ),
      trailing: isFavorite
          ? IconButton(
              icon: const Icon(Icons.favorite),
              color: Colors.redAccent,
              onPressed: () {
                provider.removeFavorite(restaurant.id).then((message) {
                  final snackBar = SnackBar(
                    content: Text(
                      message,
                    ),
                    duration: const Duration(seconds: 3),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                });
              },
            )
          : IconButton(
              icon: const Icon(Icons.favorite_border_rounded),
              color: Colors.grey,
              onPressed: () {
                provider.addFavorites(restaurant).then((message) {
                  final snackBar = SnackBar(
                    content: Text(
                      message,
                    ),
                    duration: const Duration(seconds: 3),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                });
              },
            ),
      onTap: () => Navigation.intentWithData(
          RestaurantDetailPage.routeName, restaurant.id),
    );
  }
}
