// ignore_for_file: file_names, avoid_print

import 'package:food_ecommerce_app/Bloc/AuthBloc/Auth_Events_States.dart';
import 'package:food_ecommerce_app/Controller/Auth/AuthController.dart';
import 'package:food_ecommerce_app/Model/Auth/LoginModel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(SignupInitial()) {
    // Signup
    on<SignupButtonPressedEvent>(
      (event, emit) async {
        emit(SignupLoading());
        try {
          await AuthController.signUp(event.email, event.password);
          emit(SignupSuccess());
        } catch (e) {
          if (e.toString().contains("SocketException")) {
            emit(SignupFailure(error: "No Internet Connection"));
            return;
          }
          emit(SignupFailure(error: e.toString().replaceAll("Exception:", "")));
        }
      },
    );
    // Login
    on<LoginButtonPressedEvent>(
      (event, emit) async {
        emit(LoginLoading());
        try {
          LoginModel response =
              await AuthController.login(event.email, event.password);

          String isNewUser = response.data!.isNewUser.toString();

          print(isNewUser);

          emit(LoginSuccess(isNewUser: isNewUser));
        } catch (e) {
          if (e.toString().contains("SocketException")) {
            emit(LoginFailure(error: "No Internet Connection"));
            return;
          }
          emit(LoginFailure(error: e.toString().replaceAll("Exception:", "")));
        }
      },
    );
    // Refresh
    on<RefreshSuccessEvent>(
      (event, emit) async {
        emit(RefreshLoadingState());
        try {
          bool response = await AuthController.refreshToken();
          emit(RefreshSuccessState(token: response));
        } catch (e) {
          if (e.toString().contains("SocketException")) {
            emit(RefreshFailureState(msg: "No Internet Connection"));
            return;
          }
          emit(LoginFailure(error: e.toString().replaceAll("Exception:", "")));
        }
      },
    );
  }
}
