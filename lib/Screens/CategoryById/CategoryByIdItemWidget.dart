// ignore_for_file: must_be_immutable, library_private_types_in_public_api, sized_box_for_whitespace, avoid_print, unused_element, non_constant_identifier_names, file_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:food_ecommerce_app/Bloc/Foods/foods_bloc.dart';
import 'package:food_ecommerce_app/Model/Items/FoodsByCategoryModel.dart';
import 'package:food_ecommerce_app/Screens/Foods/foods_details_screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:page_transition/page_transition.dart';
import 'package:velocity_x/velocity_x.dart';

class CategoryByIdItemWidget extends StatefulWidget {
  CategoryByIdItemWidget({
    Key? key,
    required this.categoryId,
    required this.categoryName,
  }) : super(key: key);

  String categoryId;
  String categoryName;

  @override
  _CategoryByIdItemWidgetState createState() => _CategoryByIdItemWidgetState();
}

class _CategoryByIdItemWidgetState extends State<CategoryByIdItemWidget> {
  ScrollController scrollController = ScrollController();
  int page = 1;
  int pageSize = 6;
  List<FoodsByCategoryModel> foods = [];
  FoodsBloc foodsBloc = FoodsBloc();

  @override
  void initState() {
    loadInitialData();
    // add scroll listner and increase page size when we reach at the bottom
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        _loadMoreData();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  _loadMoreData() {
    page++;
    foodsBloc.add(
        FoodsGetByCategoryIdMoreEvent(page, pageSize, id: widget.categoryId));
  }

  loadInitialData() {
    foodsBloc
        .add(FoodsGetByCategoryIdEvent(page, pageSize, id: widget.categoryId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryName),
      ),
      body: BlocConsumer<FoodsBloc, FoodsState>(
        bloc: foodsBloc,
        listener: (context, state) {
          if (state is FoodsLoaded) {
            foods.addAll(state.foods.data);
          } else if (state is FoodsError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is FoodsLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is FoodsError) {
            return const Center(
              child: Text('Error'),
            );
          }
          return _buildListView(foods, state);
        },
      ),
    );
  }

  Widget _buildListView(
    List<FoodsByCategoryModel> foods,
    FoodsState state,
  ) {
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      controller: scrollController,
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.8,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: foods.length + 2,
      itemBuilder: (context, index) {
        if ((index == foods.length + 1 || index == foods.length)) {
          return CategoryByItemWidgetShimmer()
              .visible(state is FoodsLoadingMore);
        } else {
          return CategoryByItemWidget(foods, index);
        }
      },
    );
  }

  Column CategoryByItemWidget(List<FoodsByCategoryModel> foods, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      PageTransition(
                        type: PageTransitionType.fade,
                        child: FoodsDetailsScreen(
                          foods: foods[index],
                        ),
                      ),
                    );
                  },
                  child: CachedNetworkImage(
                    imageUrl: foods[index].image!,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                    placeholder: (context, url) => Container(
                      color: Colors.grey[100],
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      foods[index].foodName!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ).paddingAll(8),
                ),
              ],
            ),
          ),
        ),
        5.height,
        Text(
          "Rs. ${foods[index].price.toString()}",
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Column CategoryByItemWidgetShimmer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  color: Colors.grey[100],
                ).shimmer(
                  secondaryColor: Colors.white,
                ))),
        5.height,
        Container(
          height: 16,
          width: 100,
          color: Colors.grey[100],
        ).shimmer(
          secondaryColor: Colors.white,
        ),
      ],
    );
  }
}
