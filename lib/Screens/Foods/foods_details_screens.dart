// ignore_for_file: must_be_immutable, avoid_print, use_build_context_synchronously

import 'package:cached_network_image/cached_network_image.dart';
import 'package:food_ecommerce_app/Bloc/Cart/cart_bloc.dart';
import 'package:food_ecommerce_app/Bloc/WishList/wish_list_bloc.dart';
import 'package:food_ecommerce_app/Bloc/WishList/wish_list_states_events.dart';
import 'package:food_ecommerce_app/Model/Items/FoodsByCategoryModel.dart';
import 'package:food_ecommerce_app/Screens/Cart/cart_screen.dart';
import 'package:food_ecommerce_app/Utils/constants.dart';
import 'package:food_ecommerce_app/Widgets/ButtonWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:velocity_x/velocity_x.dart';

class FoodsDetailsScreen extends StatefulWidget {
  FoodsByCategoryModel foods;

  FoodsDetailsScreen({Key? key, required this.foods}) : super(key: key);

  @override
  State<FoodsDetailsScreen> createState() => _FoodsDetailsScreenState();
}

class _FoodsDetailsScreenState extends State<FoodsDetailsScreen> {
  WishListBloc wishListBloc = WishListBloc();
  CartBloc cartBloc = CartBloc();
  CartBloc addOrRemoveFromCart = CartBloc();

  Future<String> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString("userId")!;
    return userId;
  }

  String cartButtonName = "Add to Cart";
  IconData favoriteIcon = Icons.favorite_outline;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      String userId = await getUserId();
      wishListBloc.add(WishListCheckEvent(userId, widget.foods.sId!));
      cartBloc.add(GetCartEvent(userId, widget.foods.sId!));
      addOrRemoveFromCart
          .add(AddOrRemoveFromCartEvent(userId, widget.foods.sId!));
      context.read<CartBloc>().add(GetCartByIdEvent(userId, "1", "10"));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.foods.foodName!, style: boldTextStyle()),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: BlocBuilder<CartBloc, CartState>(
              builder: (context, state) {
                if (state is GetCartByIdLoadedState) {
                  return Badge(
                    alignment: Alignment.topRight,
                    backgroundColor: Colors.red,
                    isLabelVisible: true,
                    label: Text(state.cartList.length.toString()),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CartScreen(),
                          ),
                        );
                      },
                      child: const Icon(
                        Icons.shopping_cart_outlined,
                        color: Colors.black,
                      ),
                    ),
                  );
                }
                return Badge(
                  alignment: Alignment.topRight,
                  backgroundColor: Colors.red,
                  isLabelVisible: true,
                  label: const Text("0"),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CartScreen(),
                        ),
                      );
                    },
                    child: const Icon(
                      Icons.shopping_cart_outlined,
                      color: Colors.black,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<CartBloc, CartState>(
            bloc: cartBloc,
            listener: (context, state) {
              if (state is CartLoadedState) {
                print("Is in cart: ${state.isInCart}");
                cartButtonName = state.isInCart == false
                    ? "Add to Cart"
                    : "Remove from Cart";
              }
            },
          ),
          BlocListener<WishListBloc, WishListState>(
            bloc: wishListBloc,
            listener: (context, state) {
              if (state is WishListLoadedState) {
                print("Is in wish list: ${state.isInWishList}");
                favoriteIcon = state.isInWishList == false
                    ? Icons.favorite_outline
                    : Icons.favorite;
              }
            },
          ),
        ],
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  CachedNetworkImage(
                    imageUrl: widget.foods.image.toString(),
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Center(
                      child: CachedNetworkImage(
                        imageUrl:
                            "https://www.pulsecarshalton.co.uk/wp-content/uploads/2016/08/jk-placeholder-image.jpg",
                        fit: BoxFit.cover,
                      ),
                    ),
                    errorWidget: (context, url, error) => const Center(
                      child: Icon(Icons.error),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    left: 0,
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: BlocBuilder<WishListBloc, WishListState>(
                        bloc: wishListBloc,
                        builder: (context, state) {
                          if (state is WishListLoadingState) {
                            return const Icon(
                              Icons.favorite,
                              size: 50,
                            ).shimmer();
                          }
                          return IconButton(
                            onPressed: () {},
                            icon: Icon(
                              favoriteIcon,
                              color: Colors.red,
                              size: 50,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.foods.foodName!,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    width: 10,
                    child: const Text("-"),
                  ),
                  Text(
                    "Rs.${widget.foods.price}",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[300],
                ),
                child: Text(
                  widget.foods.description!,
                  style: const TextStyle(fontSize: 15),
                  textAlign: TextAlign.center,
                ),
              ),
              // reviews button
              TextButton(
                style:
                    TextButton.styleFrom(foregroundColor: AppColors.blackColor),
                onPressed: () {},
                child: const Text(
                  "Show Reviews >",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // add to cart button
              BlocBuilder<CartBloc, CartState>(
                bloc: cartBloc,
                builder: (context, state) {
                  if (state is CartLoadingState) {
                    return ButtonWidget(
                      child: const Icon(
                        Icons.shopping_cart_outlined,
                        size: 30,
                        color: AppColors.blackColor,
                      ).shimmer(
                        secondaryColor: Colors.black,
                      ),
                      onPressed: () {},
                    ).paddingAll(10);
                  }

                  return ButtonWidget(
                    text: cartButtonName,
                    onPressed: () {},
                  ).paddingAll(10);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
