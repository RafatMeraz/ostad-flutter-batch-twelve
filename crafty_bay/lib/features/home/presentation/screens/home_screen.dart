import 'package:crafty_bay/features/shared/presentation/providers/main_nav_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../../app/asset_paths.dart';
import '../widgets/app_bar_icon_button.dart';
import '../widgets/home_category_list.dart';
import '../widgets/home_slider.dart';
import '../widgets/horizontal_product_list_view.dart';
import '../widgets/product_search_bar.dart';
import '../widgets/section_header.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(height: 16),
              ProductSearchBar(),
              const SizedBox(height: 16),
              HomeSlider(),
              const SizedBox(height: 16),
              SectionHeader(
                name: 'Categories',
                onTapSeeAll: context.read<MainNavProvider>().moveToCategory,
              ),
              HomeCategoryList(),
              SectionHeader(name: 'Popular', onTapSeeAll: () {}),
              HorizontalProductListView(),
              SectionHeader(name: 'Special', onTapSeeAll: () {}),
              HorizontalProductListView(),
              SectionHeader(name: 'New', onTapSeeAll: () {}),
              HorizontalProductListView(),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      title: SvgPicture.asset(AssetPaths.navLogoSvg),
      actions: [
        AppBarIconButton(onTap: () {}, icon: Icons.person),
        const SizedBox(width: 4),
        AppBarIconButton(onTap: () {}, icon: Icons.call),
        const SizedBox(width: 4),
        AppBarIconButton(
          onTap: () {},
          icon: Icons.notifications_active_outlined,
        ),
      ],
    );
  }
}
