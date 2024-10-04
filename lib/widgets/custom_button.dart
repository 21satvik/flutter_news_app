// lib/widgets/custom_button.dart
import 'package:flutter/material.dart';
import '../constants/app_styles.dart'; // Import your styles

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppStyles.primaryColor, // Set to primaryColor
        padding: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: AppStyles.boldText
            .copyWith(color: AppStyles.lightColor), // Use AppStyles for font
      ),
    );
  }
}
