import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:e_comerce_project/models/cart/cart.dart';

class CartProvider with ChangeNotifier {
   List<CartItem> _items = [];

  List<CartItem> get items => _items;

  CartProvider() {
    loadCartFromLocalStorage();
  }
  Future<void> _saveCartToLocalStorage() async {
    final prefs = await SharedPreferences.getInstance();
    final String encodedData = jsonEncode(
      _items.map((item) => item.toJson()).toList(),
    );
    await prefs.setString('saved_cart_items', encodedData);
  }
 Future<void> loadCartFromLocalStorage() async {
    final prefs = await SharedPreferences.getInstance();
    final String? encodedData = prefs.getString('saved_cart_items');

    if (encodedData != null) {
      final List<dynamic> decodedList = jsonDecode(encodedData);
      _items = decodedList.map((item) => CartItem.fromJson(item)).toList();
      notifyListeners();
    }
  }
   void addProductToCart({
    required String id,
    required String title,
    required String description,
    required double price,
    required String imageUrl,
  }) {
    final existingIndex = _items.indexWhere((item) => item.id == id);

    if (existingIndex >= 0) {
      _items[existingIndex].quantity += 1;
    } else {
      _items.add(
        CartItem(
          id: id,
          title: title,
          description: description,
          price: price,
          imageUrl: imageUrl,
          quantity: 1,
        ),
      );
    }
    notifyListeners();
    _saveCartToLocalStorage();
  }
  void incrementQuantity(String id) {
    final index = _items.indexWhere((item) => item.id == id);
    if (index >= 0) {
      _items[index].quantity++;
      notifyListeners(); 
      _saveCartToLocalStorage();
    }
  }
  void decrementQuantity(String id) {
    final index = _items.indexWhere((item) => item.id == id);
    if (index >= 0) {
      if (_items[index].quantity > 1) {
        _items[index].quantity--;
      } else {
        _items.removeAt(index); 
      }
      notifyListeners();
      _saveCartToLocalStorage();
    }
  }
  void removeItem(String id) {
    _items.removeWhere((item) => item.id == id);
    notifyListeners();
    _saveCartToLocalStorage();
  }
  double get totalPrice {
    double total = 0.0;
    for (var item in _items) {
      total += item.price * item.quantity;
    }
    return total;
  }
}
