import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_ecommerce_app/Bloc/place_order/order_bloc.dart';
import 'package:food_ecommerce_app/Bloc/place_order/order_states_events.dart';
import 'package:food_ecommerce_app/Model/Order/OrderItemByOrderIdModel.dart';
import 'package:velocity_x/velocity_x.dart';

class OrderItemByOrderIdScreen extends StatefulWidget {
  const OrderItemByOrderIdScreen({super.key, required this.orderId});

  final String orderId;

  @override
  State<OrderItemByOrderIdScreen> createState() =>
      _OrderItemByOrderIdScreenState();
}

class _OrderItemByOrderIdScreenState extends State<OrderItemByOrderIdScreen> {
  OrderBloc orderBloc = OrderBloc();

  @override
  void initState() {
    orderBloc.add(OrderItemByOrderIdEvent(widget.orderId));
    super.initState();
  }

  List<OrderItemByOrderIdModel> orderItems = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Order Items")),
      body: SafeArea(
        child: BlocConsumer<OrderBloc, OrdersState>(
          bloc: orderBloc,
          listener: (context, state) {
            if (state is OrderItemByOrderIdLoadedState) {
              orderItems = state.data;
            }
          },
          builder: (context, state) {
            if (state is OrderItemByOrderIdLoadingState) {
              return ListView.builder(
                itemCount: 3,
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.all(10),
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
                      contentPadding: const EdgeInsets.all(10),
                      leading: Container(
                        height: 50,
                        width: 50,
                        color: Colors.grey,
                      ).shimmer(),
                      title: Container(
                        height: 20,
                        color: Colors.grey,
                      ).shimmer(),
                      subtitle: Container(
                        height: 20,
                        color: Colors.grey,
                      ).shimmer(),
                      trailing: Container(
                        height: 20,
                        width: 20,
                        color: Colors.grey,
                      ).shimmer(),
                    ),
                  );
                },
              );
            }
            if (state is OrderItemByOrderIdErrorState) {
              return Center(
                child: Text(state.error),
              );
            }
            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: orderItems.length,
              itemBuilder: (context, index) {
                return Container(
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
                    contentPadding: const EdgeInsets.all(10),
                    style: ListTileStyle.list,
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                        orderItems[index].foodId!.image!,
                      ),
                      radius: 40,
                    ),
                    title: Text(orderItems[index].foodId!.foodName!),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          orderItems[index].status!,
                          style: const TextStyle(fontSize: 15),
                        ),
                        Row(
                          children: [
                            const Text(
                              "Rs ",
                              style: TextStyle(color: Colors.black),
                            ),
                            Text(
                              orderItems[index].foodId!.price.toString(),
                              style: const TextStyle(color: Colors.green),
                            ),
                          ],
                        ),
                      ],
                    ),
                    trailing: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "Quantity",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          orderItems[index].quantity.toString(),
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
