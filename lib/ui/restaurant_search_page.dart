import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_submission_dicoding/common/styles.dart';
import 'package:restaurant_app_submission_dicoding/widgets/custom_cupertino_search_text_field_widget.dart';
import 'package:restaurant_app_submission_dicoding/widgets/handle_error_refresh_widget.dart';
import 'package:restaurant_app_submission_dicoding/widgets/restaurant_list_view_widget.dart';
import 'package:restaurant_app_submission_dicoding/provider/search_restaurant_provider.dart';
import 'package:restaurant_app_submission_dicoding/widgets/platform_widget.dart';

class RestaurantSearchPage extends StatefulWidget {
  static const routeName = '/restaurant_search_page';

  const RestaurantSearchPage({super.key});

  @override
  State<RestaurantSearchPage> createState() => _RestaurantSearchPageState();
}

class _RestaurantSearchPageState extends State<RestaurantSearchPage> {
  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }

  Widget _titleAppBar(BuildContext context) {
    return Text(
      'Search Restaurant',
      style: Theme.of(context).textTheme.headlineSmall,
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _titleAppBar(context),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () {
            Provider.of<SearchRestaurantProvider>(context, listen: false)
                .resetState();
            Navigator.pop(context);
          },
        ),
      ),
      body: _buildList(context),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back),
          onPressed: () {
            Provider.of<SearchRestaurantProvider>(context, listen: false)
                .resetState();
            Navigator.pop(context);
          },
        ),
        middle: _titleAppBar(context),
        transitionBetweenRoutes: false,
      ),
      child: _buildList(context),
    );
  }

  _buildList(BuildContext context) {
    return Column(
      children: [
        Hero(
          tag: 'search',
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Material(
              child: defaultTargetPlatform == TargetPlatform.iOS
                  ? CustomCupertinoSearchTextField(
                      onChanged: (query) async {
                        await Provider.of<SearchRestaurantProvider>(context,
                                listen: false)
                            .refreshRestaurant(query);
                      },
                      cursorColor: secondaryColor,
                    )
                  : TextField(
                      onChanged: (query) async {
                        await Provider.of<SearchRestaurantProvider>(context,
                                listen: false)
                            .refreshRestaurant(query);
                      },
                      showCursor: true,
                      cursorColor: secondaryColor,
                      decoration: InputDecoration(
                        labelText: 'Search',
                        suffixIcon: Icon(
                          defaultTargetPlatform == TargetPlatform.iOS
                              ? CupertinoIcons.search
                              : Icons.search,
                          color: secondaryColor,
                        ),
                        labelStyle: const TextStyle(color: Colors.black),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: secondaryColor,
                            width: 2.0,
                          ),
                        ),
                        focusedBorder: const OutlineInputBorder(
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
        Expanded(child:
            Consumer<SearchRestaurantProvider>(builder: (context, state, _) {
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
            return RestaurantListView(
              restaurantList: state.restaurantList,
            );
          } else if (state.state == ResultState.noData) {
            return const ErrorRefresh(errorTitle: 'No data available.');
          } else if (state.state == ResultState.error) {
            return const ErrorRefresh(
                errorTitle:
                    'Data retrieval failed. Please check your connection.');
          } else if (state.state == ResultState.init) {
            return const ErrorRefresh(
                errorTitle:
                    "Search for your favorite restaurants and find exactly what you're looking for");
          } else {
            return const ErrorRefresh(
                errorTitle: 'Error retrieving data. Please try again later.');
          }
        }))
      ],
    );
  }
}
