import 'package:food_ecommerce_app/Model/Items/FoodsByCategoryModel.dart';

abstract class WishListEvent {}

class WishListCheckEvent extends WishListEvent {
  final String userId;
  final String foodId;
  WishListCheckEvent(this.foodId, this.userId);
}

abstract class WishListState {}

class WishListInitialState extends WishListState {}

class WishListLoadingState extends WishListState {}

class WishListLoadedState extends WishListState {
  final bool isInWishList;
  WishListLoadedState(this.isInWishList);
}

class WishListErrorState extends WishListState {
  final String message;
  WishListErrorState(this.message);
}

class AddOrRemoveFromWishListEvent extends WishListEvent {
  final String userId;
  final String foodId;
  AddOrRemoveFromWishListEvent(this.userId, this.foodId);
}

class AddOrRemoveFromWishListLoadedState extends WishListState {
  final String message;
  AddOrRemoveFromWishListLoadedState(this.message);
}

class AddOrRemoveFromWishListErrorState extends WishListState {
  final String message;
  AddOrRemoveFromWishListErrorState(this.message);
}

class AddOrRemoveFromWishListLoading extends WishListState {}

class GetFoodsInFavoriteEvent extends WishListEvent {
  final String userId;
  final String page;
  final String pageSize;
  GetFoodsInFavoriteEvent(this.userId, this.page, this.pageSize);
}

class GetFoodsInFavoriteLoadedState extends WishListState {
  final List<FoodsByCategoryModel> foods;
  GetFoodsInFavoriteLoadedState(this.foods);
}

class GetFoodsInFavoriteErrorState extends WishListState {
  final String message;
  GetFoodsInFavoriteErrorState(this.message);
}

class GetFoodsInFavoriteLoading extends WishListState {}
