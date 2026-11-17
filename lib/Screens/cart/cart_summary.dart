import 'package:flutter/material.dart';
import 'package:e_comerce_project/constants/app_theme.dart';

class CardSummary extends StatelessWidget {
  final int totalProducts;
  final double subtotal;
  final double totalPrice;
  final VoidCallback onCheckout;
  
  const CardSummary({
    super.key,
    required this.totalProducts,
    required this.subtotal,
    required this.totalPrice,
    required this.onCheckout,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        border: Border.all(
          color: isDarkMode ? AppTheme.borderDark : const Color(0xFF000000),
          width: 2,
        ),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Cart Summary',
              style: theme.textTheme.titleLarge?.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            _summaryRow(context, 'Total Products:', '$totalProducts'),
            const SizedBox(height: 6),
            _summaryRow(context, 'Subtotal:', '\$${subtotal.toStringAsFixed(2)}'),
            const SizedBox(height: 6),
            _summaryRow(context, 'Shipping:', 'Free'),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Divider(thickness: 1),
            ),
            _summaryRow(
              context,
              'Total Price:',
              '\$${totalPrice.toStringAsFixed(2)}',
              isBold: true,
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: onCheckout,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF6B1A),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Proceed to Checkout',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _summaryRow(BuildContext context, String label, String value, {bool isBold = false}) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    final style = theme.textTheme.bodyMedium?.copyWith(
      fontSize: isBold ? 16 : 14,
      fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
      color: isBold 
          ? (isDarkMode ? Colors.white : Colors.black) 
          : (isDarkMode ? AppTheme.textSecondary : Colors.grey[700]),
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: style),
        Text(value, style: style),
      ],
    );
  }
}