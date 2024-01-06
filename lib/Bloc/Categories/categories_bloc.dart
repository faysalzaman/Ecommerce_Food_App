import 'package:food_ecommerce_app/Bloc/Categories/categories_states_events.dart';
import 'package:food_ecommerce_app/Controller/Category/categories_controller.dart';
import 'package:food_ecommerce_app/Model/Items/FoodsByCategoryModel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  int page = 1;
  int pageSize = 10;

  CategoriesBloc() : super(CategoriesInitialState()) {
    on<CategoriesFetchEvent>(
      (event, emit) async {
        emit(CategoriesLoadingState());
        try {
          var categoriesModel = await CategoriesController.getAllCategories();
          emit(CategoriesLoadedState(categories: categoriesModel));
        } catch (e) {
          if (e.toString().contains("SocketException")) {
            emit(CategoriesErrorState(message: "No Internet Connection"));
            return;
          }
          emit(CategoriesErrorState(
              message: e.toString().replaceAll("Exception:", "")));
        }
      },
    );

    on<FetchCategoryInitialEvent>(
      (event, emit) async {
        emit(FetchCategoryLoadingState());
        try {
          List<FoodsByCategoryModel> categoriesModel =
              await CategoriesController.categoryById(event.id, '1', '6');
          emit(FetchCategoryLoadedState(categories: categoriesModel));
        } catch (e) {
          if (e.toString().contains("SocketException")) {
            emit(FetchCategoryErrorState(message: "No Internet Connection"));
            return;
          }
          emit(FetchCategoryErrorState(
              message: e.toString().replaceAll("Exception:", "")));
        }
      },
    );

    on<FetchCategoryLoadMoreEvent>(
      (event, emit) async {
        emit(FetchCategoryLoadMoreLoading());
        try {
          List<FoodsByCategoryModel> categoriesModel =
              await CategoriesController.categoryById(
            event.id,
            '$page',
            '$pageSize',
          );
          emit(FetchCategoryLoadMoreState(categories: categoriesModel));
        } catch (e) {
          if (e.toString().contains("SocketException")) {
            emit(FetchCategoryErrorState(message: "No Internet Connection"));
            return;
          }
          emit(FetchCategoryErrorState(
              message: e.toString().replaceAll("Exception:", "")));
        }
      },
    );
  }
}
