import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_submission_dicoding/common/styles.dart';
import 'package:restaurant_app_submission_dicoding/data/model/restaurant.dart';
import 'package:restaurant_app_submission_dicoding/provider/database_provider.dart';
import 'package:restaurant_app_submission_dicoding/utils/result_state.dart';
import 'package:restaurant_app_submission_dicoding/widgets/handle_error_refresh_widget.dart';
import 'package:restaurant_app_submission_dicoding/widgets/platform_widget.dart';
import 'package:restaurant_app_submission_dicoding/widgets/restaurant_list_view_widget.dart';

class FavoritesPage extends StatelessWidget {
  static const String favoritesTitle = 'Favorites';

  const FavoritesPage({Key? key}) : super(key: key);

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(favoritesTitle),
        automaticallyImplyLeading: false,
      ),
      body: _buildList(),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text(favoritesTitle),
      ),
      child: _buildList(),
    );
  }

  Widget _buildList() {
    return Consumer<DatabaseProvider>(
      builder: (context, state, child) {
              if (state.state == ResultState.loading) {
                return Center(
                    child: defaultTargetPlatform == TargetPlatform.iOS
                        ? const CupertinoActivityIndicator(
                            radius: 20.0,
                          )
                        : const CircularProgressIndicator(
                            color: secondaryColor,
                          ));
              } else if (state.state == ResultState.hasData) {
                return RefreshIndicator(
                  onRefresh: () async {
                    await state.refreshRestaurant();
                  },
                  color: secondaryColor,
                  child: RestaurantListView(
                    restaurantList: RestaurantList(error: false, restaurant: state.favorites),
                  ),
                );
              } else if (state.state == ResultState.noData) {
                return const ErrorRefresh(
                  errorTitle: 'No data available.',
                );
              } else if (state.state == ResultState.error) {
                return ErrorRefresh(
                  errorTitle:
                      'Data retrieval failed. Please check your connection.',
                  refreshTitle: 'Refresh',
                  onPressed: () async {
                    await state.refreshRestaurant();
                  },
                );
              } else {
                return ErrorRefresh(
                  errorTitle: 'Error retrieving data. Please try again later.',
                  refreshTitle: 'Refresh',
                  onPressed: () async {
                    await state.refreshRestaurant();
                  },
                );
              }
      },
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
