import 'package:flutter/material.dart';
import 'package:e_comerce_project/Networking/networking.dart';
import 'package:e_comerce_project/models/product/product.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _products = [];
  DateTime? _lastFetchTime;
  bool _isLoading = false;
  String? _error;

  List<Product> get products => _products;
  bool get isLoading => _isLoading;
  String? get error => _error;

  bool get _isCacheValid {
    if (_lastFetchTime == null) return false;
    final difference = DateTime.now().difference(_lastFetchTime!);
    return difference.inMinutes < 10;
  }


  Future<void> fetchInitialProducts({int limit = 10, bool forceRefresh = false}) async {
    if (_isCacheValid && !forceRefresh && _products.isNotEmpty) {
      return; 
    }

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _products = await NetworkService.fetchProducts(skip: 0, limit: limit);
      _lastFetchTime = DateTime.now();
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<List<Product>> loadMoreProducts({int skip = 0, int limit = 10}) async {
    try {
      final newProducts = await NetworkService.fetchProducts(skip: skip, limit: limit);
      _products.addAll(newProducts);
      notifyListeners();
      return newProducts;
    } catch (e) {
      rethrow;
    }
  }

  void setProducts(List<Product> newProducts) {
    _products = newProducts;
    notifyListeners();
  }
}