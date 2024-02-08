// ignore_for_file: avoid_print

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_ecommerce_app/Bloc/place_order/order_states_events.dart';
import 'package:food_ecommerce_app/Controller/place_order/order_controller.dart';
import 'package:nb_utils/nb_utils.dart';

class OrderBloc extends Bloc<OrdersEvent, OrdersState> {
  OrderBloc() : super(PlaceOrderInitialState()) {
    on<OrdersEvent>(
      (event, emit) async {
        if (event is PlaceOrder) {
          emit(PlaceOrderLoadingState());
          try {
            if (await isNetworkAvailable() == false) {
              emit(PlaceOrderErrorState("No Internet Connection"));
              return;
            }
            await OrderController.placeOrder(
              event.userId,
              event.totalPrice,
              event.address,
            );
            emit(PlaceOrderLoadedState("Order Placed Successfully"));
          } catch (e) {
            emit(
              PlaceOrderErrorState(
                e.toString().replaceAll("Exception:", ""),
              ),
            );
          }
        }
        if (event is OrderByUserIdEvent) {
          emit(OrderByUserIdLoadingState());
          try {
            if (await isNetworkAvailable() == false) {
              emit(OrderByUserIdErrorState("No Internet Connection"));
              return;
            }
            final orders = await OrderController.getOrdersByUserId(
              event.userId,
              event.page,
              event.pageSize,
            );
            emit(OrderByUserIdLoadedState(orders));
          } catch (e) {
            print(e);
            emit(
              OrderByUserIdErrorState(
                e.toString().replaceAll("Exception:", ""),
              ),
            );
          }
        }
        if (event is OrderItemByOrderIdEvent) {
          emit(OrderItemByOrderIdLoadingState());
          try {
            if (await isNetworkAvailable() == false) {
              emit(OrderItemByOrderIdErrorState("No Internet Connection"));
              return;
            }

            final orderItems =
                await OrderController.getOrderItemsByOrderId(event.orderId);
            emit(OrderItemByOrderIdLoadedState(orderItems));
          } catch (e) {
            print(e);
            emit(
              OrderItemByOrderIdErrorState(
                e.toString().replaceAll("Exception:", ""),
              ),
            );
          }
        }
      },
    );
  }
}
