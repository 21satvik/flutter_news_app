// lib/widgets/custom_text_field.dart
import 'package:flutter/material.dart';
import '../constants/app_styles.dart'; // Import your styles

class CustomTextField extends StatelessWidget {
  final String label;
  final bool isPassword;
  final TextEditingController controller;

  const CustomTextField({
    super.key,
    required this.label,
    this.isPassword = false,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: AppStyles.lightColor, // Update fill color to grey
        labelStyle: const TextStyle(color: Colors.black), // Set label style
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
      style: AppStyles.regularText, // Use regular text style for input
    );
  }
}
