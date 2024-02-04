import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:deliceat/common/styles.dart';
import 'package:deliceat/utils/result_state.dart';
import 'package:deliceat/widgets/custom_cupertino_search_text_field_widget.dart';
import 'package:deliceat/widgets/handle_error_refresh_widget.dart';
import 'package:deliceat/widgets/restaurant_list_view_widget.dart';
import 'package:deliceat/provider/list_restaurant_provider.dart';
import 'package:deliceat/ui/restaurant_search_page.dart';
import 'package:deliceat/widgets/platform_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RestaurantListPage extends StatefulWidget {
  static const routeName = '/restaurant_list_page';

  const RestaurantListPage({Key? key}) : super(key: key);

  @override
  State<RestaurantListPage> createState() => _RestaurantListPageState();
}

class _RestaurantListPageState extends State<RestaurantListPage> {
  Widget _buildList(BuildContext context) {
    return Column(
      children: [
        Hero(
          tag: 'search',
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Material(
              child: defaultTargetPlatform == TargetPlatform.iOS
                  ? CustomCupertinoSearchTextField(
                      onTap: () async {
                        Navigator.pushNamed(
                            context, RestaurantSearchPage.routeName);
                      },
                      readOnly: true,
                    )
                  : TextField(
                      onTap: () async {
                        Navigator.pushNamed(
                            context, RestaurantSearchPage.routeName);
                      },
                      readOnly: true,
                      decoration: const InputDecoration(
                        labelText: 'Search',
                        suffixIcon: Icon(
                          Icons.search,
                          color: secondaryColor,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: secondaryColor,
                            width: 2.0,
                          ),
                        ),
                      ),
                    ),
            ),
          ),
        ),
        Expanded(
          child: Consumer<ListRestaurantProvider>(
            builder: (context, state, _) {
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
                    restaurantList: state.restaurantList,
                  ),
                );
              } else if (state.state == ResultState.noData) {
                return ErrorRefresh(
                  errorTitle: 'No data available.',
                  refreshTitle: 'Refresh',
                  onPressed: () async {
                    await state.refreshRestaurant();
                  },
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
          ),
        ),
      ],
    );
  }

  Widget _titleAppBar(BuildContext context) {
    return Text(
      'Deliceat',
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _titleAppBar(context),
        automaticallyImplyLeading: false,
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
