import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:e_comerce_project/constants/api_endpoints.dart';
import 'package:e_comerce_project/models/product/product.dart';

class NetworkService {
  
  static Future<List<Product>> searchProducts(String query) async {
    final url = Uri.https(ApiEndpoints.baseUrl, ApiEndpoints.searchProducts, {
      'q': query,
    });

    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception('Failed to search products: HTTP ${response.statusCode}');
    }

    final data = jsonDecode(response.body) as Map<String, dynamic>;
    final productsJson = data['products'] as List<dynamic>;

    return productsJson
        .map((json) => Product.fromJson(json as Map<String, dynamic>))
        .toList();
  }

 static Future<List<Product>> fetchProducts({int skip = 0, int limit = 10}) async {
  final url = Uri.https(ApiEndpoints.baseUrl,ApiEndpoints.getProducts, {
    'limit': '$limit',
    'skip': '$skip',
  });

  final response = await http.get(url);

  if (response.statusCode != 200) {
    throw Exception('Failed to load products: HTTP ${response.statusCode}');
  }

  final data = jsonDecode(response.body) as Map<String, dynamic>;
  final productsJson = data['products'] as List<dynamic>;
  return productsJson
      .map((json) => Product.fromJson(json as Map<String, dynamic>))
      .toList();
}
}