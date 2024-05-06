---
sidebar_position: 2
title: Threads
---

import useBaseUrl from '@docusaurus/useBaseUrl';
import Tabs from '@theme/Tabs';
import TabItem from '@theme/TabItem';

## Threads

Threads são a menor unidade de processamento que um sistema operacional pode agendar. Um processo pode ter vários threads, cada um com seu próprio contador de programa, registradores e pilha, mas compartilhando o mesmo espaço de endereço. Threads são úteis para melhorar a performance de aplicações, pois permitem que um processo execute várias tarefas simultaneamente.

<img src="https://media4.giphy.com/media/UiH6lsIgUhZU7uNKFR/200w.gif?cid=6c09b9526b7d15ezf4qco8bbm7a7i6b5v2rfgalkmikoexm1&ep=v1_gifs_search&rid=200w.gif&ct=g" style={{ display: 'block', marginLeft: 'auto', maxHeight: '40vh', marginRight: 'auto', marginBottom: '24px' }}/>

> Murilo, mas o que é um thread?

Um thread é um fluxo de execução dentro de um processo. Cada thread tem seu próprio contador de programa, registradores e pilha, mas compartilha o mesmo espaço de endereço com outros threads do mesmo processo. Isso significa que os threads podem acessar as mesmas variáveis e recursos do processo, mas têm seu próprio estado de execução.

<img src="https://av-eks-lekhak.s3.amazonaws.com/media/__sized__/article_images/thread2_H7Y4wjm-thumbnail_webp-600x300.webp" style={{ display: 'block', marginLeft: 'auto', maxHeight: '40vh', marginRight: 'auto', marginBottom: '24px' }}/>


### Vantagens de usar Threads

