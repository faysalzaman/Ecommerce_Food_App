// ignore_for_file: use_key_in_widget_constructors

import 'package:food_ecommerce_app/Bloc/AuthBloc/Auth_Bloc.dart';
import 'package:food_ecommerce_app/Bloc/AuthBloc/Auth_Events_States.dart';
import 'package:food_ecommerce_app/Screens/Authentication/CompleteProfileScreen.dart';
import 'package:food_ecommerce_app/Screens/TabsScreen/TabsScreen.dart';
import 'package:food_ecommerce_app/Utils/Global/AppLoading.dart';
import 'package:food_ecommerce_app/Widgets/ButtonWidget.dart';
import 'package:food_ecommerce_app/Widgets/TextFieldWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:page_transition/page_transition.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  AuthBloc loginBloc = AuthBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
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
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Login to your account",
                    style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
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
                  ],
                ),
              ),
              const SizedBox(height: 20),
              BlocListener<AuthBloc, AuthState>(
                bloc: loginBloc,
                listener: (context, state) {
                  if (state is LoginLoading) {
                    AppLoading(context);
                  } else if (state is LoginSuccess) {
                    Navigator.pop(context);
                    (state.isNewUser.toString() == "true")
                        ? Navigator.pushReplacement(
                            context,
                            PageTransition(
                              type: PageTransitionType.fade,
                              child: const CompleteProfileScreen(),
                            ),
                          )
                        : Navigator.pushReplacement(
                            context,
                            PageTransition(
                              type: PageTransitionType.fade,
                              child: const TabsScreen(),
                            ),
                          );
                  } else if (state is LoginFailure) {
                    Navigator.pop(context);
                    toast(state.error);
                  }
                },
                child: ButtonWidget(
                  text: "Login",
                  onPressed: () {
                    if (emailController.text.isEmpty &&
                        passwordController.text.isEmpty) {
                      FocusScope.of(context).unfocus();
                      return;
                    }
                    if (emailController.text.isEmpty ||
                        passwordController.text.isEmpty) {
                      toast("Please fill all the fields");
                      return;
                    }

                    loginBloc.add(
                      LoginButtonPressedEvent(
                        email: emailController.text.trim(),
                        password: passwordController.text.trim(),
                      ),
                    );
                  },
                  color: Colors.greenAccent,
                ),
              ),
              // const SizedBox(height: 10),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: <Widget>[
              //     const Text("Don't have an account?"),
              //     GestureDetector(
              //       onTap: () {
              //         Navigator.of(context).pushReplacement(
              //           MaterialPageRoute(
              //             builder: (context) => const SignupPage(),
              //           ),
              //         );
              //       },
              //       child: const Text(
              //         " Sign up",
              //         style: TextStyle(
              //             fontWeight: FontWeight.w600, fontSize: 18),
              //       ),
              //     ),
              //   ],
              // ),
              // const Spacer(),
              // Container(
              //   height: MediaQuery.of(context).size.height / 4,
              //   decoration: const BoxDecoration(
              //     image: DecorationImage(
              //       image: AssetImage('assets/background.png'),
              //       fit: BoxFit.fill,
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
