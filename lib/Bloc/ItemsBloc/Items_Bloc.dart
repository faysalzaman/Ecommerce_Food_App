// ignore_for_file: file_names

import 'package:food_ecommerce_app/Bloc/ItemsBloc/Items_States_Events.dart';
import 'package:food_ecommerce_app/Controller/items/ItemsController.dart';
import 'package:food_ecommerce_app/Model/Items/FoodsByCategoryModel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemsBloc extends Bloc<ItemsEvent, ItemsState> {
  ItemsBloc() : super(ItemsInitial()) {
    on<FetchItems>(
      (event, emit) async {
        emit(ItemsLoading());
        try {
          List<FoodsByCategoryModel> data =
              await ItemController.getRandomFiveItems();
          emit(ItemsLoaded(randomFiveItemsModel: data));
        } catch (e) {
          if (e.toString().contains("SocketException")) {
            emit(ItemsError(error: "No Internet Connection"));
            return;
          }
          emit(ItemsError(error: e.toString().replaceAll("Exception:", "")));
        }
      },
    );
  }
}
