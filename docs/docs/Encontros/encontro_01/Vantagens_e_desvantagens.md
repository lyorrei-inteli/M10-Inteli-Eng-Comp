---
sidebar_position: 3
title: Maturidade de Richardson
---

# 1.Modelo de Maturidade de Richardson

O Modelo de Maturidade de Richardson é uma ferramenta útil para avaliar a conformidade de uma API com os princípios REST. Desenvolvido por Leonard Richardson, este modelo decompõe os elementos cruciais que definem uma API RESTful em quatro níveis de maturidade. Cada nível adiciona novos elementos sobre os anteriores, aumentando a aderência aos princípios REST. A ideia é que, ao seguir este modelo, desenvolvedores possam criar serviços web mais robustos, escaláveis e flexíveis.

# 2.Níveis do Modelo

## 2.1.Nível 0: POX (Plain Old XML)

O HTTP é utilizado apenas como meio de transporte. Neste nível, a API é basicamente apenas um mecanismo remoto de chamada de procedimento (RPC). Ou seja, não aproveita as características inerentes do protocolo HTTP além de simplesmente enviar e receber dados.

As mensagens são enviadas por XML ou qualquer outro formato, mas não usa recursos HTTP como HTTP verbs ou HTTP status codes. Em geral, todas as operações são realizadas geralmente via POST, sem diferenciar o tipo de ação realizada sobre o recurso.

A API neste nível geralmente expõe apenas um único URI que recebe todas as requisições, que são diferenciadas pelo corpo da requisição.

:::info[Qual a relevância?]

- `Facilidade de Implementação:` Muito fácil de implementar, especialmente para sistemas legados ou quando integrado a sistemas que não são baseados em web.

- `Principais Limitações:` Falta de escalabilidade, flexibilidade e dificuldades na manutenção, pois não utiliza a plena capacidade do HTTP.

:::

## 2.2.Nível 1: Recursos

No nível 1, o sistema começa a definir recursos com URIs dedicadas. Por exemplo, separando `/clientes` para acessos relacionados a clientes e `/pedidos` para pedidos. 

Geralmente, ainda usa POST para todas as operações, não diferenciando entre tipos de ação (criar, ler, atualizar, deletar). Por exemplo: 
- POST /clientes para criar um novo cliente; 
- POST /clientes/123 para atualizar o cliente com ID 123.

:::info[Qual a relevância?]

- `Organização Melhorada:` Facilita a organização da API e a compreensão dos tipos de entidades que a API manipula, melhorando um pouco a manutenibilidade.

- `Ainda Não É RESTful:` Não aproveita o protocolo HTTP para representar operações CRUD através de verbos como GET, PUT, e DELETE.

:::

## 2.3.Nível 2: Verbos HTTP

Este nível utiliza os verbos HTTP (GET, POST, PUT, DELETE) para definir ações sobre os recursos, alinhando melhor com os princípios REST. Em geral temos como operações padrão:
- `GET` para recuperar recursos.
- `POST` para criar novos recursos.
- `PUT` para atualizar recursos existentes.
- `DELETE` para remover recursos.

Como exemplo: 
- `GET /clientes/123` para obter informações do cliente 123;
- `DELETE /clientes/123` para deletar esse cliente.

Este nível também utiliza códigos de status HTTP para comunicar o resultado das operações ao cliente, como 200 OK, 201 Created, e 404 Not Found.


:::info[Qual a relevância?]

- `Aproveitamento do HTTP:` Utiliza o protocolo HTTP como foi destinado, o que facilita a interoperabilidade e a integração com outras interfaces web e clientes HTTP.

- `Melhor Feedback para o Cliente:` Os códigos de status informam os clientes sobre o sucesso ou falha das operações, permitindo reações apropriadas do lado do cliente.

:::

