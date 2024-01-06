// ignore_for_file: file_names

import 'package:image_picker/image_picker.dart';

abstract class CompleteProfileEvent {}

class CompleteProfileButtonClickEvent extends CompleteProfileEvent {
  String fullName;
  String phoneNo;
  XFile image;

  CompleteProfileButtonClickEvent({
    required this.fullName,
    required this.phoneNo,
    required this.image,
  });
}

abstract class CompleteProfileState {}

class CompleteProfileInitialState extends CompleteProfileState {}

class CompleteProfileLoadingState extends CompleteProfileState {}

class CompleteProfileSuccessState extends CompleteProfileState {}

class CompleteProfileFailureState extends CompleteProfileState {
  final String error;

  CompleteProfileFailureState({required this.error});
}
