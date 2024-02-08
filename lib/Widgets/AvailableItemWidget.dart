// ignore_for_file: must_be_immutable, file_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:food_ecommerce_app/Bloc/ItemsBloc/Items_Bloc.dart';
import 'package:food_ecommerce_app/Bloc/ItemsBloc/Items_States_Events.dart';
import 'package:food_ecommerce_app/Screens/Foods/foods_details_screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:velocity_x/velocity_x.dart';

class AvailableItemWidget extends StatelessWidget {
  const AvailableItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ItemsBloc, ItemsState>(
      builder: (context, state) {
        if (state is ItemsLoading) {
          return const CategoriesItemWidgetShimmerWidget();
        } else if (state is ItemsError) {
          return const CategoriesItemWidgetShimmerWidget();
        } else if (state is ItemsLoaded) {
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: state.randomFiveItemsModel.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: MediaQuery.of(context).size.height * 0.2,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            PageTransition(
                              type: PageTransitionType.fade,
                              child: FoodsDetailsScreen(
                                foods: state.randomFiveItemsModel[index],
                              ),
                            ),
                          );
                        },
                        child: CachedNetworkImage(
                          imageUrl: state.randomFiveItemsModel[index].image
                              .toString(),
                          fit: BoxFit.cover,
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      state.randomFiveItemsModel[index].foodName.toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }
        return Container();
      },
    );
  }
}

class CategoriesItemWidgetShimmerWidget extends StatelessWidget {
  const CategoriesItemWidgetShimmerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 3,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                height: MediaQuery.of(context).size.height * 0.2,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey[100],
                  ),
                ).shimmer(secondaryColor: Colors.white),
              ),
              const SizedBox(height: 8),
              Container(
                width: MediaQuery.of(context).size.width * 0.4,
                height: 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey[100],
                ),
              ).shimmer(secondaryColor: Colors.white),
            ],
          ),
        );
      },
    );
  }
}
