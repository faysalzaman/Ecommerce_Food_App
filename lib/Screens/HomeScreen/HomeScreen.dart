// ignore_for_file: file_names, prefer_const_constructors, sized_box_for_whitespace, must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_ecommerce_app/Bloc/ItemsBloc/Items_Bloc.dart';
import 'package:food_ecommerce_app/Bloc/ItemsBloc/Items_States_Events.dart';
import 'package:food_ecommerce_app/Bloc/Story/story_bloc.dart';
import 'package:food_ecommerce_app/Model/Story/FetchStoryModel.dart';
import 'package:food_ecommerce_app/Screens/Story/story_screen.dart';
import 'package:food_ecommerce_app/Widgets/AppBarWidget.dart';
import 'package:food_ecommerce_app/Widgets/AvailableItemWidget.dart';
import 'package:food_ecommerce_app/Widgets/CategoryItemWidget.dart';
import 'package:food_ecommerce_app/Widgets/Drawer/DrawerWidget.dart';
import 'package:food_ecommerce_app/Widgets/RandomCategoryItemWidget.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:page_transition/page_transition.dart';
import 'package:velocity_x/velocity_x.dart';

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
    return BlocConsumer<StoryBloc, StoryState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is StoryLoadedState) {
          return Container(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: state.storyModel.length,
              itemBuilder: (BuildContext context, int index) {
                // Filter items based on status code
                final List<FetchStoryModel> filteredStoriesWithStatusCode0 =
                    state.storyModel
                        .where((story) => story.status == 0)
                        .toList();
                final List<FetchStoryModel> filteredStoriesWithStatusCode1 =
                    state.storyModel
                        .where((story) => story.status == 1)
                        .toList();

                // Concatenate the filtered lists
                final List<FetchStoryModel> sortedStories = [
                  ...filteredStoriesWithStatusCode0,
                  ...filteredStoriesWithStatusCode1
                ];

                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacement(PageTransition(
                      child: StoryScreen(
                        caption: sortedStories[index].caption!,
                        imageUrl: sortedStories[index].foodId!.image!,
                        storyId: sortedStories[index].sId!,
                      ),
                      type: PageTransitionType.rightToLeftWithFade,
                    ));
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: sortedStories[index].status! == 0 ? 2 : 5,
                      vertical: 10,
                    ),
                    child: Container(
                      decoration: sortedStories[index].status! == 0
                          ? BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.green,
                                width: 3,
                              ),
                            )
                          : null,
                      child: CircleAvatar(
                        radius: 40,
                        backgroundImage: CachedNetworkImageProvider(
                          sortedStories[index].foodId!.image!,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        } else if (state is StoryLoadingState) {
          return Container(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 6,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                  child: CircleAvatar(radius: 40).shimmer(),
                );
              },
            ),
          );
        }
        return Container();
      },
    );
  }
}
