import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:e_comerce_project/Screens/auth/complete_screen.dart';

class OtpInputWidget extends StatefulWidget {
  const OtpInputWidget({super.key});

  @override
  State<OtpInputWidget> createState() => _OtpInputWidgetState();
}

class _OtpInputWidgetState extends State<OtpInputWidget> {
  final TextEditingController pinController = TextEditingController();
  
  @override
  void dispose() {
    pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    final defaultPinTheme = PinTheme(
      width: 50,
      height: 50,
      textStyle: theme.textTheme.titleLarge?.copyWith(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      decoration: BoxDecoration(
        color: isDarkMode ? theme.colorScheme.surface : const Color(0xFFF3EFEA),
        shape: BoxShape.circle,
      ),
    );

    return Pinput(
      controller: pinController,
      length: 5,
      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: defaultPinTheme.copyWith(
        decoration: BoxDecoration(
          color: isDarkMode ? theme.colorScheme.surface : const Color(0xFFE5E7EB),
          shape: BoxShape.circle,
          border: Border.all(color: theme.colorScheme.primary, width: 1.5),
        ),
      ),
      onCompleted: (pin) {
        String code = "00000";
        if (pin == code) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SuccessScreen(),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Error: Your OTP Code Was Wrong please Check your phone number then Resend OTP',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              backgroundColor: Colors.amber,
            ),
          );
          pinController.clear();
        }
      },
    );
  }
}