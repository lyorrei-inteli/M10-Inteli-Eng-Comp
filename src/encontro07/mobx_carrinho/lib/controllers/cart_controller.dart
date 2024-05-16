// cart_controller.dart
// Arquivo de controlador de carrinho. Mantém a lista de produtos adicionados ao carrinho e o valor total.

import 'package:mobx/mobx.dart';
import 'package:mobx_carrinho/models/product_model.dart';

part 'cart_controller.g.dart';

class CartController = _CartControllerBase with _$CartController;

abstract class _CartControllerBase with Store {
  @observable
  ObservableList<Product> products = ObservableList<Product>();

  @computed
  double get totalValue => products.fold(0, (total, product) => total + product.price);

  @action
  void addProduct(Product product) {
    products.add(product);
  }

  @action
  void removeProduct(Product product) {
    products.remove(product);
  }
}