// lib/views/signup_screen.dart
import 'package:flutter/material.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_button.dart';
import '../constants/app_styles.dart';

class SignupScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double padding = screenSize.width * 0.05;
    final double appBarHeight =
        screenSize.height * 0.1; // Dynamic AppBar height
    final double spacingHeight =
        screenSize.height * 0.02; // Dynamic spacing height

    return Scaffold(
      backgroundColor:
          AppStyles.greyColor, // Match background color with LoginScreen
      appBar: AppBar(
        backgroundColor: AppStyles.greyColor, // Match app bar color
        elevation: 0,
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'MyNews',
            style: AppStyles.boldText
                .copyWith(color: AppStyles.primaryColor), // Match title style
          ),
        ),
        toolbarHeight: appBarHeight, // Match app bar height
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Centering name, email, and password fields
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomTextField(
                    label: 'Name',
                    controller: nameController,
                  ),
                  SizedBox(height: spacingHeight),
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
              text: 'Signup',
              onPressed: () {
                // Handle Signup
              },
            ),
            SizedBox(height: spacingHeight),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Already have an account?',
                    style: AppStyles.regularText), // Match text style
                SizedBox(width: spacingHeight * 0.5),
                GestureDetector(
                  onTap: () {
                    // Navigate to Login Page
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                  child: Text(
                    'Login',
                    style: AppStyles.boldText.copyWith(
                        color: AppStyles.primaryColor), // Match text style
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
