import 'package:e_comerce_project/Screens/home/home_page_screen.dart';
import 'package:e_comerce_project/Screens/profile/paymentMethod/choose_card_screen.dart';
import 'package:e_comerce_project/Widgets/buttons/profile_items_buttons.dart';
import 'package:flutter/material.dart';
import 'package:e_comerce_project/constants/app_theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? theme.colorScheme.surface : const Color(0xFFF9F9FB),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 40),
            Center(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: theme.colorScheme.primary,
                            width: 2,
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor: isDarkMode 
                              ? theme.colorScheme.primary.withValues(alpha: 0.2) 
                              : const Color(0xFFEDE7F6),
                          child: Icon(
                            Icons.person,
                            size: 60,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primary,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.edit,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Abdullah Othman',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'abdullah.othman@example.com',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontSize: 14,
                      color: isDarkMode ? AppTheme.textSecondary : Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            Container(
              decoration: BoxDecoration(
                color: isDarkMode ? theme.colorScheme.surface : Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isDarkMode ? AppTheme.borderDark : Colors.transparent,
                ),
              ),
              child: Column(
                children: [
                  BuildProfileMenuItems(
                    icon: Icons.shopping_bag_outlined,
                    title: 'My Orders',
                    subtitle: 'Check your order history & status',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        ),
                      );
                    },
                  ),
                  Divider(
                    height: 1, 
                    indent: 56, 
                    endIndent: 16,
                    color: isDarkMode ? AppTheme.borderDark : Colors.grey[200],
                  ),
                  BuildProfileMenuItems(
                    icon: Icons.location_on_outlined,
                    title: 'Shipping Addresses',
                    subtitle: 'Manage delivery locations',
                    onTap: () {},
                  ),
                  Divider(
                    height: 1, 
                    indent: 56, 
                    endIndent: 16,
                    color: isDarkMode ? AppTheme.borderDark : Colors.grey[200],
                  ),
                  BuildProfileMenuItems(
                    icon: Icons.payment_outlined,
                    title: 'Payment Methods',
                    subtitle: 'Connected cards and options',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ChooseCardScreen(),
                        ),
                      );
                    },
                  ),
                  Divider(
                    height: 1, 
                    indent: 56, 
                    endIndent: 16,
                    color: isDarkMode ? AppTheme.borderDark : Colors.grey[200],
                  ),
                  BuildProfileMenuItems(
                    icon: Icons.notifications_outlined,
                    title: 'Notifications',
                    subtitle: 'Offers, updates and alerts',
                    onTap: () {},
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            Container(
              decoration: BoxDecoration(
                color: isDarkMode ? theme.colorScheme.surface : Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isDarkMode ? AppTheme.borderDark : Colors.transparent,
                ),
              ),
              child: Column(
                children: [
                  BuildProfileMenuItems(
                    icon: Icons.help_outline,
                    title: 'Help & Support',
                    subtitle: 'FAQs and contact customer service',
                    onTap: () {},
                  ),
                  Divider(
                    height: 1, 
                    indent: 56, 
                    endIndent: 16,
                    color: isDarkMode ? AppTheme.borderDark : Colors.grey[200],
                  ),
                  BuildProfileMenuItems(
                    icon: Icons.info_outline,
                    title: 'About App',
                    subtitle: 'ShopEase v1.0.0',
                    onTap: () {},
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  foregroundColor: theme.colorScheme.error,
                  side: BorderSide(color: theme.colorScheme.error, width: 1.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  // Sign out action
                },
                icon: const Icon(Icons.logout),
                label: const Text(
                  'Log Out',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}