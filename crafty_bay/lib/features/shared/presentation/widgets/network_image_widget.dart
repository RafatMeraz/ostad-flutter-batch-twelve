import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'no_image.dart';

class AppNetworkImage extends StatelessWidget {
  const AppNetworkImage({
    super.key,
    required this.urls,
    this.height,
    this.width,
  });

  final List<String> urls;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return _getImage();
  }

  Widget _getImage() {
    if (urls.isNotEmpty) {
      return CachedNetworkImage(
        imageUrl: urls.first,
        fit: .scaleDown,
        progressIndicatorBuilder: (context, url, downloadProgress) => NoImage(),
        errorWidget: (context, url, error) => NoImage(),
        height: height,
        width: width,
      );
    } else {
      return NoImage(
        height: height,
        width: width,
      );
    }
  }
}
