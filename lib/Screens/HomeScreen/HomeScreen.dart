// ignore_for_file: file_names, prefer_const_constructors, sized_box_for_whitespace, must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:food_ecommerce_app/Bloc/ItemsBloc/Items_Bloc.dart';
import 'package:food_ecommerce_app/Bloc/ItemsBloc/Items_States_Events.dart';
import 'package:food_ecommerce_app/Widgets/AppBarWidget.dart';
import 'package:food_ecommerce_app/Widgets/AvailableItemWidget.dart';
import 'package:food_ecommerce_app/Widgets/CategoryItemWidget.dart';
import 'package:food_ecommerce_app/Widgets/Drawer/DrawerWidget.dart';
import 'package:food_ecommerce_app/Widgets/RandomCategoryItemWidget.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ItemsBloc itemsBloc = ItemsBloc();

  @override
  void initState() {
    super.initState();

    itemsBloc.add(FetchItems());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBarWidget(),
      ),
      drawer: DrawerWidget(),
      body: SafeArea(
        child: Container(
          height: context.height(),
          margin: const EdgeInsets.only(top: 10),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StatusWidget(),
                RandomCategoryItemWidget(),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'Categories',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: CategoryItemWidget(),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'Available Food',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: AvailableItemWidget(),
                ),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
                //   child: Text(
                //     'Favorite Food',
                //     style: TextStyle(
                //       fontSize: 24,
                //       fontWeight: FontWeight.bold,
                //     ),
                //   ),
                // ),
                // Container(
                //   height: MediaQuery.of(context).size.height * 0.35,
                //   child: ListView.builder(
                //     scrollDirection: Axis.horizontal,
                //     itemCount: products.length,
                //     itemBuilder: (BuildContext context, int index) {
                //       return FavoriteItemWidget(
                //         products: products,
                //         index: index,
                //       );
                //     },
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class StatusWidget extends StatefulWidget {
  const StatusWidget({super.key});

  @override
  State<StatusWidget> createState() => _StatusWidgetState();
}

class _StatusWidgetState extends State<StatusWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 6,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            child: CircleAvatar(
              radius: 40,
              backgroundImage: CachedNetworkImageProvider(
                'https://hips.hearstapps.com/hmg-prod/images/classic-cheese-pizza-recipe-2-64429a0cb408b.jpg?crop=0.8888888888888888xw:1xh;center,top&resize=1200:*',
              ),
            ),
          );
        },
      ),
    );
  }
}
