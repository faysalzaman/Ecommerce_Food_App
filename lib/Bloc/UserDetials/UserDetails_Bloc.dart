// ignore_for_file: file_names

import 'package:food_ecommerce_app/Bloc/UserDetials/UserDetails_States_Events.dart';
import 'package:food_ecommerce_app/Controller/UserDetails/UserDetailsController.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserDetailsBloc extends Bloc<UserDetailsEvent, UserDetailsState> {
  UserDetailsBloc() : super(UserDetailsStateInitialState()) {
    on<UserDetailsEventFetch>(
      (event, emit) async {
        emit(UserDetailsStateLoading());
        try {
          var userDetailsModel = await UserDetailsController.fetchUserDetails();
          emit(UserDetailsStateSuccess(userDetailsModel));
        } catch (e) {
          if (e.toString().contains("SocketException")) {
            emit(UserDetialsStateError("No Internet Connection"));
            return;
          }
          emit(
              UserDetialsStateError(e.toString().replaceAll("Exception:", "")));
        }
      },
    );
  }
}
