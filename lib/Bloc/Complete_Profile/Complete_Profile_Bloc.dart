// ignore_for_file: file_names

import 'package:food_ecommerce_app/Bloc/Complete_Profile/Complete_Profile_States_Events.dart';
import 'package:food_ecommerce_app/Controller/Auth/AuthController.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CompleteProfileBloc
    extends Bloc<CompleteProfileEvent, CompleteProfileState> {
  CompleteProfileBloc() : super(CompleteProfileInitialState()) {
    on<CompleteProfileButtonClickEvent>(
      (event, emit) async {
        emit(CompleteProfileLoadingState());
        try {
          await AuthController.completeProfile(
            event.fullName,
            event.phoneNo,
            event.image,
          );
          emit(CompleteProfileSuccessState());
        } catch (e) {
          if (e.toString().contains("SocketException")) {
            emit(CompleteProfileFailureState(error: "No Internet Connection"));
            return;
          }
          emit(CompleteProfileFailureState(
              error: e.toString().replaceAll("Exception:", "")));
        }
      },
    );
  }
}
