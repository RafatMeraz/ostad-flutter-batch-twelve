import 'package:flutter/foundation.dart';

import '../../../../app/network_caller_set_up.dart';
import '../../../../app/urls.dart';
import '../../../../core/services/network_caller.dart';
import '../../data/models/slider_model.dart';

class HomeSliderProvider extends ChangeNotifier {
  bool _getHomeSlidersInProgress = false;

  List<SliderModel> _homeSliders = [];

  bool get homeSlidersInProgress => _getHomeSlidersInProgress;

  List<SliderModel> get homeSliders => _homeSliders;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  Future<bool> getHomeSliders() async {
    bool isSuccess = false;
    _getHomeSlidersInProgress = true;
    notifyListeners();

    final NetworkResponse response = await getNetworkCaller().getRequest(
      Urls.homeSlidersUrl,
    );

    if (response.isSuccess) {
      List<SliderModel> sliders = [];
      for (Map<String, dynamic> slider in response.body['data']['results']) {
        sliders.add(SliderModel.fromJson(slider));
      }
      _homeSliders = sliders;
      _errorMessage = null;
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }

    _getHomeSlidersInProgress = false;
    notifyListeners();

    return isSuccess;
  }
}
