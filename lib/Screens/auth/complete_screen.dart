import 'package:e_comerce_project/Screens/home/widgets/navagation_bar.dart';
import 'package:e_comerce_project/Widgets/buttons/social_buttons.dart';
import 'package:flutter/material.dart';
import 'package:e_comerce_project/constants/app_theme.dart';


class SuccessScreen extends StatefulWidget {
  const SuccessScreen({super.key});

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: isDarkMode ? Colors.green.withValues(alpha: 0.2) : Colors.green[100],
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Icon(
                    Icons.check_circle_rounded,
                    size: 80,
                    color: Colors.green,
                  ),
                ),
              ),
              const SizedBox(height: 32),

              Text(
                'Success!',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),

              Text(
                'You have successfully logged in to your account. Welcome back!',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontSize: 15,
                  color: isDarkMode ? AppTheme.textSecondary : Colors.grey,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 48),

              SocialButtons(
                ltext: 'Go To Homepage',
                backgroundColor: isDarkMode ? theme.colorScheme.primary : Colors.black,
                textColor: Colors.white,
                icon: const Icon(Icons.home, color: Colors.white),
                destinationPage: const NavagateBar(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}