import 'package:e_comerce_project/Screens/home/widgets/app_bar.dart';
import 'package:e_comerce_project/Screens/home/widgets/product_skeleton.dart';
import 'package:e_comerce_project/models/product/widgets/product_widgets.dart';
import 'package:e_comerce_project/providers/cart_provider.dart';
import 'package:e_comerce_project/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:e_comerce_project/constants/app_theme.dart';
import 'package:e_comerce_project/Networking/networking.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const int _pageSize = 10;
  final ScrollController _scrollController = ScrollController();
  
  bool _isLoadingMore = false;
  bool _hasMore = true;
  String? _loadMoreError;
  String _searchQuery = '';
  int _requestGeneration = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductProvider>().fetchInitialProducts(limit: _pageSize);
    });
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.extentAfter < 300) {
      _loadNextPage();
    }
  }

  Future<void> _searchProducts(String query) async {
    final requestGeneration = ++_requestGeneration;
    setState(() {
      _searchQuery = query;
      _hasMore = query.isEmpty;
      _isLoadingMore = false;
      _loadMoreError = null;
    });

    final productProvider = context.read<ProductProvider>();

    try {
      final searchedProducts = query.isEmpty
          ? await NetworkService.fetchProducts(limit: _pageSize)
          : await NetworkService.searchProducts(query);

      if (requestGeneration != _requestGeneration) return;
      if (!mounted) return;

      productProvider.setProducts(searchedProducts);
      setState(() {
        _hasMore = query.isEmpty && searchedProducts.length == _pageSize;
      });
    } catch (error) {
      if (requestGeneration != _requestGeneration) return;
      if (!mounted) return;
    }
  }

  Future<void> _loadNextPage() async {
    final productProvider = context.read<ProductProvider>();
    
    if (productProvider.isLoading ||
        _isLoadingMore ||
        !_hasMore ||
        _searchQuery.isNotEmpty ||
        _loadMoreError != null) {
      return;
    }

    setState(() {
      _isLoadingMore = true;
    });

    final requestGeneration = _requestGeneration;
    final skip = productProvider.products.length;
    
    try {
      final newProducts = await productProvider.loadMoreProducts(skip: skip, limit: _pageSize);
      if (requestGeneration != _requestGeneration) return;
      if (!mounted) return;
      
      setState(() {
        _hasMore = newProducts.length == _pageSize;
        _isLoadingMore = false;
      });
    } catch (error) {
      if (requestGeneration != _requestGeneration) return;
      if (!mounted) return;
      
      setState(() {
        _loadMoreError = error.toString();
        _isLoadingMore = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = context.watch<ProductProvider>();
    final products = productProvider.products;

    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120),
        child: AppBarWedgit(
          onSearchChanged: (query) {
            _searchProducts(query);
          },
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await productProvider.fetchInitialProducts(limit: _pageSize, forceRefresh: true);
          setState(() {
            _searchQuery = '';
            _hasMore = true;
            _loadMoreError = null;
          });
        },
        child: productProvider.isLoading && products.isEmpty
            ? ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 5, 
          padding: const EdgeInsets.all(12),
          itemBuilder: (context, index) {
            return const ProductSkeletonItem();
          },
        )
            : productProvider.error != null
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Error: ${productProvider.error}',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.error,
                          ),
                        ),
                        const SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: () {
                            productProvider.fetchInitialProducts(limit: _pageSize, forceRefresh: true);
                          },
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  )
                : products.isEmpty
                    ? ListView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        children: [
                          const SizedBox(height: 250),
                          Center(
                            child: Text(
                              'No Product Available Now',
                              style: theme.textTheme.bodyLarge?.copyWith(
                                color: isDarkMode ? AppTheme.textSecondary : Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      )
                    : ListView.builder(
                        controller: _scrollController,
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: products.length +
                            (_isLoadingMore || _loadMoreError != null ? 1 : 0),
                        padding: const EdgeInsets.all(12),
                        itemBuilder: (context, index) {
                          if (index == products.length) {
                            if (_loadMoreError != null) {
                              return Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  children: [
                                    Text(
                                      'Error loading more products: $_loadMoreError',
                                      style: theme.textTheme.bodyMedium?.copyWith(
                                        color: theme.colorScheme.error,
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        setState(() {
                                          _loadMoreError = null;
                                        });
                                        _loadNextPage();
                                      },
                                      child: const Text('Retry'),
                                    ),
                                  ],
                                ),
                              );
                            }
                            return const Padding(
                              padding: EdgeInsets.all(16),
                              child: Center(child: CircularProgressIndicator()),
                            );
                          }

                          final product = products[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: SizedBox(
                              height: 340,
                              child: ProductForm(
                                imageUrl: product.thumbnail,
                                title: product.title,
                                description: product.description,
                                price: product.price,
                                onPressed: () {
                                  context.read<CartProvider>().addProductToCart(
                                        id: product.id.toString(),
                                        title: product.title,
                                        description: product.description,
                                        price: product.price,
                                        imageUrl: product.thumbnail,
                                      );

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Added to cart!',
                                        style: TextStyle(color: AppTheme.surfaceLight),
                                      ),
                                      duration: Duration(milliseconds: 300),
                                      backgroundColor: AppTheme.primaryColor,
                                    ),
                                  );
                                },
                              ),
                            ),
                          );
                        },
                      ),
      ),
    );
  }
}