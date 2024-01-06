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