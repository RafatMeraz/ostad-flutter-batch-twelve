import 'package:crafty_bay/app/network_caller_set_up.dart';
import 'package:crafty_bay/app/urls.dart';
import 'package:crafty_bay/core/services/network_caller.dart';
import 'package:flutter/foundation.dart';

import '../../data/models/product_model.dart';

class ProductListProvider extends ChangeNotifier {
  final int _pageSize = 30;

  int _currentPageNo = 0;

  int? _lastPage;

  final List<ProductModel> _products = [];

  bool _getInitialProductListInProgress = true;

  bool _loadMoreProductListInProgress = false;

  bool get getInitialProductListInProgress => _getInitialProductListInProgress;

  bool get loadMoreProductListInProgress => _loadMoreProductListInProgress;

  List<ProductModel> get products => _products;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  Future<bool> getProducts(String categoryId) async {
    bool isSuccess = false;

    if (_lastPage != null && _currentPageNo >= _lastPage!) {
      return false;
    }

    _currentPageNo++;
    if (_isInitialLoading) {
      _getInitialProductListInProgress = true;
    } else {
      _loadMoreProductListInProgress = true;
    }
    notifyListeners();

    final NetworkResponse response = await getNetworkCaller().getRequest(
      Urls.productListUrl(_currentPageNo, _pageSize, categoryId),
    );
    if (response.isSuccess) {
      _lastPage = response.body['data']['last_page'] ?? _lastPage;
      List<ProductModel> productList = [];
      for (Map<String, dynamic> product in response.body['data']['results']) {
        productList.add(ProductModel.fromJson(product));
      }
      _products.addAll(productList);
      isSuccess = true;
      _errorMessage = null;
    } else {
      _errorMessage = response.errorMessage;
    }

    if (_isInitialLoading) {
      _getInitialProductListInProgress = false;
    } else {
      _loadMoreProductListInProgress = false;
    }
    notifyListeners();

    return isSuccess;
  }

  bool get _isInitialLoading {
    return _currentPageNo == 1;
  }

  bool get isLoading =>
      _getInitialProductListInProgress || _loadMoreProductListInProgress;
}
