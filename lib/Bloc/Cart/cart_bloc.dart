import 'package:food_ecommerce_app/Controller/Cart/cart_controller.dart';
import 'package:food_ecommerce_app/Model/Cart/GetCartByUserIdModel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';

part 'cart_states_events.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitialState()) {
    on<CartEvent>(
      (event, emit) async {
        if (event is GetCartEvent) {
          emit(CartLoadingState());
          try {
            bool networkStatus = await isNetworkAvailable();
            if (networkStatus) {
              final foods = await CartController.getIsInCart(
                event.userId,
                event.foodId,
              );
              emit(CartLoadedState(foods.data.isInCart!));
            } else {
              emit(CartErrorState("No Internet Connection"));
            }
          } catch (e) {
            emit(CartErrorState(e.toString().replaceAll("Exception:", "")));
          }
        }
        if (event is GetCartByIdEvent) {
          emit(GetCartByIdLoading());
          try {
            bool networkStatus = await isNetworkAvailable();
            if (networkStatus) {
              final foods = await CartController.getCartByUserId(
                event.userId,
                event.page,
                event.pageSize,
              );
              emit(GetCartByIdLoadedState(foods.data));
            } else {
              emit(GetCartByIdErrorState("No Internet Connection"));
            }
          } catch (e) {
            emit(GetCartByIdErrorState(
                e.toString().replaceAll("Exception:", "")));
          }
        }
        if (event is AddOrRemoveFromCartEvent) {
          emit(AddOrRemoveFromCartLoading());
          try {
            bool networkStatus = await isNetworkAvailable();
            if (networkStatus) {
              final foods = await CartController.addOrRemoveFromCart(
                event.userId,
                event.foodId,
              );
              emit(AddOrRemoveFromCartLoadedState(foods.message.toString()));
            } else {
              emit(AddOrRemoveFromCartErrorState("No Internet Connection"));
            }
          } catch (e) {
            emit(AddOrRemoveFromCartErrorState(
                e.toString().replaceAll("Exception:", "")));
          }
        }
        if (event is IncreaseQtyEvent) {
          emit(IncreaseQtyLoading());
          try {
            bool networkStatus = await isNetworkAvailable();
            if (networkStatus) {
              final foods = await CartController.increamentCartItem(
                event.userId,
                event.foodId,
              );
              emit(IncreaseQtyLoadedState(foods.message.toString()));
            } else {
              emit(IncreaseQtyErrorState("No Internet Connection"));
            }
          } catch (e) {
            emit(
              IncreaseQtyErrorState(
                e.toString().replaceAll("Exception:", ""),
              ),
            );
          }
        }
        if (event is DecreaseQtyEvent) {
          emit(DecreaseQtyLoading());
          try {
            bool networkStatus = await isNetworkAvailable();
            if (networkStatus) {
              final foods = await CartController.decreamentCartItem(
                event.userId,
                event.foodId,
              );
              emit(DecreaseQtyLoadedState(foods.message.toString()));
            } else {
              emit(DecreaseQtyErrorState("No Internet Connection"));
            }
          } catch (e) {
            emit(
              DecreaseQtyErrorState(
                e.toString().replaceAll("Exception:", ""),
              ),
            );
          }
        }
      },
    );
  }
}
