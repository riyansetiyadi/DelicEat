import 'package:restaurant_app_submission_dicoding/common/styles.dart';
import 'package:restaurant_app_submission_dicoding/data/model/restaurant.dart';
import 'package:restaurant_app_submission_dicoding/ui/restaurant_detail_page.dart';
import 'package:restaurant_app_submission_dicoding/widgets/platform_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RestaurantListPage extends StatefulWidget {
  static const routeName = '/restaurant_list_page';

  const RestaurantListPage({Key? key}) : super(key: key);

  @override
  State<RestaurantListPage> createState() => _RestaurantListPageState();
}

class _RestaurantListPageState extends State<RestaurantListPage> {
  late Future<String> searchData;
  TextEditingController searchController = TextEditingController();

    @override
  void initState() {
    super.initState();
    searchData = DefaultAssetBundle.of(context).loadString('assets/local_restaurant.json');
  }
  
  Widget _buildList(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: searchController,
            decoration: const InputDecoration(
              labelText: 'Cari...',
              suffixIcon: Icon(Icons.search),
            ),
            onChanged: (value) {
              setState(() {});
            },
          ),
        ),
        Expanded(
          child: FutureBuilder<String>(
            future: searchData,
            builder: (context, snapshot) {
              final List<Restaurant> restaurant = parseRestaurants(snapshot.data).where((restaurant) => restaurant.name.toLowerCase().contains(searchController.text.toLowerCase())).toList();
              return ListView.builder(
                itemCount: restaurant.length,
                itemBuilder: (context, index) {
                  return _buildRestaurantItem(context, restaurant[index]);
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildRestaurantItem(BuildContext context, Restaurant restaurant) {
    return Card(
      color: primaryColor,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.grey, width: 0.5),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        leading: Hero(
          tag: restaurant.pictureId,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16.0),
            child: SizedBox(
              width: 100,
              child: Image.network(
                restaurant.pictureId,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        title: Text(
          restaurant.name,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        subtitle: Column(
          children: [
            Row(
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  color: secondaryColor,
                  size: 15,
                ),
                Text(
                  restaurant.city,
                  style: Theme.of(context).textTheme.bodySmall
                ),
              ]
            ),
            Row(
              children: [
                const Icon(
                  Icons.star_rate_rounded,
                  color: Colors.yellowAccent,
                  size: 15,
                ),
                Text(
                  restaurant.rating.toString(),
                  style: Theme.of(context).textTheme.bodySmall
                ),
              ]
            ),
          ],
        ),
        trailing: const Icon(Icons.arrow_forward_ios_rounded),
        onTap: () {
          Navigator.pushNamed(context, RestaurantDetailPage.routeName,
              arguments: restaurant);
        },
      ),
    );
  }

  Widget _titleAppBar(BuildContext context) {
    return Text(
      'Restaurant App',
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _titleAppBar(context),
      ),
      body: _buildList(context),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: _titleAppBar(context),
        transitionBetweenRoutes: false,
      ),
      child: _buildList(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }
}
