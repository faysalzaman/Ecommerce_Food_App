// ignore_for_file: library_private_types_in_public_api, avoid_unnecessary_containers, avoid_print, must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:food_ecommerce_app/Bloc/Cart/cart_bloc.dart';
import 'package:food_ecommerce_app/Bloc/place_order/order_bloc.dart';
import 'package:food_ecommerce_app/Bloc/place_order/order_states_events.dart';
import 'package:food_ecommerce_app/Model/Cart/GetCartByUserIdModel.dart';
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
  OrderBloc orderBloc = OrderBloc();

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
    context.read<CartBloc>().add(GetCartByIdEvent(userId, "1", "100"));
  }

  // Scaffold Key
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  List<GetCartByUserIdModel> cartList = [];

  int totalPrice = 0;

  // Create a list of CartBloc instances
  List<CartBloc> increaseItemBlocs = [];
  List<CartBloc> decreaseItemBlocs = [];

  TextEditingController addressController = TextEditingController();

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
              cartList = state.cartList;

              // Initialize a new CartBloc for each item in the cart
              increaseItemBlocs =
                  List.generate(cartLength, (index) => CartBloc());
              decreaseItemBlocs =
                  List.generate(cartLength, (index) => CartBloc());
            } else if (state is GetCartByIdErrorState) {
              cartList = [];
              cartLength = 0;
            } else if (state is AddOrRemoveFromCartLoadedState) {
              cartLength = cartLength - 1;
            }
          },
          builder: (context, state) {
            if (state is GetCartByIdLoadedState) {
              return cartList.isEmpty
                  ? Center(
                      child: CachedNetworkImage(
                        imageUrl:
                            "https://www.buy.airoxi.com/img/empty-cart-1.png",
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    )
                  : Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: cartList.length,
                            itemBuilder: (context, index) {
                              if (index == 0) {
                                totalPrice = 0;
                              }
                              totalPrice = totalPrice +
                                  (cartList[index].foodId!.price! *
                                      cartList[index].quantity!);
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
                                          imageUrl: cartList[index]
                                              .foodId!
                                              .image
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
                                              cartList[index]
                                                  .foodId!
                                                  .foodName
                                                  .toString(),
                                              style: const TextStyle(
                                                fontSize: 15,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              "Rs. ${cartList[index].foodId!.price.toString()}",
                                              style: const TextStyle(
                                                fontSize: 15,
                                                color: Colors.green,
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                var foodId = cartList[index]
                                                    .foodId!
                                                    .sId
                                                    .toString();

                                                removeFromCart(foodId);

                                                setState(() {
                                                  cartList.removeAt(index);
                                                });
                                              },
                                              icon: const Icon(
                                                  Icons.delete_forever),
                                              color: Colors.red,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          BlocConsumer<CartBloc, CartState>(
                                            bloc: decreaseItemBlocs[index],
                                            listener: (context, state) {
                                              if (state is DecreaseQtyLoading) {
                                                setState(() {
                                                  cartList[index].quantity =
                                                      cartList[index]
                                                              .quantity! -
                                                          1;
                                                });
                                              }
                                              if (state
                                                  is DecreaseQtyErrorState) {
                                                setState(() {
                                                  cartList[index].quantity =
                                                      cartList[index]
                                                              .quantity! +
                                                          1;
                                                });
                                              }
                                            },
                                            builder: (context, state) {
                                              return IconButton(
                                                onPressed: () {
                                                  decreaseItemBlocs[index].add(
                                                    DecreaseQtyEvent(
                                                      userId,
                                                      cartList[index]
                                                          .foodId!
                                                          .sId!,
                                                    ),
                                                  );
                                                },
                                                icon: const Icon(
                                                  Icons.remove,
                                                  color: Colors.red,
                                                ),
                                              );
                                            },
                                          ),
                                          Text(
                                            cartList[index].quantity.toString(),
                                            style: const TextStyle(
                                              fontSize: 20,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          BlocConsumer<CartBloc, CartState>(
                                            bloc: increaseItemBlocs[index],
                                            listener: (context, state) {
                                              if (state is IncreaseQtyLoading) {
                                                setState(() {
                                                  cartList[index].quantity =
                                                      cartList[index]
                                                              .quantity! +
                                                          1;
                                                });
                                              }
                                              if (state
                                                  is IncreaseQtyErrorState) {
                                                setState(() {
                                                  cartList[index].quantity =
                                                      cartList[index]
                                                              .quantity! -
                                                          1;
                                                });
                                              }
                                            },
                                            builder: (context, state) {
                                              return IconButton(
                                                onPressed: () {
                                                  increaseItemBlocs[index].add(
                                                    IncreaseQtyEvent(
                                                      userId,
                                                      cartList[index]
                                                          .foodId!
                                                          .sId!,
                                                    ),
                                                  );
                                                },
                                                icon: const Icon(
                                                  Icons.add,
                                                  color: Colors.green,
                                                ),
                                              );
                                            },
                                          ),
                                        ],
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
                                onPressed: () {
                                  // show dialog to enter address
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const Text(
                                                  "Total Price",
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                  "Rs. $totalPrice",
                                                  style: const TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.green,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            20.height,
                                            SizedBox(
                                              child: TextFormField(
                                                controller: addressController,
                                                maxLines: 3,
                                                textAlignVertical:
                                                    TextAlignVertical.top,
                                                textAlign: TextAlign.start,
                                                decoration: InputDecoration(
                                                  alignLabelWithHint: true,
                                                  labelText: "Enter Address",
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        actions: [
                                          Container(
                                            decoration: BoxDecoration(
                                              color: Colors.red,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text(
                                                "Cancel",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                          BlocListener<OrderBloc, OrdersState>(
                                            bloc: orderBloc,
                                            listener: (context, state) {
                                              if (state
                                                  is PlaceOrderLoadedState) {
                                                Navigator.pop(context);
                                                setState(() {
                                                  cartList.clear();
                                                });

                                                context.read<CartBloc>().add(
                                                    GetCartByIdEvent(
                                                        userId, "1", "100"));

                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                        content: Text(
                                                            state.message)));
                                              }
                                              if (state
                                                  is PlaceOrderErrorState) {
                                                Navigator.pop(context);

                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                        content:
                                                            Text(state.error)));
                                              }
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.green,
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: TextButton(
                                                onPressed: () {
                                                  orderBloc.add(
                                                    PlaceOrder(
                                                      userId,
                                                      totalPrice.toString(),
                                                      addressController.text
                                                          .trim(),
                                                    ),
                                                  );
                                                },
                                                child: const Text(
                                                  "Place Order",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
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
            } else if (state is GetCartByIdLoadingState) {
              return const CartShimmerWidget();
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
