import 'package:crafty_bay/features/cart/presentation/providers/cart_list_provider.dart';
import 'package:crafty_bay/features/shared/presentation/widgets/center_circular_progress.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../shared/presentation/providers/main_nav_provider.dart';
import '../widgets/cart_item.dart';
import '../widgets/total_price_and_checkout_section.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final CartListProvider _cartListProvider = CartListProvider();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _cartListProvider.getCartList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (_, __) {
        _onTapBackButton();
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: _onTapBackButton,
            icon: Icon(Icons.arrow_back_ios),
          ),
          title: Text('Carts'),
        ),
        body: ChangeNotifierProvider.value(
          value: _cartListProvider,
          child: Consumer<CartListProvider>(
            builder: (context, _, _) {
              if (_cartListProvider.getCartListInProgress) {
                return CenterCircularProgress();
              }

              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: _cartListProvider.cartItems.length,
                      itemBuilder: (context, index) {
                        return CartItem(
                          cartItemModel: _cartListProvider.cartItems[index],
                        );
                      },
                    ),
                  ),
                  TotalPriceAndCheckoutSection(
                    totalPrice: _cartListProvider.totalPrice,
                    onTapCheckout: () {},
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  void _onTapBackButton() {
    context.read<MainNavProvider>().backToHome();
  }
}
