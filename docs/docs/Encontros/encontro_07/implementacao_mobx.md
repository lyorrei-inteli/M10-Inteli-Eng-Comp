---
sidebar_position: 5
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

