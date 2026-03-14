import 'package:crafty_bay/features/shared/presentation/providers/main_nav_provider.dart';
import 'package:crafty_bay/features/shared/presentation/widgets/center_circular_progress.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../shared/presentation/widgets/category_card.dart';
import '../providers/category_list_provider.dart';

class CategoryListScreen extends StatefulWidget {
  const CategoryListScreen({super.key});

  @override
  State<CategoryListScreen> createState() => _CategoryListScreenState();
}

class _CategoryListScreenState extends State<CategoryListScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_loadCategories);
  }

  void _loadCategories() {
    if (context.read<CategoryListProvider>().loadMoreCategoryListInProgress) {
      return;
    }

    if (_scrollController.position.extentBefore < 300) {
      context.read<CategoryListProvider>().getCategories();
    }
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
          title: Text('Categories'),
        ),
        body: Consumer<CategoryListProvider>(
          builder: (context, categoryListProvider, _) {
            if (categoryListProvider.getInitialCategoryListInProgress) {
              return CenterCircularProgress();
            }

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                    child: GridView.builder(
                      controller: _scrollController,
                      itemCount: categoryListProvider.categories.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                      ),
                      itemBuilder: (context, index) {
                        return FittedBox(
                          child: CategoryCard(
                            categoryModel:
                                categoryListProvider.categories[index],
                          ),
                        );
                      },
                    ),
                  ),
                  if (categoryListProvider.loadMoreCategoryListInProgress)
                    CenterCircularProgress(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _onTapBackButton() {
    context.read<MainNavProvider>().backToHome();
  }
}
