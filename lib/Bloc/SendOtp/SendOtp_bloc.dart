// ignore_for_file: file_names

import 'package:food_ecommerce_app/Bloc/SendOtp/SendOtp_Events_States.dart';
import 'package:food_ecommerce_app/Controller/Auth/AuthController.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SendOtpBloc extends Bloc<SendOtpEvent, SendOtpState> {
  SendOtpBloc() : super(SendOtpInitialState()) {
    on<SendOtpEventInit>(
      (event, emit) async {
        emit(SendOtpLoadingState());
        try {
          String otp = await AuthController.sendOtp(event.email);
          emit(SendOtpSuccessState(otp: otp));
        } catch (e) {
          if (e.toString().contains("SocketException")) {
            emit(SendOtpErrorState(error: "No Internet Connection"));
            return;
          }
          emit(
            SendOtpErrorState(
              error: e.toString().replaceAll("Exception:", ""),
            ),
          );
        }
      },
    );
    on<VarifyOtpEvent>(
      (event, emit) async {
        emit(VarifyOtpLoadingState());
        try {
          await AuthController.varifyOtp(event.email, event.otp);
          emit(VarifyOtpSuccessState());
        } catch (e) {
          if (e.toString().contains("SocketException")) {
            emit(VarifyOtpErrorState(error: "No Internet Connection"));
            return;
          }
          emit(
            VarifyOtpErrorState(
              error: e.toString().replaceAll("Exception:", ""),
            ),
          );
        }
      },
    );
  }
}
