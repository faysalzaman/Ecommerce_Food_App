// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, unused_element

import 'package:awesome_drawer_bar/awesome_drawer_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_ecommerce_app/Bloc/UserDetials/UserDetails_Bloc.dart';
import 'package:food_ecommerce_app/Bloc/UserDetials/UserDetails_States_Events.dart';
import 'package:velocity_x/velocity_x.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  final _drawerController = AwesomeDrawerBarController();

  // _drawerController.open();
  // _drawerController.close();
  // _drawerController.toggle();
  // _drawerController.isOpen();
  // _drawerController.stateNotifier;

  @override
  Widget build(BuildContext context) {
    return AwesomeDrawerBar(
      controller: _drawerController,
      type: StyleState.scaleBottom,
      menuScreen: Container(
        width: MediaQuery.of(context).size.width * .9,
        color: Colors.white,
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 1,
              child: CachedNetworkImage(
                imageUrl:
                    "https://w0.peakpx.com/wallpaper/565/109/HD-wallpaper-vintage-ink-food-background-material-food-background-food-background-hand-drawn-lettering.jpg",
                fit: BoxFit.fill,
                repeat: ImageRepeat.noRepeat,
              ),
            ),
            BlocBuilder<UserDetailsBloc, UserDetailsState>(
              builder: (context, state) {
                return Positioned(
                  top: context.screenHeight * .3,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: state is UserDetailsStateSuccess
                      ? Column(
                          children: [
                            CircleAvatar(
                              radius: 100,
                              backgroundImage: CachedNetworkImageProvider(
                                state.userDetailsModel.data!.profileImage!,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              state.userDetailsModel.data!.fullname ?? '',
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "Contact Us: ${state.userDetailsModel.data!.phone ?? ''}",
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "Address: ${state.userDetailsModel.data!.address ?? ''}",
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        )
                      : Container(),
                );
              },
            ),
          ],
        ),
      ),
      borderRadius: 24.0,
      showShadow: false,
      isRTL: false,
      backgroundColor: Colors.black12,
      slideWidth: MediaQuery.of(context).size.width * .65,
      openCurve: Curves.easeInCubic,
      closeCurve: Curves.bounceIn,
      mainScreen: Container(),
    );
  }
}
