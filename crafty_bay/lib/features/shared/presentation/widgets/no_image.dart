import 'package:flutter/material.dart';

import '../../../../app/asset_paths.dart';

class NoImage extends StatelessWidget {
  const NoImage({super.key, this.height, this.width});

  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AssetPaths.noImagePng,
      fit: .scaleDown,
      height: height,
      width: width,
    );
  }
}
