import 'package:crafty_bay/app/extensions/utils_extension.dart';
import 'package:crafty_bay/features/products/presentation/widgets/product_image_carousel.dart';
import 'package:crafty_bay/features/shared/presentation/widgets/inc_dec_button.dart';
import 'package:flutter/material.dart';

import '../../../../app/app_colors.dart';
import '../../../shared/presentation/widgets/product_favourite_button.dart';
import '../../../shared/presentation/widgets/product_rating.dart';
import '../widgets/price_and_add_to_cart_section.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key});

  static const String name = '/product-details';

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Product details')),
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                ProductImageCarousel(),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        spacing: 8,
                        crossAxisAlignment: .start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: .start,
                              children: [
                                Text(
                                  'Nike 2026 - New Year Special Edition',
                                  style: context.textTheme.titleMedium
                                      ?.copyWith(color: Colors.black87),
                                ),
                                Row(
                                  children: [
                                    ProductRating(rating: '4.7'),
                                    TextButton(
                                      onPressed: () {},
                                      child: Text(
                                        'Reviews',
                                        style: TextStyle(
                                          color: AppColors.themeColor,
                                        ),
                                      ),
                                    ),
                                    ProductFavouriteButton(),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          IncDecButton(onChange: (int count) {}),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          PriceAndAddToCartSection(price: 120, onTapAddToCart: () {}),
        ],
      ),
    );
  }
}
