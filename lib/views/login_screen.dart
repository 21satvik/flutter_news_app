// lib/views/login_screen.dart
import 'package:flutter/material.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_button.dart';
import '../constants/app_styles.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double padding = screenSize.width * 0.05;
    final double appBarHeight =
        screenSize.height * 0.1; // Dynamic AppBar height
    final double spacingHeight =
        screenSize.height * 0.02; // Dynamic spacing height

    return Scaffold(
      backgroundColor: AppStyles.greyColor,
      appBar: AppBar(
        backgroundColor: AppStyles.greyColor, // Set background color to grey
        elevation: 0,
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'MyNews',
            style: AppStyles.boldText.copyWith(
                color:
                    AppStyles.primaryColor), // Set font color to primaryColor
          ),
        ),
        toolbarHeight: appBarHeight, // Optional: Adjust height if needed
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Centering email and password fields
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomTextField(
                    label: 'Email',
                    controller: emailController,
                  ),
                  SizedBox(height: spacingHeight),
                  CustomTextField(
                    label: 'Password',
                    isPassword: true,
                    controller: passwordController,
                  ),
                ],
              ),
            ),
            // Space between password field and button
            SizedBox(height: spacingHeight * 1.5),
            CustomButton(
              text: 'Login',
              onPressed: () {
                // Handle Login
              },
            ),
            SizedBox(height: spacingHeight),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('New here?', style: AppStyles.regularText),
                SizedBox(width: spacingHeight * 0.5),
                GestureDetector(
                  onTap: () {
                    // Navigate to Signup Page
                    Navigator.pushReplacementNamed(context, '/signup');
                  },
                  child: Text(
                    'Signup',
                    style: AppStyles.boldText
                        .copyWith(color: AppStyles.primaryColor),
                  ),
                ),
              ],
            ),
            SizedBox(height: spacingHeight),
          ],
        ),
      ),
    );
  }
}
