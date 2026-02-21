import 'package:crafty_bay/app/app_colors.dart';
import 'package:crafty_bay/app/extensions/utils_extension.dart';
import 'package:flutter/material.dart';

class SizePicker extends StatefulWidget {
  const SizePicker({super.key, required this.sizes, required this.onChange});

  final List<String> sizes;
  final Function(String) onChange;

  @override
  State<SizePicker> createState() => _SizePickerState();
}

class _SizePickerState extends State<SizePicker> {
  String? _selectedSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      spacing: 8,
      children: [
        Text('Size', style: context.textTheme.titleMedium),
        Row(
          children: widget.sizes.map((size) {
            return GestureDetector(
              onTap: () {
                _selectedSize = size;
                setState(() {});
                widget.onChange(size);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                margin: .only(right: 8),
                decoration: BoxDecoration(
                  color: size == _selectedSize
                      ? AppColors.themeColor
                      : Colors.white,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: AppColors.themeColor),
                ),
                child: Text(size),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
