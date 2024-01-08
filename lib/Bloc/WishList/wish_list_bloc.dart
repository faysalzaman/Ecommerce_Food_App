import 'package:food_ecommerce_app/Bloc/WishList/wish_list_states_events.dart';
import 'package:food_ecommerce_app/Controller/WishList/WishListController.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';

class WishListBloc extends Bloc<WishListEvent, WishListState> {
  WishListBloc() : super(WishListInitialState()) {
    on<WishListEvent>(
      (event, emit) async {
        if (event is WishListCheckEvent) {
          emit(WishListLoadingState());
          try {
            bool networkStatus = await isNetworkAvailable();
            if (networkStatus) {
              final foods = await WishListController.getIsFavorite(
                event.userId,
                event.foodId,
              );
              emit(WishListLoadedState(foods.data.isFavorite!));
            } else {
              emit(WishListErrorState("No Internet Connection"));
            }
          } catch (e) {
            emit(WishListErrorState(e.toString().replaceAll("Exception:", "")));
          }
        }
      },
    );
    on<AddOrRemoveFromWishListEvent>(
      (event, emit) async {
        emit(AddOrRemoveFromWishListLoading());
        try {
          bool networkStatus = await isNetworkAvailable();
          if (networkStatus) {
            final foods = await WishListController.addOrRemoveFromWishList(
              event.userId,
              event.foodId,
            );
            emit(AddOrRemoveFromWishListLoadedState(foods.message));
          } else {
            emit(AddOrRemoveFromWishListErrorState("No Internet Connection"));
          }
        } catch (e) {
          emit(AddOrRemoveFromWishListErrorState(
              e.toString().replaceAll("Exception:", "")));
        }
      },
    );
    on<GetFoodsInFavoriteEvent>(
      (event, emit) async {
        emit(WishListLoadingState());
        try {
          bool networkStatus = await isNetworkAvailable();
          if (networkStatus) {
            final foods = await WishListController.getWishListByUserId(
              event.userId,
              event.page,
              event.pageSize,
            );
            emit(GetFoodsInFavoriteLoadedState(foods.data));
          } else {
            emit(WishListErrorState("No Internet Connection"));
          }
        } catch (e) {
          emit(WishListErrorState(e.toString().replaceAll("Exception:", "")));
        }
      },
    );
  }
}
