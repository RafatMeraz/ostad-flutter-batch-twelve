import 'package:crafty_bay/features/shared/presentation/widgets/center_circular_progress.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app/app_colors.dart';
import '../../../../app/extensions/utils_extension.dart';
import '../../../shared/presentation/widgets/inc_dec_button.dart';
import '../../../shared/presentation/widgets/product_favourite_button.dart';
import '../../../shared/presentation/widgets/product_rating.dart';
import '../providers/product_details_provider.dart';
import '../widgets/color_picker.dart';
import '../widgets/price_and_add_to_cart_section.dart';
import '../widgets/product_image_carousel.dart';
import '../widgets/size_picker.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, required this.productId});

  static const String name = '/product-details';

  final String productId;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final ProductDetailsProvider _productDetailsProvider = ProductDetailsProvider();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _productDetailsProvider.getProductDetails(widget.productId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _productDetailsProvider,
      child: Scaffold(
        appBar: AppBar(title: Text('Product details')),
        body: Consumer<ProductDetailsProvider>(
          builder: (context, _, _) {
            if (_productDetailsProvider.getProductDetailsInProgress) {
              return const CenterCircularProgress();
            } else if (_productDetailsProvider.errorMessage != null) {
              return Center(child: Text(_productDetailsProvider.errorMessage!));
            }

            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ProductImageCarousel(
                          imageUrls: _productDetailsProvider
                              .productDetailsModel!.photos,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: .start,
                            children: [
                              _buildTitleSection(),
                              if (_productDetailsProvider
                                  .productDetailsModel!.colors.isNotEmpty)
                                ColorPicker(
                                  colors: _productDetailsProvider
                                      .productDetailsModel!.colors,
                                  onChange: (String color) {},
                                ),
                              const SizedBox(height: 16),
                              if (_productDetailsProvider
                                  .productDetailsModel!.sizes.isNotEmpty)
                                SizePicker(
                                  sizes: _productDetailsProvider
                                      .productDetailsModel!.sizes,
                                  onChange: (String size) {},
                                ),
                              const SizedBox(height: 16),
                              Text(
                                'Description',
                                style: context.textTheme.titleMedium,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                _productDetailsProvider.productDetailsModel!
                                    .description,
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                PriceAndAddToCartSection(price: 120, onTapAddToCart: () {}),
              ],
            );
          }
        ),
      ),
    );
  }

  Widget _buildTitleSection() {
    return Row(
      spacing: 8,
      crossAxisAlignment: .start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: .start,
            children: [
              Text(
                'Nike 2026 - New Year Special Edition',
                style: context.textTheme.titleMedium?.copyWith(
                  color: Colors.black87,
                ),
              ),
              Row(
                children: [
                  ProductRating(rating: '4.7'),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Reviews',
                      style: TextStyle(color: AppColors.themeColor),
                    ),
                  ),
                  ProductFavouriteButton(),
                ],
              ),
            ],
          ),
        ),
        IncDecButton(
          maxCount: _productDetailsProvider.productDetailsModel!
              .availableQuantity,
          onChange: (int count) {},
        ),
      ],
    );
  }
}
