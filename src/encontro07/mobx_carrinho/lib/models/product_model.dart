// product_model.dart
// Arquivo de modelo de produto. Carrega os dados dos produtos de um arquivo JSON dos assets.

import 'dart:convert';

import 'package:flutter/services.dart';

class Product {
  final String name;
  final double price;

  Product({required this.name, required this.price});

  static Future<List<Product>> loadProducts() async {
    String productsJson = await rootBundle.loadString('assets/products.json');
    List<dynamic> productsList = jsonDecode(productsJson);

    return productsList
        .map((product) => Product(name: product['name'], price: product['price']))
        .toList();
  }
}