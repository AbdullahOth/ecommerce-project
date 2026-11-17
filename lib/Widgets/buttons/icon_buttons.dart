import 'package:flutter/material.dart';
import 'package:e_comerce_project/constants/app_theme.dart';

class BuildCircleIconButton extends StatelessWidget {
   final IconData? icon;
   final VoidCallback? onTap;

  const BuildCircleIconButton({
    super.key,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: isDarkMode ? theme.colorScheme.surface : const Color(0xFFF3EFEA),
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          size: 20,
          color: isDarkMode ? Colors.white : AppTheme.textPrimary,
        ),
      ),
    );
  }
}