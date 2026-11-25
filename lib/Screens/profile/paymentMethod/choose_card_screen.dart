import 'package:e_comerce_project/Screens/home/widgets/navagation_bar.dart';
import 'package:e_comerce_project/Screens/profile/paymentMethod/leez_card_screen.dart';
import 'package:e_comerce_project/Screens/profile/paymentMethod/widgets/leez_card_widget.dart';
import 'package:e_comerce_project/Widgets/buttons/card_type_buttons.dart';
import 'package:e_comerce_project/Widgets/buttons/color_selector_button.dart';
import 'package:e_comerce_project/Widgets/buttons/continue_buttons.dart';
import 'package:e_comerce_project/Widgets/buttons/icon_buttons.dart';
import 'package:flutter/material.dart';

class ChooseCardScreen extends StatefulWidget {
  const ChooseCardScreen({super.key});

  @override
  State<ChooseCardScreen> createState() => _ChooseCardScreenState();
}

class _ChooseCardScreenState extends State<ChooseCardScreen> {
  
  final List<Color> _cardColors = const [
    Color(0xFF3E1168), 
    Color.fromARGB(255, 33, 168, 116), 
    Color.fromARGB(255, 83, 108, 211), 
  ];

  int _selectedColorIndex = 0;
  int _selectedCardTypeIndex = 0;

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
                      'Choose your card',
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
                          MaterialPageRoute(
                            builder: (context) => const NavagateBar(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 28),

                LeezCardWidget(
                  cardColor: _cardColors[_selectedColorIndex],
                  cardHolderName: 'ABDULLAH OTHMAN',
                  lastFourDigits: '4821',
                ),

                const SizedBox(height: 22),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(_cardColors.length, (index) {
                    return ColorSelectorButton(
                      color: _cardColors[index],
                      isSelected: _selectedColorIndex == index,
                      onTap: () {
                        setState(() {
                          _selectedColorIndex = index;
                        });
                      },
                    );
                  }),
                ),
                const SizedBox(height: 30),

                // Section Title
                Text(
                  'Card type',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),

                // Card Type Buttons
                CardTypeButton(
                  name: 'Digital card',
                  description: 'Ready now · add it to Apple or Google Wallet',
                  isFree: true,
                  isSelected: _selectedCardTypeIndex == 0,
                  onTap: () {
                    setState(() {
                      _selectedCardTypeIndex = 0;
                    });
                  },
                ),
                const SizedBox(height: 14),
                CardTypeButton(
                  name: 'Digital + physical card',
                  description: 'Delivered to Tripoli in 3–5 days',
                  isFree: true,
                  isSelected: _selectedCardTypeIndex == 1,
                  onTap: () {
                    setState(() {
                      _selectedCardTypeIndex = 1;
                    });
                  },
                ),

                const SizedBox(height: 24),
                CardButton(
                  text: "Continue",
                  backgroundColor: theme.colorScheme.primary,
                  foregroundColor: Colors.white,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LeezCard(
                          selectedColor: _cardColors[_selectedColorIndex],
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }
}