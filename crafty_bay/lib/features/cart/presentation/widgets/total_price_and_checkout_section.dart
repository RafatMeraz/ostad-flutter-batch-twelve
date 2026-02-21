import 'package:flutter/material.dart';

import '../../../../app/app_colors.dart';
import '../../../../app/constants.dart';
import '../../../../app/extensions/utils_extension.dart';

class TotalPriceAndCheckoutSection extends StatelessWidget {
  const TotalPriceAndCheckoutSection({
    super.key,
    required this.totalPrice,
    required this.onTapCheckout,
  });

  final double totalPrice;
  final VoidCallback onTapCheckout;

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
              Text('Total Price', style: context.textTheme.bodyLarge),
              Text(
                '${Constants.takaSign}$totalPrice',
                style: context.textTheme.titleLarge?.copyWith(
                  color: AppColors.themeColor,
                ),
              ),
            ],
          ),
          FilledButton(
            style: FilledButton.styleFrom(fixedSize: Size.fromWidth(120)),
            onPressed: onTapCheckout,
            child: Text('Checkout'),
          ),
        ],
      ),
    );
  }
}
