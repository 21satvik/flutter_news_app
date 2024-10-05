import 'package:flutter/material.dart';

import '../constants/app_styles.dart';

/// CustomButton is a reusable button widget with a loading state.
class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor:
            isLoading ? AppStyles.greyColor : AppStyles.primaryColor,
        padding: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onPressed: isLoading ? null : onPressed,
      child: Text(
        text,
        style: AppStyles.boldText.copyWith(color: AppStyles.lightColor),
      ),
    );
  }
}
