---
sidebar_position: 6
title: MobX e Exemplo de Implementação
---

import useBaseUrl from '@docusaurus/useBaseUrl';
import Tabs from '@theme/Tabs';
import TabItem from '@theme/TabItem';

## Definição do Problema

Nosso problema é um recorte de aplicação que vai contemplar alguns pontos importantes:

- Utilização da arquitetura MVC;
- Utilização de listas para exibir os produtos;
- Adição de produtos ao carrinho de compras;
- Exibição do total da compra.

Para resolver esse problema, vamos utilizar o MobX. O MobX é uma biblioteca que permite a criação de observáveis e reações de forma simples e eficiente. A documentação do MobX pode ser encontrada [aqui](https://pub.dev/packages/mobx).

Agora vamos para nossa aplicação!!

## Criando o projeto base

Vamos criar um projeto base para a nossa aplicação. Para isso, vamos utilizar o comando `flutter create mobx_carrinho`.

```bash
flutter create mobx_carrinho
```

O MobX não é um pacote oficial do Flutter, então precisamos adicionar o pacote ao nosso arquivo `pubspec.yaml`. Isso pode ser realizado editando o arquivo, ou utilizando o comando `flutter pub add mobx`. Além dele, vamos adicionar o pacote `flutter_mobx` que é uma extensão do MobX para o Flutter.

```bash
flutter pub add mobx
flutter pub add flutter_mobx
```

Agora vamos construir nossa aplicação. Primeiro, vamos criar a estrutura de pastas do nosso projeto. Vamos criar as pastas `models`, `controllers` e `views`. De acordo com o avanço da aplicação, vamos criando os arquivos necessários. Agora, dentro do nosso diretório de `views`, vamos criar um outro diretório com o nome de `screens`. Esse diretório vai conter as telas da nossa aplicação. A princípio, nossa aplicação vai ter duas telas: a tela de listagem de produtos e a tela de carrinho de compras.

Vamos criar os arquivos `product_list_screen.dart` e `cart_screen.dart` dentro do diretório `screens`. Vamos começar a escrever o código da nossa `product_list_screen.dart`.

```dart
// product_view.dart
// Arquivo de tela de visualização de lista de produtos

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx_carrinho/controllers/cart_controller.dart';
import 'package:mobx_carrinho/controllers/product_controller.dart';
import 'package:mobx_carrinho/models/product.dart';

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
```

Ao observar nossa aplicação, estamos utilizando o Scaffold para construir a tela. No corpo da tela, estamos utilizando um `ListView.builder` para exibir a lista de produtos. O `ListView.builder` é um widget que constrói os itens da lista sob demanda. Isso significa que ele só constrói os itens que estão visíveis na tela. Isso é importante para otimizar a performance da aplicação. Se diversos itens fossem construídos ao mesmo tempo, a aplicação poderia ficar lenta. Desta forma, mesmo que a lista tenha milhares de itens, o `ListView.builder` só vai construir os itens que estão visíveis na tela.

> Mas Murilo e quando os itens saem da tela de visão do usuário? Eles são destruídos?

Sim, eles são destruídos. O `ListView.builder` é um widget que constrói os itens sob demanda. Quando um item sai da tela de visão do usuário, ele é destruído. Quando o usuário rola a tela para cima ou para baixo, o `ListView.builder` constrói os itens que estão visíveis na tela.

Não vamos conseguir executar nosso projeto ainda. Não temos implementado nossos modelos e controladores. Vamos implementar nosso modelo de produto. Ele já vai ser implementado com o `MobX`. Ele vai ser responsável por gerenciar o estado dos produtos. Por hora, para simular o carregamento dos produtos, vamos criar um método `loadProducts` que vai adicionar alguns produtos na lista de JSON, previamente definida nos assets da aplicação. 

:::tip[Dependências do MobX]

Pessoal, não esqueçam de adicionar as dependências do MobX no arquivo `pubspec.yaml`. Vamos adicionar o pacote `mobx` e o pacote `flutter_mobx`.

```bash

flutter pub add mobx
flutter pub add flutter_mobx

```

:::

```dart
// product_model.dart

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
```

Agora vamos adicionar alguns produtos dentro deste nosso arquivo JSON. Vamos criar um arquivo `products.json` dentro do diretório `assets`. Vamos adicionar o seguinte conteúdo:

```json
[
  {
    "name": "Camiseta",
    "price": 29.99
  },
  {
    "name": "Calça",
    "price": 59.99
  },
  {
    "name": "Tênis",
    "price": 99.99
  },
  {
    "name": "Boné",
    "price": 19.99
  }
]
```

Adicionar o nosso recurso no arquivo `pubspec.yaml`:

```yaml
flutter:
  assets:
    - assets/products.json
```



