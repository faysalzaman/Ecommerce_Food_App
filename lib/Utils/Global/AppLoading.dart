// ignore_for_file: file_names, non_constant_identifier_names

import 'package:food_ecommerce_app/Utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

Future AppLoading(BuildContext context) async {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return const Dialog(
        child: SizedBox(
          height: 100,
          width: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SpinKitFadingCircle(
                color: AppColors.primaryColor,
                size: 50.0,
              ),
              SizedBox(width: 20),
              Text("Loading"),
            ],
          ),
        ),
      );
    },
  );
}
