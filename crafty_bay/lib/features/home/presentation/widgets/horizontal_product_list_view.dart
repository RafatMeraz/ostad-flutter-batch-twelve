import 'package:flutter/material.dart';

import '../../../shared/presentation/widgets/product_card.dart';

class HorizontalProductListView extends StatelessWidget {
  const HorizontalProductListView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 195,
      child: ListView.builder(
        scrollDirection: .horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          // return ProductCard();
        },
      ),
    );
  }
}
