import 'package:flutter/material.dart';

import '../../../../app/app_colors.dart';
import '../../../../app/constants.dart';
import '../../../../app/extensions/utils_extension.dart';

class PriceAndAddToCartSection extends StatelessWidget {
  const PriceAndAddToCartSection({
    super.key,
    required this.price,
    required this.onTapAddToCart,
  });

  final double price;
  final VoidCallback onTapAddToCart;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: .only(topLeft: .circular(16), topRight: .circular(16)),
        color: AppColors.themeColor.withAlpha(30),
      ),
      child: Row(
        mainAxisAlignment: .spaceBetween,
        children: [
          Column(
            crossAxisAlignment: .start,
            children: [
              Text('Price', style: context.textTheme.bodyLarge),
              Text(
                '${Constants.takaSign}$price',
                style: context.textTheme.titleLarge?.copyWith(
                  color: AppColors.themeColor,
                ),
              ),
            ],
          ),
          FilledButton(
            style: FilledButton.styleFrom(fixedSize: Size.fromWidth(120)),
            onPressed: onTapAddToCart,
            child: Text('Add to Cart'),
          ),
        ],
      ),
    );
  }
}
