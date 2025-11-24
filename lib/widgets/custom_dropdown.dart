// lib/widgets/custom_dropdown.dart
import 'package:flutter/material.dart';

class CustomDropdownField extends StatelessWidget {
  final String label;
  final String value;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  const CustomDropdownField({
    super.key,
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return InputDecorator(
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.school, color: Colors.blueGrey),
        labelText: label,
        labelStyle: TextStyle(color: Colors.blueGrey),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        filled: true,
        fillColor: Colors.grey.shade100,
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          value: value.isEmpty ? null : value,
          hint: Text('Select University'),
          items: items.map((u) => DropdownMenuItem(value: u, child: Text(u))).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
