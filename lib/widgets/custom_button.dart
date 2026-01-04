// lib/widgets/custom_button.dart
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onPressed;

  const CustomButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(

        //adding icon to the button
        icon: Icon(icon),

        //adding the label in the button
        label: Padding(
          padding: EdgeInsets.symmetric(vertical: 14),
          child: Text(label, style: TextStyle(fontSize: 16)),
        ),

        //function on pressing
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          backgroundColor: Colors.blueAccent,
        ),
      ),
    );
  }
}
