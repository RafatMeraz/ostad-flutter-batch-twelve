import 'package:crafty_bay/app/extensions/utils_extension.dart';
import 'package:flutter/material.dart';

import '../../../../app/app_colors.dart';

class IncDecButton extends StatefulWidget {
  const IncDecButton({
    super.key,
    required this.onChange,
    this.width = 100,
    this.maxCount = 20,
    this.initialValue = 1,
  });

  final int initialValue;
  final double width;
  final Function(int) onChange;
  final int maxCount;

  @override
  State<IncDecButton> createState() => _IncDecButtonState();
}

class _IncDecButtonState extends State<IncDecButton> {
  int _count = 1;

  @override
  void initState() {
    super.initState();
    _count = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: Row(
        mainAxisAlignment: .spaceBetween,
        children: [
          _buildButton(Icons.remove, () {
            if (_count > 1) {
              _count--;
              setState(() {});
              widget.onChange(_count);
            }
          }),
          Text('$_count', style: context.textTheme.titleLarge),
          _buildButton(Icons.add, () {
            if (_count < widget.maxCount) {
              _count++;
              widget.onChange(_count);
              setState(() {});
            }
          }),
        ],
      ),
    );
  }

  Widget _buildButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.themeColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, size: 18, color: Colors.white),
      ),
    );
  }
}
