// ignore_for_file: file_names

import 'package:food_ecommerce_app/Model/Items/FoodsByCategoryModel.dart';

abstract class ItemsEvent {}

class FetchItems extends ItemsEvent {}

abstract class ItemsState {}

class ItemsInitial extends ItemsState {}

class ItemsLoading extends ItemsState {}

class ItemsLoaded extends ItemsState {
  final List<FoodsByCategoryModel> randomFiveItemsModel;

  ItemsLoaded({required this.randomFiveItemsModel});
}

class ItemsError extends ItemsState {
  final String error;

  ItemsError({required this.error});
}
