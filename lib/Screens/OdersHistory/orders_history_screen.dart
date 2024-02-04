import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_ecommerce_app/Bloc/place_order/order_bloc.dart';
import 'package:food_ecommerce_app/Bloc/place_order/order_states_events.dart';
import 'package:food_ecommerce_app/Model/Order/OrdersByUserIdModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:timeago/timeago.dart' as timeago;

class OrdersHistoryScreen extends StatefulWidget {
  const OrdersHistoryScreen({super.key});

  @override
  State<OrdersHistoryScreen> createState() => _OrdersHistoryScreenState();
}

class _OrdersHistoryScreenState extends State<OrdersHistoryScreen> {
  OrderBloc orderBloc = OrderBloc();

  String userId = "";

  Future<String> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userIdd = prefs.getString("userId").toString();
    setState(() {
      userId = userIdd;
    });
    return userIdd;
  }

  @override
  void initState() {
    super.initState();
    getUserId().then((value) {
      orderBloc.add(OrderByUserIdEvent(value, "1", "100"));
    });
  }

  List<OrdersByUserIdModel> orders = [];

  String timeAgo(DateTime date) {
    return timeago.format(date, allowFromNow: true, locale: 'en');
  }

  @override
  Widget build(BuildContext context) {
    // Orders History Screen with Bloc and will show the order status
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<OrderBloc, OrdersState>(
          bloc: orderBloc,
          listener: (context, state) {
            if (state is OrderByUserIdLoadedState) {
              orders = state.data;
            }
          },
          builder: (context, state) {
            if (state is OrderByUserIdLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is OrderByUserIdLoadedState) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: orders.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: ListTile(
                      title: Text(orders[index].user!.fullname.toString()),
                      subtitle: Text(orders[index].totalPrice.toString()),
                      leading: CachedNetworkImage(
                        imageUrl: orders[index].user!.profileImage.toString(),
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                      ),
                      trailing: Column(
                        children: [
                          Text(
                            orders[index].status.toString(),
                            style: TextStyle(
                              color: orders[index].status.toString() ==
                                      "Pending"
                                  ? Colors.red
                                  : orders[index].status.toString() == "Ordered"
                                      ? Colors.green
                                      : Colors.yellow,
                            ),
                          ),
                          Text(
                            timeAgo(
                              DateTime.parse(
                                orders[index].createdAt.toString(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else if (state is OrderByUserIdErrorState) {
              return Center(
                child: Text(state.error),
              );
            } else {
              return const Center(
                child: Text("No Orders Found"),
              );
            }
          },
        ),
      ),
    );
  }
}
