// events
import 'package:food_ecommerce_app/Model/Order/OrderItemByOrderIdModel.dart';
import 'package:food_ecommerce_app/Model/Order/OrdersByUserIdModel.dart';

abstract class OrdersEvent {}

class PlaceOrder extends OrdersEvent {
  final String userId;
  final String totalPrice;
  final String address;

  PlaceOrder(this.userId, this.totalPrice, this.address);
}

// states
abstract class OrdersState {}

class PlaceOrderInitialState extends OrdersState {}

class PlaceOrderLoadingState extends OrdersState {}

class PlaceOrderLoadedState extends OrdersState {
  final String message;

  PlaceOrderLoadedState(this.message);
}

class PlaceOrderErrorState extends OrdersState {
  final String error;

  PlaceOrderErrorState(this.error);
}

class OrderByUserIdEvent extends OrdersEvent {
  final String userId;
  final String page;
  final String pageSize;

  OrderByUserIdEvent(this.userId, this.page, this.pageSize);
}

class OrderByUserIdLoadingState extends OrdersState {}

class OrderByUserIdLoadedState extends OrdersState {
  final List<OrdersByUserIdModel> data;

  OrderByUserIdLoadedState(this.data);
}

class OrderByUserIdErrorState extends OrdersState {
  final String error;

  OrderByUserIdErrorState(this.error);
}

class OrderItemByOrderIdEvent extends OrdersEvent {
  final String orderId;

  OrderItemByOrderIdEvent(this.orderId);
}

class OrderItemByOrderIdLoadingState extends OrdersState {}

class OrderItemByOrderIdLoadedState extends OrdersState {
  final List<OrderItemByOrderIdModel> data;

  OrderItemByOrderIdLoadedState(this.data);
}

class OrderItemByOrderIdErrorState extends OrdersState {
  final String error;

  OrderItemByOrderIdErrorState(this.error);
}

class OrderItemByOrderIdEmptyState extends OrdersState {}