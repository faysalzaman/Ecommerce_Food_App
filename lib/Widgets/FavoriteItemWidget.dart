// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class FavoriteItemWidget extends StatelessWidget {
  FavoriteItemWidget({
    super.key,
    required this.products,
    required this.index,
  });

  final List<Map<String, dynamic>> products;
  int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.4,
            height: MediaQuery.of(context).size.height * 0.2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: NetworkImage(products[index]['image']),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            products[index]['name'],
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Text(products[index]['category']),
          Text('\$${products[index]['price']}'),
        ],
      ),
    );
  }
}
