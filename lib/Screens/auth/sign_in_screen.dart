import 'package:flutter/material.dart';
import 'package:e_comerce_project/Screens/auth/complete_screen.dart';
import 'package:e_comerce_project/Widgets/inputs/user_form_input.dart';
import 'package:e_comerce_project/Widgets/buttons/social_buttons.dart';
import 'package:e_comerce_project/Screens/auth/sign_up_screen.dart';
import 'package:e_comerce_project/Screens/auth/otp_screen.dart';
import 'package:e_comerce_project/utils/validator.dart';
import 'package:e_comerce_project/constants/app_theme.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool noclick = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
            Text(
              'Welcome back',
              style: theme.textTheme.titleLarge?.copyWith(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Access your orders, wishlist, and exclusive offers by logging in.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: isDarkMode ? AppTheme.textSecondary : Colors.grey,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 32),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomInputField(
                    title: 'Email',
                    hintText: 'example@email.com',
                    prefixIcon: Icons.email,
                    validator: Validaion.isValidEmail,
                    controller: _emailController,
                  ),
                  const SizedBox(height: 16),
                  CustomInputField(
                    title: 'Password',
                    hintText: 'Enter your password',
                    prefixIcon: Icons.lock,
                    isPassword: true,
                    validator: Validaion.isValidPass,
                    controller: _passwordController,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: noclick,
                      activeColor: Colors.green,
                      onChanged: (value) {
                        setState(() {
                          noclick = value ?? false;
                        });
                      },
                    ),
                    Text(
                      'Remember me',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: isDarkMode ? AppTheme.textSecondary : Colors.black54,
                      ),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const OtpScreen(),
                        ),
                      );
                    });
                  },
                  child: const Text(
                    'Forgot password?',
                    style: TextStyle(color: Colors.redAccent),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SocialButtons(
              backgroundColor: isDarkMode ? theme.colorScheme.primary : Colors.black,
              ltext: 'Sign in',
              icon: const Icon(Icons.login, color: Colors.white),
              textColor: Colors.white,
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  String enteredEmail = _emailController.text.trim();
                  String enteredPass = _passwordController.text.trim();
                  if (enteredEmail == Validaion.correctEmail &&
                      enteredPass == Validaion.correctPass) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SuccessScreen()),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Invalid email or password. Please try again.',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        backgroundColor: Colors.amber,
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  }
                }
              },
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Divider(
                    thickness: 1,
                    color: isDarkMode ? AppTheme.borderDark : Colors.grey[300],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    'OR',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: isDarkMode ? AppTheme.textSecondary : Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: Divider(
                    thickness: 1,
                    color: isDarkMode ? AppTheme.borderDark : Colors.grey[300],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SocialButtons(
              backgroundColor: isDarkMode ? theme.colorScheme.surface : Colors.grey[350],
              ltext: 'continue with Google',
              textColor: isDarkMode ? Colors.white : Colors.black,
              icon: Image.asset('images/googleIcon.png', width: 24, height: 24),
              externalurl: "https://www.google.com/",
            ),
            const SizedBox(height: 12),
            SocialButtons(
              backgroundColor: isDarkMode ? theme.colorScheme.surface : Colors.grey[350],
              ltext: 'continue with Apple',
              textColor: isDarkMode ? Colors.white : Colors.black,
              icon: Icon(
                Icons.apple, 
                color: isDarkMode ? Colors.white : Colors.black,
              ),
              externalurl: "https://www.apple.com/",
            ),
            const SizedBox(height: 24),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignUpScreen()),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account? ",
                    style: TextStyle(
                      color: isDarkMode ? AppTheme.textSecondary : Colors.grey,
                    ),
                  ),
                  Text(
                    'Sign up',
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