// ignore_for_file: file_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:food_ecommerce_app/Bloc/ItemsBloc/Items_Bloc.dart';
import 'package:food_ecommerce_app/Bloc/ItemsBloc/Items_States_Events.dart';
import 'package:food_ecommerce_app/Screens/Foods/foods_details_screens.dart';
import 'package:food_ecommerce_app/Utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:velocity_x/velocity_x.dart';

// ignore: must_be_immutable
class RandomCategoryItemWidget extends StatefulWidget {
  const RandomCategoryItemWidget({Key? key}) : super(key: key);

  @override
  State<RandomCategoryItemWidget> createState() =>
      _RandomCategoryItemWidgetState();
}

class _RandomCategoryItemWidgetState extends State<RandomCategoryItemWidget> {
  int pageIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ItemsBloc, ItemsState>(
      builder: (context, state) {
        if (state is ItemsLoaded) {
          return Stack(
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  height: MediaQuery.of(context).size.height * 0.3,
                  aspectRatio: 16 / 9,
                  viewportFraction: 1,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  enlargeFactor: 0.3,
                  onPageChanged: (index, reason) {
                    setState(() {
                      pageIndex = index;
                    });
                  },
                  scrollDirection: Axis.horizontal,
                ),
                items: state.randomFiveItemsModel
                    .map(
                      (item) => Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                PageTransition(
                                  type: PageTransitionType.fade,
                                  child: FoodsDetailsScreen(
                                    foods: item,
                                  ),
                                ),
                              );
                            },
                            child: CachedNetworkImage(
                              imageUrl: item.image!.toString(),
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Center(
                                child: CachedNetworkImage(
                                  imageUrl:
                                      "https://www.pulsecarshalton.co.uk/wp-content/uploads/2016/08/jk-placeholder-image.jpg",
                                  fit: BoxFit.cover,
                                ),
                              ),
                              errorWidget: (context, url, error) =>
                                  const Center(
                                child: Icon(Icons.error),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
              Positioned(
                bottom: 10,
                right: 10,
                child: CarouselIndicator(
                  count: state.randomFiveItemsModel.length,
                  index: pageIndex,
                  color: AppColors.whiteColor,
                  activeColor: AppColors.primaryColor,
                  height: 10,
                  width: 10,
                  space: 5,
                  cornerRadius: 50,
                ),
              ),
            ],
          );
        }
        return _randomFiveItemShimmerWidget(context);
      },
    );
  }

  Stack _randomFiveItemShimmerWidget(BuildContext context) {
    return Stack(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: MediaQuery.of(context).size.height * 0.3,
            aspectRatio: 16 / 9,
            viewportFraction: 1,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: true,
            enlargeFactor: 0.3,
            onPageChanged: (index, reason) {
              setState(() {
                pageIndex = index;
              });
            },
            scrollDirection: Axis.horizontal,
          ),
          // 5 items in the list
          items: List.generate(5, (i) {})
              .map(
                (item) => Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(color: Colors.grey[100]).shimmer(
                      secondaryColor: Colors.white,
                    ),
                  ),
                ),
              )
              .toList(),
        ),
        Positioned(
          bottom: 10,
          right: 10,
          child: CarouselIndicator(
            count: 5,
            index: pageIndex,
            color: AppColors.whiteColor,
            activeColor: AppColors.primaryColor,
            height: 10,
            width: 10,
            space: 5,
            cornerRadius: 50,
          ),
        ),
      ],
    );
  }
}
