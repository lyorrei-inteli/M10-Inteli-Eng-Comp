// product_view.dart
// Arquivo de tela de visualização de lista de produtos

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx_carrinho/controllers/cart_controller.dart';
import 'package:mobx_carrinho/controllers/product_controller.dart';
import 'package:mobx_carrinho/models/product_model.dart';

class ProductView extends StatelessWidget {
  final ProductController productController;
  final CartController cartController;

  ProductView({required this.productController, required this.cartController});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Produtos'),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.pushNamed(context, '/cart');
            },
          ),
        ],
      ),
      body: Observer(
        builder: (_) {
          return ListView.builder(
            itemCount: productController.products.length,
            itemBuilder: (context, index) {
              Product product = productController.products[index];
              return ListTile(
                title: Text(product.name),
                subtitle: Text('R\$ ${product.price.toStringAsFixed(2)}'),
                trailing: IconButton(
                  icon: Icon(Icons.add_shopping_cart),
                  onPressed: () {
                    cartController.addProduct(product);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}