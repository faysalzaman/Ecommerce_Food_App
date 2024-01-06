part of 'foods_bloc.dart';

abstract class FoodsEvent {}

class FoodsGetByCategoryIdEvent extends FoodsEvent {
  final String id;
  final int page, paginatedBy;
  FoodsGetByCategoryIdEvent(this.page, this.paginatedBy, {required this.id});
}

class FoodsGetByCategoryIdMoreEvent extends FoodsEvent {
  final String id;
  final int page, paginatedBy;
  FoodsGetByCategoryIdMoreEvent(this.page, this.paginatedBy,
      {required this.id});
}

abstract class FoodsState {}

class FoodsInitial extends FoodsState {}

class FoodsLoading extends FoodsState {}

class FoodsLoaded extends FoodsState {
  final ApiResponse<List<FoodsByCategoryModel>> foods;
  FoodsLoaded({required this.foods});
}

class FoodsLoadingMore extends FoodsState {}

class FoodsError extends FoodsState {
  final String error;
  FoodsError({required this.error});
}


