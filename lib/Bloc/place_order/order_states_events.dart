// events
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
