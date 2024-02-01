part of 'review_bloc.dart';

abstract class ReviewEvent {}

class PostReviews extends ReviewEvent {
  final String foodId;
  final String userId;
  final String text;

  PostReviews({
    required this.foodId,
    required this.userId,
    required this.text,
  });
}

abstract class ReviewState {}

class ReviewInitialState extends ReviewState {}

class ReviewLoadingState extends ReviewState {}

class ReviewLoadedState extends ReviewState {}

class ReviewErrorState extends ReviewState {
  final String message;

  ReviewErrorState(this.message);
}

class FetchReviewEvent extends ReviewEvent {
  final String foodId;
  final String page;
  final String pageSize;

  FetchReviewEvent({
    required this.foodId,
    required this.page,
    required this.pageSize,
  });
}

class FetchReviewLoadedState extends ReviewState {
  final List<GetAllReviewModel> review;

  FetchReviewLoadedState(this.review);
}

class FetchReviewErrorState extends ReviewState {
  final String message;

  FetchReviewErrorState(this.message);
}

class ReviewLengthEvent extends ReviewEvent {
  final String foodId;

  ReviewLengthEvent(this.foodId);
}

class ReviewLengthLoadingState extends ReviewState {}

class ReviewLengthLoadedState extends ReviewState {
  final int length;

  ReviewLengthLoadedState(this.length);
}

class ReviewLengthErrorState extends ReviewState {
  final int length;

  ReviewLengthErrorState(this.length);
}
