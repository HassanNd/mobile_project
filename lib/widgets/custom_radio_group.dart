// lib/widgets/custom_radio_group.dart
import 'package:flutter/material.dart';

class CustomRadioGroup extends StatelessWidget {
  final String label;
  final List<String> options;
  final String value;
  final ValueChanged<String?> onChanged;

  const CustomRadioGroup({
    super.key,
    required this.label,
    required this.options,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      //creating the radio with making over the list
      children: [
        Text(label, style: TextStyle(fontWeight: FontWeight.w600, color: Colors.blueGrey)),
        Column(

          //mapping over the list to add new radio when editing the list
          children: options.map((opt) {
            return RadioListTile<String>(
              title: Text(opt),
              value: opt,
              // ignore: deprecated_member_use
              groupValue: value,
              // ignore: deprecated_member_use
              onChanged: onChanged,
              dense: true,
              activeColor: Colors.blue,
            );
          }).toList(),
        )
      ],
    );
  }
}
