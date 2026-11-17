import 'package:flutter/material.dart';
import 'package:e_comerce_project/constants/app_theme.dart';

class BuildProfileMenuItems extends StatefulWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const BuildProfileMenuItems({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  State<BuildProfileMenuItems> createState() => _BuildProfileMenuItemsState();
}

class _BuildProfileMenuItemsState extends State<BuildProfileMenuItems> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return ListTile(
      onTap: widget.onTap,
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isDarkMode 
              ? theme.colorScheme.surface 
              : theme.colorScheme.primary,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          widget.icon,
          color: theme.colorScheme.primary,
          size: 22,
        ),
      ),
      title: Text(
        widget.title,
        style: theme.textTheme.titleLarge?.copyWith(
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        widget.subtitle,
        style: theme.textTheme.bodyMedium?.copyWith(
          fontSize: 12,
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color:  AppTheme.textSecondary ,
      ),
    );
  }
}