import 'package:flutter/material.dart';
import 'package:e_comerce_project/constants/app_theme.dart';

class CustomInputField extends StatefulWidget {
  final String title;
  final String hintText;
  final bool isPassword;
  final IconData? prefixIcon;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  
  const CustomInputField({
    super.key,
    required this.title,
    required this.hintText,
    this.isPassword = false,
    this.prefixIcon,
    this.validator,
    this.controller,
  });

  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: theme.textTheme.titleLarge?.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        
        TextFormField( 
          controller: widget.controller,
          validator: widget.validator,
          obscureText: widget.isPassword && !isVisible,
          style: theme.textTheme.bodyLarge,
          decoration: InputDecoration(
            errorMaxLines: 2,
            errorBorder: OutlineInputBorder(
             borderRadius: BorderRadius.circular(12),
             borderSide: BorderSide(color: theme.colorScheme.error, width: 1.5), 
            ),
            focusedErrorBorder: OutlineInputBorder(
             borderRadius: BorderRadius.circular(12),
             borderSide: BorderSide(color: theme.colorScheme.error, width: 2.0),
            ),
            hintText: widget.hintText,
            hintStyle: theme.textTheme.bodyMedium?.copyWith(
              color: isDarkMode ? AppTheme.textSecondary : Colors.grey,
            ),
            filled: true,
            fillColor: isDarkMode ? theme.colorScheme.surface : const Color(0xFFF3EFEA),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            prefixIcon: widget.prefixIcon != null 
                ? Icon(widget.prefixIcon, color: isDarkMode ? AppTheme.textSecondary : Colors.grey) 
                : null,
            suffixIcon: widget.isPassword 
                ? IconButton(
                    icon: Icon(
                      isVisible ? Icons.visibility : Icons.visibility_off, 
                      color: isDarkMode ? AppTheme.textSecondary : Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        isVisible = !isVisible;
                      });
                    },
                  )
                : null, 
          ),
        ),
      ],
    );
  }
}