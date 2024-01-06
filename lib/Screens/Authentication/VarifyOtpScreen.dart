// ignore_for_file: file_names, must_be_immutable

import 'package:food_ecommerce_app/Bloc/SendOtp/SendOtp_Events_States.dart';
import 'package:food_ecommerce_app/Bloc/SendOtp/SendOtp_bloc.dart';
import 'package:food_ecommerce_app/Screens/Authentication/LoginScreen.dart';
import 'package:food_ecommerce_app/Utils/Global/AppLoading.dart';
import 'package:food_ecommerce_app/Widgets/ButtonWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pinput/pinput.dart';

class VarifyOtpScreen extends StatefulWidget {
  String email;

  VarifyOtpScreen({super.key, required this.email});

  @override
  State<VarifyOtpScreen> createState() => _VarifyOtpScreenState();
}

class _VarifyOtpScreenState extends State<VarifyOtpScreen> {
  /// Create Controller
  final pinController = TextEditingController();

  SendOtpBloc sendOtpBloc = SendOtpBloc();

  @override
  void initState() {
    super.initState();

    sendOtpBloc.add(SendOtpEventInit(email: widget.email));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<SendOtpBloc, SendOtpState>(
        bloc: sendOtpBloc,
        listener: (context, state) {
          if (state is SendOtpLoadingState) {
            AppLoading(context);
          } else if (state is SendOtpSuccessState) {
            pinController.setText(state.otp);
            Navigator.pop(context);
          } else if (state is SendOtpErrorState) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: SafeArea(
          child: Container(
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height - 50,
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      const Text(
                        "Varify OTP",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Enter OTP sent to your email",
                        style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
                  Pinput(
                    androidSmsAutofillMethod: AndroidSmsAutofillMethod.none,
                    controller: pinController,
                  ),
                  const SizedBox(height: 50),
                  BlocListener<SendOtpBloc, SendOtpState>(
                    bloc: sendOtpBloc,
                    listener: (context, state) {
                      if (state is VarifyOtpLoadingState) {
                        AppLoading(context);
                      } else if (state is VarifyOtpSuccessState) {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.fade,
                            child: LoginPage(),
                          ),
                        );
                      } else if (state is VarifyOtpErrorState) {
                        Navigator.pop(context);
                        toast(state.error);
                        return;
                      }
                    },
                    child: ButtonWidget(
                      text: "Varify Otp",
                      onPressed: () {
                        if (pinController.text.isEmpty) {
                          toast("Please enter otp");
                          return;
                        }
                        sendOtpBloc.add(
                          VarifyOtpEvent(
                            email: widget.email,
                            otp: pinController.text,
                          ),
                        );
                      },
                      color: Colors.greenAccent,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
