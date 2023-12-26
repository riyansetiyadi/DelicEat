import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app_submission_dicoding/common/navigation.dart';
import 'package:restaurant_app_submission_dicoding/common/styles.dart';
import 'package:restaurant_app_submission_dicoding/data/model/restaurant.dart';
import 'package:restaurant_app_submission_dicoding/ui/restaurant_detail_page.dart';
import 'package:restaurant_app_submission_dicoding/widgets/platform_widget.dart';

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
      itemCount: restaurantList!.restaurant.length,
      itemBuilder: (context, index) {
        var restaurant = restaurantList!.restaurant[index];
        return Card(
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: Colors.grey, width: 0.5),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: defaultTargetPlatform == TargetPlatform.iOS
              ? _buildListTileIos(restaurant, context)
              : _buildListTileAndroid(restaurant, context),
        );
      },
    );
  }

  CupertinoListTile _buildListTileIos(
      Restaurant restaurant, BuildContext context) {
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
      trailing: const Icon(
        CupertinoIcons.forward,
      ),
      onTap: () {
        Navigator.pushNamed(context, RestaurantDetailPage.routeName,
            arguments: restaurant.id);
      },
    );
  }

  ListTile _buildListTileAndroid(Restaurant restaurant, BuildContext context) {
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
      trailing: const Icon(
        Icons.arrow_forward,
      ),
      onTap: () => Navigation.intentWithData(
                    RestaurantDetailPage.routeName, restaurant.id),
      // {
      //   Navigator.pushNamed(context, RestaurantDetailPage.routeName,
      //       arguments: restaurant.id);
      // },
    );
  }
}
