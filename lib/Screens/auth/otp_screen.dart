import 'package:e_comerce_project/Screens/auth/sign_up_screen.dart';
import 'package:e_comerce_project/Screens/home/home_page_screen.dart';
import 'package:e_comerce_project/Widgets/buttons/social_buttons.dart';
import 'package:e_comerce_project/Widgets/inputs/otp_code_user_input.dart';
import 'package:flutter/material.dart';

import 'package:e_comerce_project/constants/app_theme.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String phone = '+ 961 768100782';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        iconTheme: IconThemeData(
          color: isDarkMode ? Colors.white : Colors.black,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 32),
            Text(
              'Enter OTP Code',
              style: theme.textTheme.titleLarge?.copyWith(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'CHeck Your SMS were sent a one-time verification code to  $phone .Enter the code below to verify your account.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: isDarkMode ? AppTheme.textSecondary : Colors.grey,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 10),
            const OtpInputWidget(),
            const SizedBox(height: 10),
            SocialButtons(
              backgroundColor: isDarkMode ? theme.colorScheme.primary : Colors.black,
              ltext: 'Continue',
              icon: const Icon(Icons.arrow_forward, color: Colors.white),
              textColor: Colors.white,
              destinationPage: const HomeScreen(),
            ),
            const SizedBox(height: 24),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SignUpScreen(),
                  ),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't get OTP? ",
                    style: TextStyle(
                      color: isDarkMode ? AppTheme.textSecondary : Colors.grey,
                    ),
                  ),
                  Text(
                    'Resend OTP',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: isDarkMode ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}