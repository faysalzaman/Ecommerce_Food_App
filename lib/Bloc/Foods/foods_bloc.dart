import 'package:food_ecommerce_app/Controller/Foods/foods_controller.dart';
import 'package:food_ecommerce_app/Model/Items/FoodsByCategoryModel.dart';
import 'package:food_ecommerce_app/Model/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';

part 'foods_events_states.dart';

class FoodsBloc extends Bloc<FoodsEvent, FoodsState> {
  FoodsBloc() : super(FoodsInitial()) {
    on<FoodsEvent>(
      (event, emit) async {
        if (event is FoodsGetByCategoryIdEvent) {
          emit(FoodsLoading());
          try {
            bool networkStatus = await isNetworkAvailable();
            if (networkStatus) {
              final foods = await FoodController.getFoodsByCategoryId(
                event.id,
                "${event.page}",
                "${event.paginatedBy}",
              );
              emit(FoodsLoaded(foods: foods));
            } else {
              emit(FoodsError(error: "No Internet Connection"));
            }
          } catch (e) {
            emit(FoodsError(error: e.toString()));
          }
        }

        if (event is FoodsGetByCategoryIdMoreEvent) {
          emit(FoodsLoadingMore());
          try {
            bool networkStatus = await isNetworkAvailable();
            if (networkStatus) {
              final foods = await FoodController.getFoodsByCategoryId(
                event.id,
                "${event.page}",
                "${event.paginatedBy}",
              );
              emit(FoodsLoaded(foods: foods));
            } else {
              emit(FoodsError(error: "No Internet Connection"));
            }
          } catch (e) {
            emit(FoodsError(error: e.toString()));
          }
        }
      },
    );
  }
}
