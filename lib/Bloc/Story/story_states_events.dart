part of 'story_bloc.dart';

abstract class StoryEvent {}

class FetchStoryEvent extends StoryEvent {}

abstract class StoryState {}

class StoryInitialState extends StoryState {}

class StoryLoadingState extends StoryState {}

class StoryLoadedState extends StoryState {
  final List<FetchStoryModel> storyModel;
  StoryLoadedState({required this.storyModel});
}

class StoryErrorState extends StoryState {
  final String message;
  StoryErrorState({required this.message});
}

class SawStoryEvent extends StoryEvent {
  final String storyId;
  SawStoryEvent({required this.storyId});
}

class SawStoryState extends StoryState {
  final String message;
  SawStoryState({required this.message});
}

class StorySawErrorState extends StoryState {
  final String message;
  StorySawErrorState({required this.message});
}

class StorySawLoadingState extends StoryState {}
