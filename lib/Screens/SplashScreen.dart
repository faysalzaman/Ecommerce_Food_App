// ignore_for_file: file_names, avoid_print

import 'package:cached_network_image/cached_network_image.dart';
import 'package:food_ecommerce_app/Bloc/Cart/cart_bloc.dart';
import 'package:food_ecommerce_app/Controller/Auth/AuthController.dart';
import 'package:food_ecommerce_app/Screens/Authentication/LoginSignupHomeScreen.dart';
import 'package:food_ecommerce_app/Screens/TabsScreen/TabsScreen.dart';
import 'package:food_ecommerce_app/Utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';

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
          Navigator.pushReplacement(
              context,
              PageTransition(
                  child: const TabsScreen(), type: PageTransitionType.fade));
        }).onError((error, stackTrace) {
          Navigator.pushReplacement(
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
      body: Stack(
        children: [
          SizedBox(
            width: context.screenWidth,
            height: context.screenHeight,
            child: CachedNetworkImage(
              imageUrl:
                  "https://w0.peakpx.com/wallpaper/565/109/HD-wallpaper-vintage-ink-food-background-material-food-background-food-background-hand-drawn-lettering.jpg",
              fit: BoxFit.fill,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/appLogo.png',
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.width * 0.5,
                ),
                const CircularProgressIndicator(
                    color: Color.fromARGB(255, 255, 0, 85)),
                const SizedBox(height: 20),
                const Text(
                  "Designed By \"FEW Team\"",
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 0, 85),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
