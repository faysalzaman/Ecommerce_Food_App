// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class ButtonWidget extends StatefulWidget {
  String? text;
  Color? color;
  void Function() onPressed;
  Widget? child;

  ButtonWidget({
    super.key,
    this.color,
    this.text,
    required this.onPressed,
    this.child,
  });

  @override
  State<ButtonWidget> createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.only(
          top: 3,
          left: 3,
          bottom: 4,
          right: 3,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          border: const Border(
            bottom: BorderSide(color: Colors.black),
            top: BorderSide(color: Colors.black),
            left: BorderSide(color: Colors.black),
            right: BorderSide(color: Colors.black),
          ),
        ),
        child: MaterialButton(
          minWidth: double.infinity,
          height: 60,
          onPressed: widget.onPressed,
          color: widget.color ?? Colors.yellow,
          elevation: 0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          child: widget.text == null
              ? widget.child
              : Text(
                  widget.text!,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
        ),
      ),
    );
  }
}
