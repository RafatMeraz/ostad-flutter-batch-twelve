import 'package:crafty_bay/features/cart/data/models/cart_item_model.dart';
import 'package:crafty_bay/features/cart/presentation/providers/cart_list_provider.dart';
import 'package:crafty_bay/features/shared/presentation/widgets/network_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app/app_colors.dart';
import '../../../../app/constants.dart';
import '../../../../app/extensions/utils_extension.dart';
import '../../../shared/presentation/widgets/inc_dec_button.dart';

class CartItem extends StatelessWidget {
  const CartItem({super.key, required this.cartItemModel});

  final CartItemModel cartItemModel;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: .symmetric(horizontal: 16, vertical: 4),
      elevation: 3,
      shadowColor: AppColors.themeColor.withAlpha(30),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AppNetworkImage(
                urls: cartItemModel.productModel.photos,
                height: 90,
                width: 90,
              ),
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
                              cartItemModel.productModel.title,
                              style: context.textTheme.titleMedium,
                            ),
                            Text(
                              'Color: ${cartItemModel.color ?? ''}  Size: ${cartItemModel.size ?? ''}',
                            ),
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
                        '${Constants.takaSign}${cartItemModel.productModel.currentPrice}',
                        style: TextStyle(
                          color: AppColors.themeColor,
                          fontSize: 18,
                          fontWeight: .w600,
                        ),
                      ),
                      IncDecButton(
                        initialValue: cartItemModel.quantity,
                        onChange: (int value) {
                          context.read<CartListProvider>().addQuantity(
                            cartItemModel.id,
                            value,
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
