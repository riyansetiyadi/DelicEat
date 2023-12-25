import 'package:deliceat/common/styles.dart';
import 'package:deliceat/data/model/restaurant.dart';
import 'package:flutter/material.dart';

class RestaurantDetailPage extends StatelessWidget {
  static const routeName = '/restaurant_detail';

  final Restaurant restaurant;

  const RestaurantDetailPage({Key? key, required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder : (context, isScrolled) {
          return [
            SliverAppBar(
              leading: IconButton(
                icon: ClipOval(
                  child: Container(
                    color: secondaryColor,
                    padding: const EdgeInsets.all(8.0),
                    child: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              backgroundColor: secondaryColor,
              expandedHeight: 200,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  restaurant.name,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                centerTitle: true,
                background: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    Image.network(
                      restaurant.pictureId,
                      height: double.infinity,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
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
                    child: ListTile(
                      leading: const Icon(
                        Icons.location_on_outlined,
                        color: secondaryColor,
                      ),
                      title: Text(
                        restaurant.city,
                        style: Theme.of(context).textTheme.labelLarge
                      ),
                      horizontalTitleGap: 0,
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      trailing: const Icon(
                        Icons.star_rate_rounded,
                        color: Colors.yellowAccent,
                      ),
                      title: Text(
                        restaurant.rating.toString(),
                        textAlign: TextAlign.right,
                        style: Theme.of(context).textTheme.labelLarge
                      ),
                      horizontalTitleGap: 0,
                    ),
                  ),
                ],
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
              _buildMenus(context, 'Foods', restaurant.menus.foods),
              const Divider(color: Colors.grey),
              _buildMenus(context, 'Drinks', restaurant.menus.drinks),
            ],
          ),
        ),
      ),
    );
  }

  Column _buildMenus(BuildContext context, String title, List menu) {
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
                const SizedBox(height: 20,),
                Column(
                  children: 
                    menu.map((food) => 
                      Container(
                        padding: const EdgeInsets.all(10.0),
                        margin: const EdgeInsetsDirectional.symmetric(vertical: 5),
                        decoration: BoxDecoration(
                          color: secondaryColor,
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Text(
                          food.name,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      )
                    ).toList()
                ),
                const SizedBox(height: 20,),
              ],
            );
  }
}