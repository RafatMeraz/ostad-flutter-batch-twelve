import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app/app_colors.dart';
import '../../../shared/presentation/widgets/center_circular_progress.dart';
import '../providers/home_slider_provider.dart';

class HomeSlider extends StatefulWidget {
  const HomeSlider({super.key});

  @override
  State<HomeSlider> createState() => _HomeSliderState();
}

class _HomeSliderState extends State<HomeSlider> {
  final ValueNotifier<int> _currentIndex = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeSliderProvider>(
      builder: (context, homeSliderProvider, _) {
        if (homeSliderProvider.homeSlidersInProgress) {
          return SizedBox(
            height: 190,
            child: CenterCircularProgress(),
          );
        }

        return Column(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                height: 180,
                viewportFraction: 1,
                autoPlay: false,
                autoPlayInterval: Duration(seconds: 1),
                onPageChanged: (index, reason) {
                  _currentIndex.value = index;
                },
              ),
              items: homeSliderProvider.homeSliders.map((slider) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      alignment: .center,
                      child: ClipRRect(
                        borderRadius: .circular(8),
                        child: Image.network(
                          slider.photoUrl,
                          fit: BoxFit.cover,
                          width: double.maxFinite,
                          height: double.maxFinite,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return CenterCircularProgress();
                          },
                          errorBuilder: (context, child, loadingProgress) {
                            return Icon(Icons.error_outline);
                          },
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 8),
            ValueListenableBuilder(
              valueListenable: _currentIndex,
              builder: (context, value, child) {
                return Row(
                  mainAxisAlignment: .center,
                  children: [
                    for (int i = 0; i < homeSliderProvider.homeSliders.length; i++)
                      Container(
                        height: 10,
                        width: 10,
                        margin: EdgeInsets.only(right: 4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: value == i ? AppColors.themeColor : Colors.white,
                          border: Border.all(color: AppColors.themeColor),
                        ),
                      ),
                  ],
                );
              },
            ),
          ],
        );
      }
    );
  }
}
