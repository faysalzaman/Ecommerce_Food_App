// ignore_for_file: library_private_types_in_public_api

import 'package:cached_network_image/cached_network_image.dart';
import 'package:food_ecommerce_app/Bloc/Cart/cart_bloc.dart';
import 'package:food_ecommerce_app/Utils/constants.dart';
import 'package:food_ecommerce_app/Widgets/ButtonWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:velocity_x/velocity_x.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  Future<String> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString("userId").toString();
    return userId;
  }

  @override
  void initState() {
    super.initState();
    getUserId().then((value) {
      context.read<CartBloc>().add(GetCartByIdEvent(value, "1", "10"));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoadingState) {
            return const CartShimmerWidget();
          }
          if (state is GetCartByIdLoadedState) {
            return ListView.builder(
              itemCount: state.cartList.length,
              itemBuilder: (context, index) {
                return Container(
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
                          imageUrl:
                              state.cartList[index].foodId!.image.toString(),
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              state.cartList[index].foodId!.foodName.toString(),
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
                            const SizedBox(height: 8),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.remove),
                          ),
                          Text(
                            state.cartList[index].quantity.toString(),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.add),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          }
          return Container();
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ButtonWidget(
          color: AppColors.primaryColor,
          text: "Proceed to Pay",
          onPressed: () {},
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
      itemCount: 3,
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