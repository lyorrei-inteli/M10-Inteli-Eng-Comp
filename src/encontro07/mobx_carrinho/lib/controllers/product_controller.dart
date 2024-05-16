// product_controller.dart
// Arquivo de controlador de produto. Carrega os produtos do modelo e os mantém em uma lista observável.

import 'package:mobx/mobx.dart';
import 'package:mobx_carrinho/models/product_model.dart';

part 'product_controller.g.dart';

class ProductController = _ProductControllerBase with _$ProductController;

abstract class _ProductControllerBase with Store {
  @observable
  ObservableList<Product> products = ObservableList<Product>();

  @action
  void loadProducts() {
    Product.loadProducts().then((value) => products = value.asObservable());
  }
}
