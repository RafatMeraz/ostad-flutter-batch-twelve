import 'package:flutter/material.dart';

import '../../../../app/extensions/utils_extension.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.name,
    required this.onTapSeeAll,
  });

  final String name;
  final VoidCallback onTapSeeAll;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: .spaceBetween,
        children: [
          Text(name, style: context.textTheme.titleLarge),
          TextButton(onPressed: onTapSeeAll, child: Text('See all')),
        ],
      ),
    );
  }
}
