// ignore_for_file: file_names

import 'package:food_ecommerce_app/Bloc/Cart/cart_bloc.dart';
import 'package:food_ecommerce_app/Screens/Cart/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppBarWidget extends StatefulWidget {
  const AppBarWidget({
    super.key,
  });

  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  String userId = '';

  Future<String> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String usrId = prefs.getString("userId").toString();
    setState(() {
      userId = usrId;
    });
    return userId;
  }

  @override
  void initState() {
    super.initState();
    getUserId();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        'Food App',
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Colors.white,
      elevation: 0,
      actions: [
        BlocBuilder<CartBloc, CartState>(
          bloc: context.read<CartBloc>()
            ..add(GetCartByIdEvent(userId, "1", "10")),
          builder: (context, state) {
            if (state is GetCartByIdLoadedState) {
              return Badge(
                alignment: Alignment.topRight,
                backgroundColor: Colors.red,
                isLabelVisible: true,
                label: Text(state.cartList.length.toString()),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CartScreen(),
                      ),
                    );
                  },
                  child: const Icon(
                    Icons.shopping_cart_outlined,
                    color: Colors.black,
                  ),
                ),
              );
            }
            return Badge(
              alignment: Alignment.topRight,
              backgroundColor: Colors.red,
              isLabelVisible: true,
              label: const Text("0"),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CartScreen(),
                    ),
                  );
                },
                child: const Icon(
                  Icons.shopping_cart_outlined,
                  color: Colors.black,
                ),
              ),
            );
          },
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey[100],
          ),
          child: const CircleAvatar(
            backgroundImage: AssetImage(
              "assets/appLogo.jpg",
            ),
          ),
        ),
      ],
    );
  }
}
