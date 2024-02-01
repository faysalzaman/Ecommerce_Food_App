// ignore_for_file: library_private_types_in_public_api, avoid_unnecessary_containers

import 'package:cached_network_image/cached_network_image.dart';
import 'package:food_ecommerce_app/Bloc/Cart/cart_bloc.dart';
import 'package:food_ecommerce_app/Screens/Cart/quantity_widget.dart';
import 'package:food_ecommerce_app/Screens/TabsScreen/TabsScreen.dart';
import 'package:food_ecommerce_app/Utils/constants.dart';
import 'package:food_ecommerce_app/Widgets/ButtonWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:page_transition/page_transition.dart';
import 'package:velocity_x/velocity_x.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  String userId = "";

  int cartLength = 0;

  CartBloc cartBloc = CartBloc();

  @override
  void initState() {
    super.initState();
    getUserId().then(
      (value) {
        cartBloc.add(GetCartByIdEvent(value, "1", "100"));
      },
    );
  }

  Future<String> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userIdd = prefs.getString("userId").toString();
    setState(() {
      userId = userIdd;
    });
    return userIdd;
  }

  removeFromCart(String foodId) {
    context.read<CartBloc>().add(AddOrRemoveFromCartEvent(userId, foodId));
  }

  // Scaffold Key
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) {
        if (didPop) {
          Navigator.of(context).pushReplacement(
            PageTransition(
              child: const TabsScreen(),
              type: PageTransitionType.fade,
            ),
          );
        }
      },
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: const Text('Cart'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                PageTransition(
                  child: const TabsScreen(),
                  type: PageTransitionType.fade,
                ),
              );
            },
          ),
        ),
        body: BlocConsumer<CartBloc, CartState>(
          bloc: cartBloc,
          listener: (context, state) {
            if (state is GetCartByIdLoadedState) {
              cartLength = state.cartList.length;
            } else if (state is AddOrRemoveFromCartLoadedState) {
              cartLength = cartLength - 1;
            }
          },
          builder: (context, state) {
            if (state is GetCartByIdLoadedState) {
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.cartList.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {},
                          child: Container(
                            margin: const EdgeInsets.all(8),
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                SizedBox(
                                  height: 100,
                                  width: 100,
                                  child: CachedNetworkImage(
                                    imageUrl: state
                                        .cartList[index].foodId!.image
                                        .toString(),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        state.cartList[index].foodId!.foodName
                                            .toString(),
                                        style: const TextStyle(
                                          fontSize: 15,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        "Rs. ${state.cartList[index].foodId!.price.toString()}",
                                        style: const TextStyle(
                                          fontSize: 15,
                                          color: Colors.green,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          var foodId = state
                                              .cartList[index].foodId!.sId
                                              .toString();
                                          removeFromCart(foodId);
                                          context.read<CartBloc>().add(
                                                GetCartByIdEvent(
                                                    userId, "1", "100"),
                                              );
                                          context.read<CartBloc>().add(
                                                AddOrRemoveFromCartEvent(
                                                    userId, foodId),
                                              );
                                        },
                                        icon: const Icon(Icons.delete_forever),
                                        color: Colors.red,
                                      ),
                                    ],
                                  ),
                                ),
                                QuantityWidget(
                                  quantity: state.cartList[index].quantity!,
                                  cartBloc: cartBloc,
                                  userId: userId,
                                  foodId: state.cartList[index].foodId!.sId
                                      .toString(),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Expanded(
                    flex: 0,
                    child: Visibility(
                      visible: cartLength > 0 ? true : false,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ButtonWidget(
                          color: AppColors.primaryColor,
                          text: "Proceed to Pay",
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ),
                ],
              );
            } else if (state is GetCartByIdErrorState) {
              return Center(
                child: CachedNetworkImage(
                  imageUrl: "https://www.buy.airoxi.com/img/empty-cart-1.png",
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              );
            }
            return const CartShimmerWidget();
          },
        ),
      ),
    );
  }
}

class CartShimmerWidget extends StatelessWidget {
  const CartShimmerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Container(
                color: Colors.grey[300],
                height: 100,
                width: 100,
              ).shimmer(),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      color: Colors.grey[300],
                      height: 15,
                      width: 100,
                    ).shimmer(),
                    const SizedBox(height: 8),
                    Container(
                      color: Colors.grey[300],
                      height: 15,
                      width: 100,
                    ).shimmer(),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
              Row(
                children: [
                  Container(
                    color: Colors.grey[300],
                    height: 10,
                    width: 15,
                  ).shimmer(),
                  10.width,
                  Container(
                    color: Colors.grey[300],
                    height: 10,
                    width: 10,
                  ).shimmer(),
                  10.width,
                  Container(
                    color: Colors.grey[300],
                    height: 10,
                    width: 15,
                  ).shimmer(),
                ],
              ).shimmer(),
            ],
          ),
        );
      },
    );
  }
}
