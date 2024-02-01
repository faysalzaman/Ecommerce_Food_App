// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_ecommerce_app/Bloc/Cart/cart_bloc.dart';

class QuantityWidget extends StatefulWidget {
  QuantityWidget({
    super.key,
    required this.quantity,
    required this.cartBloc,
    required this.userId,
    required this.foodId,
  });

  int quantity;
  final CartBloc cartBloc;
  final String userId;
  final String foodId;

  @override
  State<QuantityWidget> createState() => _QuantityWidgetState();
}

class _QuantityWidgetState extends State<QuantityWidget> {
  CartBloc increaseItemBloc = CartBloc();
  CartBloc decreaseItemBloc = CartBloc();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        BlocConsumer<CartBloc, CartState>(
          bloc: decreaseItemBloc,
          listener: (context, state) {
            if (state is DecreaseQtyLoading) {
              setState(() {
                widget.quantity = widget.quantity - 1;
              });
            }
            if (state is DecreaseQtyErrorState) {
              setState(() {
                widget.quantity = widget.quantity + 1;
              });
            }
          },
          builder: (context, state) {
            return IconButton(
              onPressed: () {
                decreaseItemBloc.add(
                  DecreaseQtyEvent(
                    widget.userId,
                    widget.foodId,
                  ),
                );
              },
              icon: const Icon(
                Icons.remove,
                color: Colors.red,
              ),
            );
          },
        ),
        Text(
          widget.quantity.toString(),
          style: const TextStyle(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        BlocConsumer<CartBloc, CartState>(
          bloc: increaseItemBloc,
          listener: (context, state) {
            if (state is IncreaseQtyLoading) {
              setState(() {
                widget.quantity = widget.quantity + 1;
              });
            }
            if (state is IncreaseQtyErrorState) {
              setState(() {
                widget.quantity = widget.quantity - 1;
              });
            }
          },
          builder: (context, state) {
            return IconButton(
              onPressed: () {
                increaseItemBloc.add(
                  IncreaseQtyEvent(
                    widget.userId,
                    widget.foodId,
                  ),
                );
              },
              icon: const Icon(
                Icons.add,
                color: Colors.green,
              ),
            );
          },
        ),
      ],
    );
  }
}
