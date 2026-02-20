import 'package:flutter/material.dart';

import '../../../../app/extensions/utils_extension.dart';

class ProductRating extends StatelessWidget {
  const ProductRating({super.key, required this.rating});

  final String rating;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: .center,
      children: [
        Icon(Icons.star, size: 18, color: Colors.amber),
        Text(
          rating,
          style: context.textTheme.titleSmall?.copyWith(color: Colors.grey),
        ),
      ],
    );
  }
}
