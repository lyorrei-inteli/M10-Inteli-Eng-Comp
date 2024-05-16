---
sidebar_position: 7
title: Atividade Ponderada
---

import useBaseUrl from '@docusaurus/useBaseUrl';
import Tabs from '@theme/Tabs';
import TabItem from '@theme/TabItem';

## Atividade Ponderada - Construção de Aplicativo Híbrido com Flutter

Atividade Ponderada que consiste em construir uma aplicação Flutter. Essa aplicação deve ser realizada em sala de aula seguindo as orientações da Instrução. A entrega da atividade deve acontecer pelo Github. A aplicação deve ser desenvolvida utilizando o backend fornecido em sala de aula. O protocolo para comunicação com o backend também será disponibilizado durante a instrução.

O backend para está atividade deve, OBRIGATORIAMENTE, ser desenvolvido em Microsserviços. A aplicação deve ser desenvolvida utilizando o Flutter. Minha sugestão é que o backend seja desenvolvido em Python.

A aplicação deve estar conteinerizada e deve ser entregue com o Dockerfile e o docker-compose.yml. O repositório da aplicação deve ser entregue com o README.md contendo as instruções para execução da aplicação.

### Barema de Correção

Como barema de correção da atividade, serão considerados os seguintes aspectos:



---

- Checkpoint: Domingo (19/05/2024 - 23h59)
  - Aplicativo Flutter com tela de login (sem autenticação de rotas, necessáriamente), cadastro de usuário e tela para captura de imagens.
  - Backend em Microsserviços que realiza o cadastro de usuários e faz o log das ações que o usuário realiza no aplicativo (por hora só login e criação de conta).

- Entrega: Domingo (26/05/2024 - 23h59)
  - Aplicativo Flutter enviando as imagens para o processamento;
  - Backend em Microsserviços que recebe as imagens e as processa, retornando o resultado para o aplicativo;
  - Backend em Microsserviços que realiza o log das ações que o usuário realiza no aplicativo (por hora só login, criação de conta e envio de imagens);
  - Serviço de notificação que envia uma notificação para o usuário quando o processamento da imagem termina.