import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/custom_text_field.dart';
import '../widgets/custom_button.dart';
import '../constants/app_styles.dart';
import '../providers/authentication_provider.dart';

/// SignupScreen allows users to create a new account.
class SignupScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double padding = screenSize.width * 0.05;
    final double appBarHeight = screenSize.height * 0.1;
    final double spacingHeight = screenSize.height * 0.02;

    return Scaffold(
      backgroundColor: AppStyles.greyColor,
      appBar: AppBar(
        backgroundColor: AppStyles.greyColor,
        elevation: 0,
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'MyNews',
            style: AppStyles.boldText.copyWith(color: AppStyles.primaryColor),
          ),
        ),
        toolbarHeight: appBarHeight,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomTextField(label: 'Name', controller: nameController),
                  SizedBox(height: spacingHeight),
                  CustomTextField(label: 'Email', controller: emailController),
                  SizedBox(height: spacingHeight),
                  CustomTextField(
                    label: 'Password',
                    isPassword: true,
                    controller: passwordController,
                  ),
                ],
              ),
            ),
            SizedBox(height: spacingHeight * 1.5),
            Consumer<AuthenticationProvider>(
              builder: (context, authProvider, child) {
                return CustomButton(
                  text: 'Signup',
                  isLoading: authProvider.isLoading,
                  onPressed: () async {
                    String name = nameController.text.trim();
                    String email = emailController.text.trim();
                    String password = passwordController.text.trim();

                    if (name.isNotEmpty &&
                        email.isNotEmpty &&
                        password.isNotEmpty) {
                      try {
                        bool signedUp =
                            await authProvider.signUp(email, password, name);
                        if (context.mounted && signedUp) {
                          Navigator.pushReplacementNamed(context, '/news_feed');
                        } else if (context.mounted) {
                          String? errorMessage = authProvider.errorMessage;
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text('Signup failed: $errorMessage')),
                          );
                        }
                      } catch (e) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text(
                                    'An unexpected error occurred. Please try again.')),
                          );
                        }
                      }
                    } else {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Please fill all fields')),
                        );
                      }
                    }
                  },
                );
              },
            ),
            SizedBox(height: spacingHeight),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Already have an account?', style: AppStyles.regularText),
                SizedBox(width: spacingHeight * 0.5),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                  child: Text(
                    'Login',
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
