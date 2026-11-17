import 'package:e_comerce_project/Screens/cart/cart_summary.dart';
import 'package:e_comerce_project/providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:e_comerce_project/models/cart/widgets/cart_widget.dart';
import 'package:e_comerce_project/constants/app_theme.dart';

class CardScreen extends StatefulWidget {
  const CardScreen({
    super.key,
  });

  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  @override
  Widget build(BuildContext context) {
    final cartProvider = context.watch<CartProvider>();
    final cartItems = cartProvider.items;
    int count = cartItems.length;

    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        scrolledUnderElevation: 0, 
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new, 
            color: isDarkMode ? Colors.white : Colors.black, 
            size: 20,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'My Shopping Cart',
          style: theme.textTheme.titleLarge?.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Text(
                '$count items', 
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: isDarkMode ? AppTheme.textSecondary : Colors.grey[700],
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await cartProvider.loadCartFromLocalStorage();
        },
        child: cartItems.isEmpty 
            ? ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  const SizedBox(height: 200),
                  Center(
                    child: Text(
                      'Your cart is empty',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: isDarkMode ? AppTheme.textSecondary : Colors.grey,
                      ),
                    ),
                  ),
                ],
              )
            : ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(16),
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  final item = cartItems[index];
                  return CartWidget(
                    imageUrl: item.imageUrl,
                    title: item.title,
                    description: item.description,
                    price: item.price,
                    quantity: item.quantity,
                    onDelete: () {
                      context.read<CartProvider>().removeItem(item.id);
                    },
                    onIncrement: () {
                      context.read<CartProvider>().incrementQuantity(item.id);
                    },
                    onDecrement: () {
                      context.read<CartProvider>().decrementQuantity(item.id);
                    },
                  );
                },
              ),
      ),
      bottomNavigationBar: CardSummary(
        onCheckout: () {},
        subtotal: cartProvider.totalPrice,
        totalPrice: cartProvider.totalPrice,
        totalProducts: cartItems.length,
      ),
    );
  }
}