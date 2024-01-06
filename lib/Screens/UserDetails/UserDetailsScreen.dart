// ignore_for_file: file_names, must_be_immutable, avoid_unnecessary_containers, non_constant_identifier_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:food_ecommerce_app/Bloc/UserDetials/UserDetails_Bloc.dart';
import 'package:food_ecommerce_app/Bloc/UserDetials/UserDetails_States_Events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:velocity_x/velocity_x.dart';

class UserDetailsScreen extends StatefulWidget {
  UserDetailsBloc userDetailsBloc;

  UserDetailsScreen({
    super.key,
    required this.userDetailsBloc,
  });

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: BlocBuilder<UserDetailsBloc, UserDetailsState>(
          bloc: widget.userDetailsBloc,
          builder: (context, state) {
            if (state is UserDetailsStateSuccess) {
              return UserInfoWidget(
                userDetailsBloc: widget.userDetailsBloc,
                image: state.userDetailsModel.data!.profileImage.toString(),
                fullName: state.userDetailsModel.data!.fullname.toString(),
                phoneNo: state.userDetailsModel.data!.phone.toString(),
              );
            } else if (state is UserDetailsStateLoading) {
              return UserInfoWidgetShimmer();
            }
            return Container();
          },
        ),
      ),
    );
  }
}

UserInfoWidgetShimmer() {
  return Container(
    alignment: Alignment.center,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 200,
          width: 200,
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(100),
          ),
        ).shimmer(
          secondaryColor: Colors.white,
        ),
        20.height,
        Container(
          height: 20,
          width: 200,
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(10),
          ),
        ).shimmer(
          secondaryColor: Colors.white,
        ),
        10.height,
        Container(
          height: 20,
          width: 200,
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(10),
          ),
        ).shimmer(
          secondaryColor: Colors.white,
        ),
      ],
    ),
  );
}

class UserInfoWidget extends StatelessWidget {
  UserDetailsBloc userDetailsBloc;
  String image;
  String phoneNo;
  String fullName;

  UserInfoWidget({
    super.key,
    required this.userDetailsBloc,
    required this.image,
    required this.phoneNo,
    required this.fullName,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircleAvatar(
            radius: 100,
            backgroundImage: CachedNetworkImageProvider(image),
          ),
          const SizedBox(height: 20),
          Text(
            fullName,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            phoneNo,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
