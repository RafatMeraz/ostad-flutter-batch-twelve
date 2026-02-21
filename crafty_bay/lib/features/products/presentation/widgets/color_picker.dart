import 'package:crafty_bay/app/app_colors.dart';
import 'package:crafty_bay/app/extensions/utils_extension.dart';
import 'package:flutter/material.dart';

class ColorPicker extends StatefulWidget {
  const ColorPicker({super.key, required this.colors, required this.onChange});

  final List<String> colors;
  final Function(String) onChange;

  @override
  State<ColorPicker> createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  String? _selectedColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      spacing: 8,
      children: [
        Text('Color', style: context.textTheme.titleMedium),
        Row(
          children: widget.colors.map((color) {
            return GestureDetector(
              onTap: () {
                _selectedColor = color;
                setState(() {});
                widget.onChange(color);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                margin: .only(right: 8),
                decoration: BoxDecoration(
                  color: color == _selectedColor
                      ? AppColors.themeColor
                      : Colors.white,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: AppColors.themeColor),
                ),
                child: Text(color),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
