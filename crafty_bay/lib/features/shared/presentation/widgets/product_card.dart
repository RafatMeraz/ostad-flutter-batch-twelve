import 'package:crafty_bay/features/products/data/models/product_model.dart';
import 'package:crafty_bay/features/products/presentation/screens/product_details_screen.dart';
import 'package:flutter/material.dart';

import '../../../../app/app_colors.dart';
import '../../../../app/constants.dart';
import '../../../../app/extensions/utils_extension.dart';
import 'network_image_widget.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.productModel});

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          ProductDetailsScreen.name,
          arguments: productModel.id,
        );
      },
      child: Card(
        color: Colors.white,
        elevation: 4,
        shadowColor: AppColors.themeColor.withAlpha(50),
        child: SizedBox(
          width: 140,
          child: Column(
            spacing: 8,
            children: [
              Container(
                width: 140,
                height: 120,
                padding: .all(8),
                decoration: BoxDecoration(
                  color: AppColors.themeColor.withAlpha(30),
                  borderRadius: BorderRadius.only(
                    topLeft: .circular(8),
                    topRight: .circular(8),
                  ),
                ),
                child: AppNetworkImage(urls: productModel.photos),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  spacing: 2,
                  children: [
                    Text(
                      productModel.title,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(overflow: .ellipsis),
                    ),
                    Row(
                      mainAxisAlignment: .spaceBetween,
                      children: [
                        Text(
                          '${Constants.takaSign}${productModel.currentPrice}',
                          style: context.textTheme.titleSmall?.copyWith(
                            color: AppColors.themeColor,
                          ),
                        ),
                        Wrap(
                          crossAxisAlignment: .center,
                          children: [
                            Icon(Icons.star, size: 18, color: Colors.amber),
                            Text(
                              '4.6',
                              style: context.textTheme.titleSmall?.copyWith(
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: .all(2),
                          decoration: BoxDecoration(
                            color: AppColors.themeColor,
                            borderRadius: .circular(4),
                          ),
                          child: Icon(
                            Icons.favorite_outline,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 4),
            ],
          ),
        ),
      ),
    );
  }
}
