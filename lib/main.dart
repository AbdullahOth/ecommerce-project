import 'package:e_comerce_project/constants/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:e_comerce_project/providers/cart_provider.dart';
import 'package:e_comerce_project/providers/product_provider.dart';
import 'package:e_comerce_project/Screens/home/widgets/navagation_bar.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => CartProvider()),
      ChangeNotifierProvider(create: (_) => ProductProvider()), 
    ],
    child: MaterialApp(
        debugShowCheckedModeBanner: false, 
        title: 'Login App',
        theme: AppTheme.lightTheme,      
        darkTheme: AppTheme.darkTheme,   
        themeMode: ThemeMode.system,
        home: const NavagateBar(), 
      ),
  ));
}
