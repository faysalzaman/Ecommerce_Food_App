// ignore_for_file: file_names, avoid_print

import 'package:food_ecommerce_app/Bloc/Cart/cart_bloc.dart';
import 'package:food_ecommerce_app/Controller/Auth/AuthController.dart';
import 'package:food_ecommerce_app/Screens/Authentication/LoginSignupHomeScreen.dart';
import 'package:food_ecommerce_app/Screens/TabsScreen/TabsScreen.dart';
import 'package:food_ecommerce_app/Utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool? isTrue;

  CartBloc cartBloc = CartBloc();

  Future<String> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString("userId").toString();
    return userId;
  }

  @override
  void initState() {
    super.initState();
    getUserId().then(
      (value) {
        cartBloc.add(
          GetCartByIdEvent(value, "1", "10"),
        );
      },
    );
    Future.delayed(
      const Duration(seconds: 3),
      () async {
        AuthController.refreshToken().then((value) {
          Navigator.push(
              context,
              PageTransition(
                  child: const TabsScreen(), type: PageTransitionType.fade));
        }).onError((error, stackTrace) {
          Navigator.push(
              context,
              PageTransition(
                  child: loginSignupHome(), type: PageTransitionType.fade));
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/appLogo.jpg',
              height: MediaQuery.of(context).size.height * 0.5,
              width: MediaQuery.of(context).size.width * 1,
            ),
            const SizedBox(height: 20),
            const CircularProgressIndicator(color: AppColors.primaryColor),
            const SizedBox(height: 20),
            const Text(
              "Designed By \"FEW Team\"",
              style: TextStyle(
                color: AppColors.primaryColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
