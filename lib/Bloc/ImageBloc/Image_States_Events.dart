import 'package:image_picker/image_picker.dart';

abstract class ImageEvent {}

class ImageLoadEvent extends ImageEvent {}

abstract class ImageState {}

class ImageInitialState extends ImageState {}

class ImageLoadingState extends ImageState {}

class ImageSuccessState extends ImageState {
  XFile imageUrl;

  ImageSuccessState({required this.imageUrl});
}

class ImageErrorState extends ImageState {
  String error;

  ImageErrorState({required this.error});
}
