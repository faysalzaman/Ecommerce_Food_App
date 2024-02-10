// ignore_for_file: avoid_print

import 'package:food_ecommerce_app/Bloc/AuthBloc/Auth_Bloc.dart';
import 'package:food_ecommerce_app/Bloc/AuthBloc/Auth_Events_States.dart';
import 'package:food_ecommerce_app/Utils/Global/AppLoading.dart';
import 'package:food_ecommerce_app/Screens/Authentication/VarifyOtpScreen.dart';
import 'package:food_ecommerce_app/Utils/constants.dart';
import 'package:food_ecommerce_app/Widgets/ButtonWidget.dart';
import 'package:food_ecommerce_app/Widgets/TextFieldWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:page_transition/page_transition.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }

  AuthBloc signupBloc = AuthBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.greenAccent[100],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
        ),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(
              top: BorderSide(
                color: Colors.black,
                width: 0.5,
              ),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 10.0,
              ),
            ],
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    children: <Widget>[
                      const Text(
                        "Sign up",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Create an account, It's free",
                        style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Column(
                  children: <Widget>[
                    TextFieldWidget(
                      text: "Email",
                      hint: "Enter email",
                      obscureText: false,
                      controller: emailController,
                    ),
                    TextFieldWidget(
                      text: "Password",
                      hint: "Enter password",
                      obscureText: true,
                      controller: passwordController,
                    ),
                    TextFieldWidget(
                      text: "Confirm Password",
                      hint: "Enter password",
                      obscureText: true,
                      controller: confirmPasswordController,
                    ),
                  ],
                ),
                BlocListener<AuthBloc, AuthState>(
                  bloc: signupBloc,
                  listener: (context, state) {
                    if (state is SignupSuccess) {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.fade,
                          child: VarifyOtpScreen(
                            email: emailController.text.trim(),
                          ),
                        ),
                      );
                      return;
                    }
                    if (state is SignupFailure) {
                      Navigator.pop(context);
                      toast(state.error);
                      return;
                    }
                    if (state is SignupLoading) {
                      AppLoading(context);
                    }
                  },
                  child: ButtonWidget(
                    color: AppColors.primaryColor,
                    text: "Signup",
                    onPressed: () {
                      if (emailController.text.isEmpty &&
                          passwordController.text.isEmpty &&
                          confirmPasswordController.text.isEmpty) {
                        // hide keyboard
                        FocusScope.of(context).unfocus();
                        return;
                      } else if (passwordController.text !=
                          confirmPasswordController.text) {
                        toast("Password and Confirm-Password should be same");
                        return;
                      }
                      signupBloc.add(
                        SignupButtonPressedEvent(
                          email: emailController.text,
                          password: passwordController.text,
                        ),
                      );
                    },
                  ),
                ),
                // Expanded(
                //   child: Container(
                //     height: MediaQuery.of(context).size.height / 4,
                //     decoration: const BoxDecoration(
                //       image: DecorationImage(
                //         image: AssetImage('assets/background.png'),
                //         fit: BoxFit.fill,
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
