// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CartController on _CartControllerBase, Store {
  Computed<double>? _$totalValueComputed;

  @override
  double get totalValue =>
      (_$totalValueComputed ??= Computed<double>(() => super.totalValue,
              name: '_CartControllerBase.totalValue'))
          .value;

  late final _$productsAtom =
      Atom(name: '_CartControllerBase.products', context: context);

  @override
  ObservableList<Product> get products {
    _$productsAtom.reportRead();
    return super.products;
  }

  @override
  set products(ObservableList<Product> value) {
    _$productsAtom.reportWrite(value, super.products, () {
      super.products = value;
    });
  }

  late final _$_CartControllerBaseActionController =
      ActionController(name: '_CartControllerBase', context: context);

  @override
  void addProduct(Product product) {
    final _$actionInfo = _$_CartControllerBaseActionController.startAction(
        name: '_CartControllerBase.addProduct');
    try {
      return super.addProduct(product);
    } finally {
      _$_CartControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeProduct(Product product) {
    final _$actionInfo = _$_CartControllerBaseActionController.startAction(
        name: '_CartControllerBase.removeProduct');
    try {
      return super.removeProduct(product);
    } finally {
      _$_CartControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
products: ${products},
totalValue: ${totalValue}
    ''';
  }
}
