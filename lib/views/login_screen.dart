import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/custom_text_field.dart';
import '../widgets/custom_button.dart';
import '../constants/app_styles.dart';
import '../providers/authentication_provider.dart';

/// LoginScreen allows users to log in to their account.
class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginScreen({super.key});

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
            SizedBox(height: spacingHeight * 1.5),
            Consumer<AuthenticationProvider>(
              builder: (context, authProvider, child) {
                return CustomButton(
                  text: 'Login',
                  isLoading: authProvider.isLoading,
                  onPressed: () async {
                    String email = emailController.text.trim();
                    String password = passwordController.text.trim();

                    if (email.isNotEmpty && password.isNotEmpty) {
                      bool loggedIn = await authProvider.login(email, password);
                      if (loggedIn && context.mounted) {
                        Navigator.pushReplacementNamed(context, '/news_feed');
                      } else if (context.mounted) {
                        final errorMessage = authProvider.errorMessage;
                        if (errorMessage != null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(errorMessage)),
                          );
                        }
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please fill all fields')),
                      );
                    }
                  },
                );
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
