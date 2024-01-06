import 'package:food_ecommerce_app/Model/Category/AllCategoriesModel.dart';
import 'package:food_ecommerce_app/Model/Items/FoodsByCategoryModel.dart';

abstract class CategoriesEvent {}

class CategoriesFetchEvent extends CategoriesEvent {}

abstract class CategoriesState {}

class CategoriesInitialState extends CategoriesState {}

class CategoriesLoadingState extends CategoriesState {}

class CategoriesLoadedState extends CategoriesState {
  AllCategoriesModel categories;

  CategoriesLoadedState({required this.categories});
}

class CategoriesErrorState extends CategoriesState {
  String message;

  CategoriesErrorState({required this.message});
}

class FetchCategoryInitialEvent extends CategoriesEvent {
  String id;

  FetchCategoryInitialEvent({required this.id});
}

class FetchCategoryLoadMoreEvent extends CategoriesEvent {
  String id;
  String page;
  String pageSize;

  FetchCategoryLoadMoreEvent({
    required this.id,
    required this.page,
    required this.pageSize,
  });
}

class FetchCategoryInitialState extends CategoriesState {}

class FetchCategoryLoadingState extends CategoriesState {}

class FetchCategoryLoadMoreLoading extends CategoriesState {}

class FetchCategoryLoadedState extends CategoriesState {
  List<FoodsByCategoryModel> categories;

  FetchCategoryLoadedState({required this.categories});
}

class FetchCategoryLoadMoreState extends CategoriesState {
  List<FoodsByCategoryModel> categories;

  FetchCategoryLoadMoreState({required this.categories});
}

class FetchCategoryErrorState extends CategoriesState {
  String message;

  FetchCategoryErrorState({required this.message});
}
