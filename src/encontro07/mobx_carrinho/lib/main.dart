// main.dart


import 'package:flutter/material.dart';
import 'package:mobx_carrinho/controllers/cart_controller.dart';
import 'package:mobx_carrinho/controllers/product_controller.dart';
import 'package:mobx_carrinho/views/screens/cart_screen.dart';
import 'package:mobx_carrinho/views/screens/product_view.dart';

void main() {
  final productController = ProductController();
  final cartController = CartController();

  WidgetsFlutterBinding.ensureInitialized();
  productController.loadProducts();

  runApp(MyApp(productController: productController, cartController: cartController));
}

class MyApp extends StatelessWidget {
  final ProductController productController;
  final CartController cartController;

  MyApp({required this.productController, required this.cartController});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MobX Carrinho',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => ProductView(productController: productController, cartController: cartController),
        '/cart': (context) => CartScreen(cartController: cartController),
      },
    );
  }
}