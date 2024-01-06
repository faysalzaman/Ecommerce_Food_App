// ignore_for_file: file_names

import 'package:food_ecommerce_app/Model/UserDetails/UserDetailsModel.dart';

abstract class UserDetailsEvent {}

class UserDetailsEventFetch extends UserDetailsEvent {}

abstract class UserDetailsState {}

class UserDetailsStateInitialState extends UserDetailsState {}

class UserDetailsStateLoading extends UserDetailsState {}

class UserDetailsStateSuccess extends UserDetailsState {
  final UserDetailsModel userDetailsModel;

  UserDetailsStateSuccess(this.userDetailsModel);
}

class UserDetialsStateError extends UserDetailsState {
  final String message;

  UserDetialsStateError(this.message);
}
