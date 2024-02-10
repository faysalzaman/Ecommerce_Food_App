import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_ecommerce_app/Controller/Story/story_controller.dart';
import 'package:food_ecommerce_app/Model/Story/FetchStoryModel.dart';
import 'package:nb_utils/nb_utils.dart';

part 'story_states_events.dart';

class StoryBloc extends Bloc<StoryEvent, StoryState> {
  StoryBloc() : super(StoryInitialState()) {
    on<StoryEvent>(
      (event, emit) async {
        if (event is FetchStoryEvent) {
          emit(StoryLoadingState());
          try {
            if (await isNetworkAvailable() == false) {
              emit(StoryErrorState(message: "No Internet Connection"));
              return;
            }
            List<FetchStoryModel> storyModel =
                await StoryController.getOrderItemsByOrderId("orderId");
            emit(StoryLoadedState(storyModel: storyModel));
          } catch (e) {
            emit(StoryErrorState(message: e.toString()));
          }
        }

        if (event is SawStoryEvent) {
          emit(StorySawLoadingState());
          try {
            if (await isNetworkAvailable() == false) {
              emit(StorySawErrorState(message: "No Internet Connection"));
              return;
            }
            await StoryController.getStory(event.storyId);
            emit(SawStoryState(message: "Story Saw"));
          } catch (e) {
            emit(StorySawErrorState(message: e.toString()));
          }
        }
      },
    );
  }
}
