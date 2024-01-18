part of 'cart_bloc.dart';

abstract class CartEvent {}

class GetCartEvent extends CartEvent {
  final String userId;
  final String foodId;
  GetCartEvent(this.foodId, this.userId);
}

abstract class CartState {}

class CartInitialState extends CartState {}

class CartLoadingState extends CartState {}

class CartLoadedState extends CartState {
  final bool isInCart;
  CartLoadedState(this.isInCart);
}

class CartErrorState extends CartState {
  final String message;
  CartErrorState(this.message);
}

class GetCartByIdEvent extends CartEvent {
  final String userId;
  final String page;
  final String pageSize;
  GetCartByIdEvent(this.userId, this.page, this.pageSize);
}

class GetCartByIdLoadedState extends CartState {
  final List<GetCartByUserIdModel> cartList;
  GetCartByIdLoadedState(this.cartList);
}

class GetCartByIdErrorState extends CartState {
  final String message;
  GetCartByIdErrorState(this.message);
}

class GetCartByIdLoading extends CartState {}

class AddOrRemoveFromCartEvent extends CartEvent {
  final String userId;
  final String foodId;
  AddOrRemoveFromCartEvent(this.userId, this.foodId);
}

class AddOrRemoveFromCartLoadedState extends CartState {
  final String message;
  AddOrRemoveFromCartLoadedState(this.message);
}

class AddOrRemoveFromCartErrorState extends CartState {
  final String message;
  AddOrRemoveFromCartErrorState(this.message);
}

class AddOrRemoveFromCartLoading extends CartState {}
