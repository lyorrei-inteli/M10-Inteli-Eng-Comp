// cart_screen.dart
// Tela de carrinho de compras. Exibe os produtos adicionados ao carrinho e o valor total.

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx_carrinho/controllers/cart_controller.dart';
import 'package:mobx_carrinho/models/product_model.dart';

class CartScreen extends StatelessWidget {
  final CartController cartController;

  CartScreen({required this.cartController});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carrinho'),
      ),
      body: Observer(
        builder: (_) {
          return ListView.builder(
            itemCount: cartController.products.length,
            itemBuilder: (context, index) {
              Product product = cartController.products[index];
              return ListTile(
                title: Text(product.name),
                subtitle: Text('R\$ ${product.price.toStringAsFixed(2)}'),
                trailing: IconButton(
                  icon: Icon(Icons.remove_shopping_cart),
                  onPressed: () {
                    cartController.removeProduct(product);
                  },
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Observer(builder: (_) {
                return Text('Total: R\$ ${cartController.totalValue.toStringAsFixed(2)}');
              }),
              ElevatedButton(
                onPressed: () {
                  cartController.products.clear();
                },
                child: Text('Limpar carrinho'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}