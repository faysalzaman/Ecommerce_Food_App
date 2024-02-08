import 'package:food_ecommerce_app/Bloc/Cart/cart_bloc.dart';
import 'package:food_ecommerce_app/Bloc/Categories/categories_bloc.dart';
import 'package:food_ecommerce_app/Bloc/Categories/categories_states_events.dart';
import 'package:food_ecommerce_app/Bloc/ItemsBloc/Items_Bloc.dart';
import 'package:food_ecommerce_app/Bloc/ItemsBloc/Items_States_Events.dart';
import 'package:food_ecommerce_app/Bloc/UserDetials/UserDetails_Bloc.dart';
import 'package:food_ecommerce_app/Bloc/UserDetials/UserDetails_States_Events.dart';
import 'package:food_ecommerce_app/Bloc/WishList/wish_list_bloc.dart';
import 'package:food_ecommerce_app/Screens/SplashScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CartBloc>(
          create: (context) => CartBloc(),
        ),
        BlocProvider<WishListBloc>(
          create: (context) => WishListBloc(),
        ),
        BlocProvider<ItemsBloc>(
          create: (context) => ItemsBloc()..add(FetchItems()),
        ),
        BlocProvider<CategoriesBloc>(
          create: (context) => CategoriesBloc()..add(CategoriesFetchEvent()),
        ),
        BlocProvider<UserDetailsBloc>(
          create: (context) => UserDetailsBloc()..add(UserDetailsEventFetch()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Food App',
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        themeMode: ThemeMode.light,
        // disable the orientation change
        home: OrientationBuilder(
          builder: (context, orientation) {
            return orientation == Orientation.portrait
                ? const SplashScreen()
                : const SplashScreen();
          },
        ),
      ),
    );
  }
}
