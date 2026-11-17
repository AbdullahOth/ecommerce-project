import 'package:e_comerce_project/Screens/home/home_page_screen.dart';
import 'package:e_comerce_project/Screens/profile/paymentMethod/widgets/leez_card_widget.dart';
import 'package:e_comerce_project/Widgets/buttons/continue_buttons.dart';
import 'package:e_comerce_project/Widgets/buttons/icon_buttons.dart';
import 'package:flutter/material.dart';
import 'package:e_comerce_project/constants/app_theme.dart';

class LeezCard extends StatefulWidget {
  final Color selectedColor;

  const LeezCard({super.key, required this.selectedColor});
  @override
  State<LeezCard> createState() => _LeezCardState();
}

class _LeezCardState extends State<LeezCard> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BuildCircleIconButton(
                      icon: Icons.arrow_back_ios_new_rounded,
                      onTap: () => Navigator.maybePop(context),
                    ),
                    Text(
                      "Leez Card",
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    BuildCircleIconButton(
                      icon: Icons.home_outlined,
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const HomeScreen()),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 28),
                Text(
                  'Pay in 4 anywhere with your Leez Card',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Use it in any shop, online or in_store. Every purchase is split into 4 payments.',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.primary,
                    fontSize: 15.5,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 28),
                LeezCardWidget(
                  cardColor: widget.selectedColor,
                  cardHolderName: 'ABDULLAH OTHMAN',
                  lastFourDigits: '4821',
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'USD 1,250 ',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        fontSize: 15.3,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'available to spend',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.primary,
                        fontSize: 14.5,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                eCard(
                  context,
                  '0',
                  'Free, with no card fees ',
                  'No yearly fee and no interest, ever',
                  widget.selectedColor,
                  theme.colorScheme.primary,
                ),
                const SizedBox(height: 15),
                eCard(
                  context,
                  '4',
                  'Every purchase in 4 payments ',
                  'See your plain in the app after tou pay ',
                  widget.selectedColor,
                  theme.colorScheme.primary,
                ),
                const SizedBox(height: 30),
                CardButton(
                  text: "Get my free card",
                  backgroundColor: theme.colorScheme.primary,
                  foregroundColor: Colors.white,
                  onPressed: () {},
                ),
                const SizedBox(height: 3),
                Center(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: theme.colorScheme.surface,
                      foregroundColor: theme.colorScheme.primary,
                    ),
                    onPressed: () {},
                    child: const Text("How it works"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget eCard(BuildContext context, String num, String title, String desc, Color dark, Color prime) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          height: 45,
          width: 45,
          decoration: BoxDecoration(shape: BoxShape.circle, color: dark),
          child: Center(
            child: Text(num, style: const TextStyle(color: Colors.white)),
          ),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: theme.textTheme.titleLarge?.copyWith(
                color: isDarkMode ? Colors.white : dark,
                fontSize: 15.3,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              desc,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: isDarkMode ? AppTheme.textSecondary : prime,
                fontSize: 14.5,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ],
    );
  }
}