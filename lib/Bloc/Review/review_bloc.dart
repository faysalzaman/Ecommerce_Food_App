import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_ecommerce_app/Controller/Review/review_controller.dart';
import 'package:food_ecommerce_app/Model/Review/get_all_review_model.dart';
import 'package:nb_utils/nb_utils.dart';

part 'review_states_events.dart';

class ReviewBloc extends Bloc<ReviewEvent, ReviewState> {
  ReviewBloc() : super(ReviewInitialState()) {
    on<ReviewEvent>(
      (event, emit) async {
        if (event is PostReviews) {
          emit(ReviewLoadingState());
          try {
            if (await isNetworkAvailable() == false) {
              emit(ReviewErrorState("No Internet Connection"));
              return;
            }
            await ReviewController.postReview(
              event.userId,
              event.foodId,
              event.text,
            );
            emit(ReviewLoadedState());
          } catch (e) {
            emit(ReviewErrorState(e.toString().replaceAll("Exception:", "")));
          }
        }

        if (event is FetchReviewEvent) {
          emit(ReviewLoadingState());
          try {
            if (await isNetworkAvailable() == false) {
              emit(ReviewErrorState("No Internet Connection"));
              return;
            }
            List<GetAllReviewModel> review = [];
            final res = await ReviewController.getAllReview(
              event.foodId,
              event.page,
              event.pageSize,
            );

            review = res.data;

            emit(FetchReviewLoadedState(review));
          } catch (e) {
            emit(
              FetchReviewErrorState(e.toString().replaceAll("Exception:", "")),
            );
          }
        }

        if (event is ReviewLengthEvent) {
          emit(ReviewLengthLoadingState());
          try {
            final res = await ReviewController.getLengthReview(event.foodId);
            emit(ReviewLengthLoadedState(res.data));
          } catch (e) {
            emit(ReviewLengthErrorState(0));
          }
        }
      },
    );
  }
}
