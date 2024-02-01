// ignore_for_file: file_names, prefer_const_constructors, sized_box_for_whitespace, must_be_immutable

import 'package:food_ecommerce_app/Bloc/Categories/categories_bloc.dart';
import 'package:food_ecommerce_app/Bloc/Categories/categories_states_events.dart';
import 'package:food_ecommerce_app/Bloc/ItemsBloc/Items_Bloc.dart';
import 'package:food_ecommerce_app/Bloc/ItemsBloc/Items_States_Events.dart';
import 'package:food_ecommerce_app/Bloc/UserDetials/UserDetails_Bloc.dart';
import 'package:food_ecommerce_app/Widgets/AppBarWidget.dart';
import 'package:food_ecommerce_app/Widgets/AvailableItemWidget.dart';
import 'package:food_ecommerce_app/Widgets/CategoryItemWidget.dart';
import 'package:food_ecommerce_app/Widgets/Drawer/DrawerWidget.dart';
import 'package:food_ecommerce_app/Widgets/RandomCategoryItemWidget.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    required this.userDetailsBloc,
  });

  final UserDetailsBloc userDetailsBloc;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, dynamic>> products = [
    {
      'name': 'Pizza',
      'category': 'Italian',
      'image':
          'https://www.allrecipes.com/thmb/ooZbu_yUBrGQ74uKbuOENWuNxMM=/750x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/48727-Mikes-homemade-pizza-DDMFS-beauty-4x3-BG-2974-a7a9842c14e34ca699f3b7d7143256cf.jpg',
      'price': 9.99,
    },
    {
      'name': 'Tacos',
      'category': 'Mexican',
      'image':
          'https://pinchandswirl.com/wp-content/uploads/2022/11/Lamb-Tacos__.jpg',
      'price': 6.49,
    },
    {
      'name': 'Shoyu Ramen',
      'category': 'Japanese',
      'image':
          'https://www.myojousa.com/wp-content/uploads/2021/02/signatureshoyuramen-690x690.jpg',
      'price': 9.99,
    }
  ];

  CategoriesBloc categoriesBloc = CategoriesBloc();
  ItemsBloc itemsBloc = ItemsBloc();

  @override
  void initState() {
    super.initState();

    categoriesBloc.add(CategoriesFetchEvent());
    itemsBloc.add(FetchItems());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBarWidget(),
      ),
      drawer: DrawerWidget(userDetailsBloc: widget.userDetailsBloc),
      body: SafeArea(
        child: Container(
          height: context.height(),
          margin: const EdgeInsets.only(top: 10),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                  child: CategoryItemWidget(categoriesBloc: categoriesBloc),
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
                  child: AvailableItemWidget(itemsBloc: itemsBloc),
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
