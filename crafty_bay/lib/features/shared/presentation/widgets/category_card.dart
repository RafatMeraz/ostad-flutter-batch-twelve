import 'package:crafty_bay/features/products/presentation/screens/product_list_screen.dart';
import 'package:flutter/material.dart';

import '../../../../app/app_colors.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          ProductListScreen.name,
          arguments: 'Electronics',
        );
      },
      child: Column(
        crossAxisAlignment: .center,
        spacing: 4,
        children: [
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.themeColor.withAlpha(30),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(Icons.computer, size: 36, color: AppColors.themeColor),
          ),
          Text(
            'Electronics',
            style: TextStyle(
              fontSize: 16,
              fontWeight: .w600,
              color: AppColors.themeColor,
            ),
          ),
        ],
      ),
    );
  }
}
