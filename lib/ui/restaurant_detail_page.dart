import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:deliceat/common/styles.dart';
import 'package:deliceat/provider/database_provider.dart';
import 'package:deliceat/ui/home_page.dart';
import 'package:deliceat/utils/result_state.dart';
import 'package:deliceat/widgets/handle_error_back_widget.dart';
import 'package:deliceat/data/model/restaurant.dart';
import 'package:flutter/material.dart';
import 'package:deliceat/provider/detail_restaurant_provider.dart';
import 'package:deliceat/provider/review_restaurant_provider.dart';
import 'package:deliceat/utils/capitalization_helper.dart';
import 'package:deliceat/utils/date_time_helper.dart';
import 'package:deliceat/widgets/platform_widget.dart';

class RestaurantDetailPage extends StatefulWidget {
  static const routeName = '/restaurant_detail';

  const RestaurantDetailPage({
    Key? key,
  }) : super(key: key);

  @override
  State<RestaurantDetailPage> createState() => _RestaurantDetailPageState();
}

class _RestaurantDetailPageState extends State<RestaurantDetailPage> {
  final TextEditingController _textNameController = TextEditingController();
  final TextEditingController _textReviewController = TextEditingController();
  String _idRestaurant = '';

  @override
  void dispose() {
    _textNameController.dispose();
    _textReviewController.dispose();
    super.dispose();
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      body: _buildConsumerDetailRestaurant(),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      child: _buildConsumerDetailRestaurant(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }

  Consumer<DetailRestaurantProvider> _buildConsumerDetailRestaurant() {
    return Consumer<DetailRestaurantProvider>(
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
          _idRestaurant = state.restaurantDetail.restaurant.id;
          return _buildDetailRestaurant(
              context, state.restaurantDetail.restaurant);
        } else if (state.state == ResultState.noData) {
          return const ErrorBack(
              errorTitle: 'No data available.', backTitle: 'Back');
        } else if (state.state == ResultState.error) {
          return const ErrorBack(
              errorTitle:
                  'Restaurant retrieval failed. Please check your connection.',
              backTitle: 'Back');
        } else {
          return const ErrorBack(
              errorTitle:
                  'Error retrieving restaurant. Please try again later.',
              backTitle: 'Back');
        }
      },
    );
  }

  Widget _buildDetailRestaurant(BuildContext context, Restaurant restaurant) {
    return Stack(
      children: [
        NestedScrollView(
          headerSliverBuilder: (context, isScrolled) {
            return [
              SliverAppBar(
                leading: IconButton(
                  icon: ClipOval(
                    child: Container(
                      color: secondaryColor,
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        defaultTargetPlatform == TargetPlatform.iOS
                            ? CupertinoIcons.back
                            : Icons.arrow_back_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                  onPressed: () {
                    Provider.of<ReviewRestaurantProvider>(context,
                            listen: false)
                        .resetState();
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    } else {
                      Navigator.pushNamed(context, HomePage.routeName);
                    }
                  },
                ),
                backgroundColor: secondaryColor,
                expandedHeight: 200,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  title: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            restaurant.name,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(color: Colors.white),
                          ),
                        ],
                      ),
                      if (restaurant.categories != null)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: restaurant.categories!
                              .map((categorie) => Container(
                                    padding: const EdgeInsets.all(3.0),
                                    margin:
                                        const EdgeInsetsDirectional.symmetric(
                                            horizontal: 5),
                                    decoration: BoxDecoration(
                                      color: secondaryColor,
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                    child: Text(
                                      categorie.name,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall
                                          ?.copyWith(color: Colors.white),
                                    ),
                                  ))
                              .toList(),
                        )
                    ],
                  ),
                  centerTitle: true,
                  titlePadding:
                      const EdgeInsetsDirectional.only(start: 0, bottom: 16),
                  background: Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      Hero(
                          tag: restaurant.pictureId,
                          child: Image.network(
                            'https://restaurant-api.dicoding.dev/images/small/${restaurant.pictureId}',
                            errorBuilder: (_, __, ___) {
                              return const Icon(Icons.error_outline);
                            },
                            height: double.infinity,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          )),
                      Container(
                        color: Colors.black.withOpacity(0.3),
                      ),
                    ],
                  ),
                ),
              ),
            ];
          },
          body: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                        child: defaultTargetPlatform == TargetPlatform.iOS
                            ? CupertinoListTile(
                                leading: const Icon(
                                  CupertinoIcons.location_solid,
                                  color: Colors.yellowAccent,
                                ),
                                title: Text(restaurant.city,
                                    style:
                                        Theme.of(context).textTheme.labelLarge),
                                leadingToTitle: 0,
                              )
                            : ListTile(
                                leading: const Icon(
                                  Icons.location_on,
                                  color: Colors.yellowAccent,
                                ),
                                title: Text(restaurant.city,
                                    style:
                                        Theme.of(context).textTheme.labelLarge),
                                horizontalTitleGap: 0,
                              )),
                    Expanded(child: Consumer<DatabaseProvider>(
                        builder: (context, provider, child) {
                      return FutureBuilder<bool>(
                          future: provider.isFavorite(restaurant.id),
                          builder: (context, snapshot) {
                            var isFavorite = snapshot.data ?? false;
                            if (isFavorite) {
                              return IconButton(
                                icon: Icon(Platform.isIOS
                                    ? Icons.favorite
                                    : CupertinoIcons.heart_fill),
                                color: Colors.redAccent,
                                onPressed: () {
                                  provider
                                      .removeFavorite(restaurant.id)
                                      .then((message) {
                                    final snackBar = SnackBar(
                                      content: Text(
                                        message,
                                      ),
                                      duration: const Duration(seconds: 3),
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  });
                                },
                              );
                            } else {
                              return IconButton(
                                icon: Icon(Platform.isIOS
                                    ? Icons.favorite_border_rounded
                                    : CupertinoIcons.heart),
                                color: Colors.grey,
                                onPressed: () {
                                  provider
                                      .addFavorites(restaurant)
                                      .then((message) {
                                    final snackBar = SnackBar(
                                      content: Text(
                                        message,
                                      ),
                                      duration: const Duration(seconds: 3),
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  });
                                },
                              );
                            }
                          });
                    })),
                    Expanded(
                      child: defaultTargetPlatform == TargetPlatform.iOS
                          ? CupertinoListTile(
                              trailing: const Icon(
                                CupertinoIcons.star_fill,
                                color: Colors.yellowAccent,
                              ),
                              title: Text(restaurant.rating.toString(),
                                  textAlign: TextAlign.right,
                                  style:
                                      Theme.of(context).textTheme.labelLarge),
                              leadingToTitle: 0,
                            )
                          : ListTile(
                              trailing: const Icon(
                                Icons.star_rate_rounded,
                                color: Colors.yellowAccent,
                              ),
                              title: Text(restaurant.rating.toString(),
                                  textAlign: TextAlign.right,
                                  style:
                                      Theme.of(context).textTheme.labelLarge),
                              horizontalTitleGap: 0,
                            ),
                    ),
                  ],
                ),
                Text(
                  restaurant.address ?? '-',
                ),
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Text(
                    restaurant.description,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                const Divider(color: Colors.grey),
                _buildMenus(context, 'Foods', restaurant.menus?.foods),
                const Divider(color: Colors.grey),
                _buildMenus(context, 'Drinks', restaurant.menus?.drinks),
                const SizedBox(
                  height: 150,
                )
              ],
            ),
          ),
        ),
        DraggableScrollableSheet(
          initialChildSize: 0.1,
          minChildSize: 0.1,
          maxChildSize: 0.8,
          snap: true,
          builder: (BuildContext context, ScrollController scrollController) {
            return Container(
              decoration: BoxDecoration(
                color: secondaryColor,
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(50.0)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 5,
                    blurRadius: 10,
                    offset: const Offset(0, -3),
                  ),
                ],
              ),
              child: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 175.0),
                      height: 3.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: primaryColor,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'People said',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(color: primaryColor),
                        ),
                        Consumer<ReviewRestaurantProvider>(
                          builder: (context, state, _) {
                            if (state.state == ResultState.init) {
                              return _buildCustomerReviewsLength(
                                  restaurant.customerReviews?.length, context);
                            } else if (state.state == ResultState.loading) {
                              return Container(
                                color: secondaryColor,
                                child: Center(
                                    child: defaultTargetPlatform ==
                                            TargetPlatform.iOS
                                        ? const CupertinoActivityIndicator(
                                            radius: 20.0,
                                          )
                                        : const CircularProgressIndicator(
                                            color: primaryColor,
                                          )),
                              );
                            } else if (state.state == ResultState.hasData) {
                              return _buildCustomerReviewsLength(
                                  state.customerReviews?.customerReviews.length,
                                  context);
                            } else if (state.state == ResultState.noData) {
                              return _buildCustomerReviewsLength(
                                  restaurant.customerReviews?.length, context);
                            } else if (state.state == ResultState.error) {
                              return _buildCustomerReviewsLength(
                                  restaurant.customerReviews?.length, context);
                            } else {
                              return _buildCustomerReviewsLength(
                                  restaurant.customerReviews?.length, context);
                            }
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: defaultTargetPlatform == TargetPlatform.iOS
                          ? CupertinoButton(
                              onPressed: () async {
                                _onPressAddReviewButton(context);
                              },
                              color: primaryColor,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10.0)),
                              child: Text(
                                'Add Review',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(color: secondaryColor),
                              ),
                            )
                          : ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              onPressed: () async {
                                _onPressAddReviewButton(context);
                              },
                              child: Text(
                                'Add Review',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(color: secondaryColor),
                              ),
                            ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Consumer<ReviewRestaurantProvider>(
                      builder: (context, state, _) {
                        if (state.state == ResultState.init) {
                          return _buildReviewsRestaurant(
                              restaurant.customerReviews);
                        } else if (state.state == ResultState.loading) {
                          return Container(
                            color: secondaryColor,
                            child: Center(
                                child:
                                    defaultTargetPlatform == TargetPlatform.iOS
                                        ? const CupertinoActivityIndicator(
                                            radius: 20.0,
                                          )
                                        : const CircularProgressIndicator(
                                            color: primaryColor,
                                          )),
                          );
                        } else if (state.state == ResultState.hasData) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            final snackBar = SnackBar(
                              backgroundColor: primaryColor,
                              content: Text(
                                state.message,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(color: secondaryColor),
                              ),
                              duration: const Duration(seconds: 3),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          });
                          return _buildReviewsRestaurant(
                              state.customerReviews!.customerReviews);
                        } else if (state.state == ResultState.noData) {
                          return _buildReviewsRestaurant(
                              restaurant.customerReviews);
                        } else if (state.state == ResultState.error) {
                          return _buildReviewsRestaurant(
                              restaurant.customerReviews);
                        } else {
                          return _buildReviewsRestaurant(
                              restaurant.customerReviews);
                        }
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Text _buildCustomerReviewsLength(int? reviewsLength, BuildContext context) {
    return Text(
      reviewsLength != null ? reviewsLength.toString() : '0',
      style:
          Theme.of(context).textTheme.titleSmall?.copyWith(color: primaryColor),
    );
  }

  void _onPressAddReviewButton(BuildContext context) {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      _showReviewDialogIos(context);
    } else {
      _showReviewDialogAndroid(context);
    }
  }

  Future<String?> _showReviewDialogIos(BuildContext context) async {
    return showCupertinoModalPopup<String>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('Leave a Review'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 16.0),
              CupertinoTextField(
                controller: _textNameController,
                placeholder: 'Your Name',
                cursorColor: Colors.black,
                clearButtonMode: OverlayVisibilityMode.editing,
              ),
              const SizedBox(height: 16.0),
              CupertinoTextField(
                controller: _textReviewController,
                placeholder: 'Your Review',
                cursorColor: Colors.black,
                maxLines: 4,
                clearButtonMode: OverlayVisibilityMode.editing,
              )
            ],
          ),
        ),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            onPressed: () {
              _textNameController.clear();
              _textReviewController.clear();
              Navigator.of(context).pop();
            },
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.black),
            ),
          ),
          CupertinoDialogAction(
            onPressed: () {
              Provider.of<ReviewRestaurantProvider>(context, listen: false)
                  .addReviews(
                      _idRestaurant,
                      CapitalizationHelper()
                          .toTitleCase(_textNameController.text),
                      CapitalizationHelper()
                          .toSentenceCase(_textReviewController.text));

              _textNameController.clear();
              _textReviewController.clear();
              Navigator.pop(context);
            },
            child: const Text(
              'Submit',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  Future<String?> _showReviewDialogAndroid(BuildContext context) async {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Leave a Review'),
          content: Padding(
            padding: const EdgeInsets.only(top: 3.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    controller: _textNameController,
                    showCursor: true,
                    cursorColor: secondaryColor,
                    textCapitalization: TextCapitalization.words,
                    decoration: const InputDecoration(
                      labelText: 'Your Name',
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: secondaryColor,
                          width: 2.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: secondaryColor,
                          width: 2.0,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: _textReviewController,
                    maxLines: null,
                    minLines: 4,
                    keyboardType: TextInputType.text,
                    showCursor: true,
                    cursorColor: secondaryColor,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: const InputDecoration(
                      labelText: 'Your Review',
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: secondaryColor,
                          width: 2.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: secondaryColor,
                          width: 2.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                _textNameController.clear();
                _textReviewController.clear();
                Navigator.of(context).pop();
              },
              child: const Text(
                'Cancel',
                style: TextStyle(color: secondaryColor),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Provider.of<ReviewRestaurantProvider>(context, listen: false)
                    .addReviews(
                        _idRestaurant,
                        CapitalizationHelper()
                            .toTitleCase(_textNameController.text),
                        CapitalizationHelper()
                            .toSentenceCase(_textReviewController.text));

                _textNameController.clear();
                _textReviewController.clear();

                Navigator.pop(context);
              },
              child: const Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildReviewsRestaurant(List<CustomerReview>? customerReviews) {
    DateTimeHelper dateTimeHelper = DateTimeHelper();

    if (customerReviews != null) {
      customerReviews.sort((a, b) => b.date.compareTo(a.date));
      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.60,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: customerReviews
                .map((review) => Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 40),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            CapitalizationHelper().toTitleCase(review.name),
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(color: primaryColor),
                          ),
                          Text(
                            dateTimeHelper.convertDateTimeToString(review.date),
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(color: primaryColor),
                          ),
                          Text(
                            CapitalizationHelper()
                                .toSentenceCase(review.review),
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(color: primaryColor),
                          ),
                        ],
                      ),
                    ))
                .toList(),
          ),
        ),
      );
    } else {
      return const Text('No reviews yet');
    }
  }

  Column _buildMenus(BuildContext context, String title, List? menu) {
    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: secondaryColor,
                width: 2.0,
              ),
            ),
          ),
          child: Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        menu != null
            ? SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                    children: menu
                        .map((food) => Container(
                              padding: const EdgeInsets.all(10.0),
                              margin: const EdgeInsetsDirectional.symmetric(
                                  vertical: 5, horizontal: 5),
                              decoration: BoxDecoration(
                                color: secondaryColor,
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: Text(
                                food.name,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(color: Colors.white),
                              ),
                            ))
                        .toList()),
              )
            : const Text('There is no menu yet'),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
