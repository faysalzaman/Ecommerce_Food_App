// ignore_for_file: file_names

import 'package:flutter/material.dart';

class AppSnakeBar {
  static void showSnakeBar(
    BuildContext context,
    Widget content,
    Color color,
    int duration,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: content,
        duration: const Duration(seconds: 3),
        backgroundColor: color,
        elevation: 10,
        // margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        behavior: SnackBarBehavior.floating,
        // showCloseIcon: true,
        action: SnackBarAction(
          label: "Close",
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
        // show the snackbar from the top
      ),
    );
  }
}
