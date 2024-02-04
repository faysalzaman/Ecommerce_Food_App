// ignore_for_file: file_names

import 'package:food_ecommerce_app/Bloc/UserDetials/UserDetails_Bloc.dart';
import 'package:food_ecommerce_app/Bloc/UserDetials/UserDetails_States_Events.dart';
import 'package:food_ecommerce_app/Screens/Favorite/favorite_screen.dart';
import 'package:food_ecommerce_app/Screens/HomeScreen/HomeScreen.dart';
import 'package:food_ecommerce_app/Screens/OdersHistory/orders_history_screen.dart';
import 'package:food_ecommerce_app/Screens/UserDetails/UserDetailsScreen.dart';
import 'package:flutter/material.dart';
import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';
import 'package:iconly/iconly.dart';

enum _SelectedTab { home, favorite, orders, search, person }

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  var _selectedTab = _SelectedTab.home;

  var pages = [
    HomeScreen(
        userDetailsBloc: UserDetailsBloc()..add(UserDetailsEventFetch())),
    const FavoriteScreen(),
    const OrdersHistoryScreen(),
    Container(color: Colors.yellow),
    UserDetailsScreen(
      userDetailsBloc: UserDetailsBloc()..add(UserDetailsEventFetch()),
    ),
  ];

  void _handleIndexChanged(int i) {
    setState(() {
      _selectedTab = _SelectedTab.values[i];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: pages[_SelectedTab.values.indexOf(_selectedTab)],
      bottomNavigationBar: CrystalNavigationBar(
        duration: const Duration(milliseconds: 500),
        currentIndex: _SelectedTab.values.indexOf(_selectedTab),
        unselectedItemColor: Colors.greenAccent,
        backgroundColor: Colors.grey.shade50,
        onTap: _handleIndexChanged,
        indicatorColor: Colors.greenAccent,
        enableFloatingNavBar: false,
        enablePaddingAnimation: true,
        selectedItemColor: Colors.black,
        margin: const EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 0),
        borderRadius: 20,
        items: [
          /// Home
          CrystalNavigationBarItem(
            icon: IconlyBold.home,
            unselectedIcon: IconlyLight.home,
            selectedColor: Colors.green,
          ),

          /// Favourite
          CrystalNavigationBarItem(
            icon: IconlyBold.heart,
            unselectedIcon: IconlyLight.heart,
            selectedColor: Colors.red,
          ),

          /// Orders
          CrystalNavigationBarItem(
            icon: Icons.shopping_bag,
            unselectedIcon: Icons.shopping_bag_outlined,
            selectedColor: Colors.green,
          ),

          /// Search
          CrystalNavigationBarItem(
              icon: IconlyBold.search,
              unselectedIcon: IconlyLight.search,
              selectedColor: Colors.green),

          /// Profile
          CrystalNavigationBarItem(
            icon: IconlyBold.profile,
            unselectedIcon: IconlyLight.user,
            selectedColor: Colors.green,
          ),
        ],
      ),
    );
  }
}

class CustomShape extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    double curveHeight = 20.0; // Adjust this value to change the curve height

    path.moveTo(0, curveHeight);
    path.quadraticBezierTo(
        size.width / 4, 0, size.width / 2, 0); // Adjust the curve as needed
    path.quadraticBezierTo(size.width * 3 / 4, 0, size.width, curveHeight);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
