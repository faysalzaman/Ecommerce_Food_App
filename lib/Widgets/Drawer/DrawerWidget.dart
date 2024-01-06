// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, unused_element

import 'package:awesome_drawer_bar/awesome_drawer_bar.dart';
import 'package:flutter/material.dart';

class DrawerWidget extends StatefulWidget {
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
      slideHeight: MediaQuery.of(context).size.height * .75,
      type: StyleState.scaleBottom,
      menuScreen: Container(
        width: MediaQuery.of(context).size.width * .85,
        color: Colors.white,
        child: const Center(
          child: Text(
            'Menu Screen',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      mainScreen: Container(
          // color: Colors.black,
          // child: Center(
          //   child: Text(
          //     'Home Screen',
          //     style: TextStyle(
          //       fontSize: 24,
          //       fontWeight: FontWeight.bold,
          //     ),
          //   ),
          // ),
          ),
      borderRadius: 24.0,
      showShadow: false,
      angle: -12.0,
      isRTL: false,
      backgroundColor: Colors.black12,
      slideWidth: MediaQuery.of(context).size.width * .65,
      openCurve: Curves.easeInCubic,
      closeCurve: Curves.bounceIn,
    );
  }
}
