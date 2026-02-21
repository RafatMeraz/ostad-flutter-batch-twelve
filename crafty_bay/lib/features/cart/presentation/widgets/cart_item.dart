import 'package:flutter/material.dart';

import '../../../../app/app_colors.dart';
import '../../../../app/asset_paths.dart';
import '../../../../app/constants.dart';
import '../../../../app/extensions/utils_extension.dart';
import '../../../shared/presentation/widgets/inc_dec_button.dart';

class CartItem extends StatelessWidget {
  const CartItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: .symmetric(horizontal: 16, vertical: 4),
      elevation: 3,
      shadowColor: AppColors.themeColor.withAlpha(30),
      color: Colors.white,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(AssetPaths.dummyImagePng, width: 90, height: 90),
          ),
          Expanded(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: .start,
                        children: [
                          Text(
                            'Product name',
                            style: context.textTheme.titleMedium,
                          ),
                          Text('Color: Red  Size: XL'),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.delete_outline),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: .spaceBetween,
                  children: [
                    Text(
                      '${Constants.takaSign}180',
                      style: TextStyle(
                        color: AppColors.themeColor,
                        fontSize: 18,
                        fontWeight: .w600,
                      ),
                    ),
                    IncDecButton(onChange: (int value) {}),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
