// lib/widgets/custom_checkbox_group.dart
import 'package:flutter/material.dart';

class CustomCheckboxGroup extends StatelessWidget {
  final List<String> options;
  final List<String> selected;
  final ValueChanged<List<String>> onChanged;
  final String label;

  const CustomCheckboxGroup({
    super.key,
    required this.options,
    required this.selected,
    required this.onChanged,
    this.label = 'Education Level',
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontWeight: FontWeight.w600, color: Colors.blueGrey)),
        SizedBox(height: 6),
        Wrap(
          spacing: 8,
          children: options.map((opt) {
            final isChecked = selected.contains(opt);
            return FilterChip(
              label: Text(opt),
              selected: isChecked,
              selectedColor: Colors.blue.shade100,
              onSelected: (val) {
                final newSelected = List<String>.from(selected);
                if (val) {
                  newSelected.add(opt);
                } else {
                  newSelected.remove(opt);
                }
                onChanged(newSelected);
              },
            );
          }).toList(),
        )
      ],
    );
  }
}
