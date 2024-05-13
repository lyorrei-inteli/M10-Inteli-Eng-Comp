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

Vamos criar um projeto base para a nossa aplicação. Para isso, vamos utilizar o comando `flutter create mobx_example`.

```bash
flutter create mobx_example
```

O MobX não é um pacote oficial do Flutter, então precisamos adicionar o pacote ao nosso arquivo `pubspec.yaml`. Isso pode ser realizado editando o arquivo, ou utilizando o comando `flutter pub add mobx`. Além dele, vamos adicionar o pacote `flutter_mobx` que é uma extensão do MobX para o Flutter.

```bash
flutter pub add mobx
flutter pub add flutter_mobx
```

Agora vamos construir nossa aplicação. Primeiro, vamos criar a estrutura de pastas do nosso projeto. Vamos criar as pastas `models`, `controllers` e `views`. De acordo com o avanço da aplicação, vamos criando os arquivos necessários. Agora, dentro do nosso diretório de `views`, vamos criar um outro diretório com o nome de `screens`. Esse diretório vai conter as telas da nossa aplicação. A princípio, nossa aplicação vai ter duas telas: a tela de listagem de produtos e a tela de carrinho de compras.

Vamos criar os arquivos `product_list_screen.dart` e `cart_screen.dart` dentro do diretório `screens`. Vamos começar a escrever o código da nossa `product_list_screen.dart`.

```dart
import 'package:flutter/material.dart';
import 'package:mobx_example/controllers/product_controller.dart';

class ProductListScreen extends StatelessWidget {
  final ProductController controller = ProductController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Produtos'),
      ),
      body: ListView.builder(
        itemCount: controller.products.length,
        itemBuilder: (context, index) {
          ProductModel product = controller.products[index];
          return ListTile(
            header: Image.network(product.image),
            title: Text(product.name),
            subtitle: Text('R\$ ${product.price.toStringAsFixed(2)}'),
            trailing: IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                controller.addToCart(product);
              },
            ),
          );
        },
      ),
    );
  }
}
```

Ao observar nossa aplicação, estamos utilizando o Scaffold para construir a tela. No corpo da tela, estamos utilizando um `ListView.builder` para exibir a lista de produtos. Para cada produto, estamos exibindo a imagem, o nome, o preço e um botão para adicionar o produto ao carrinho de compras.

O `ListView.builder` é um widget que constrói os itens da lista sob demanda. Isso significa que ele só constrói os itens que estão visíveis na tela. Isso é importante para otimizar a performance da aplicação. Se diversos itens fossem construídos ao mesmo tempo, a aplicação poderia ficar lenta. Desta forma, mesmo que a lista tenha milhares de itens, o `ListView.builder` só vai construir os itens que estão visíveis na tela.

> Mas Murilo e quando os itens saem da tela de visão do usuário? Eles são destruídos?

Sim, eles são destruídos. O `ListView.builder` é um widget que constrói os itens sob demanda. Quando um item sai da tela de visão do usuário, ele é destruído. Quando o usuário rola a tela para cima ou para baixo, o `ListView.builder` constrói os itens que estão visíveis na tela.

Não vamos conseguir executar nosso projeto ainda. Não temos implementado nossos modelos e controladores. Vamos implementar nosso modelo de produto. Ele já vai ser implementado com o `MobX`. Ele vai ser responsável por gerenciar o estado dos produtos. Por hora, para simular o carregamento dos produtos, vamos criar um método `loadProducts` que vai adicionar alguns produtos na lista de JSON, previamente definida nos assets da aplicação. 

```dart
import 'package:mobx/mobx.dart';
import 'package:mobx_example/models/product_model.dart';
import 'package:flutter/services.dart' show rootBundle;

part 'product_controller.g.dart';

class ProductController = _ProductControllerBase with _$ProductController;

abstract class _ProductControllerBase with Store {
  @observable
  ObservableList<ProductModel> products = ObservableList<ProductModel>();

  @action
  Future<void> loadProducts() async {
    String data = await rootBundle.loadString('assets/products.json');
    List<dynamic> json = jsonDecode(data);
    products = json.map((e) => ProductModel.fromJson(e)).toList().asObservable();
  }

  @action
  void addToCart(ProductModel product) {
    product.quantity++;
  }
}
```

:::warning[Escalou muito rápido]

Pessoal a dificuldade escalou muito rápido. Vou adicionar primeiro um material para estudarmos melhor o conceito de 

:::
