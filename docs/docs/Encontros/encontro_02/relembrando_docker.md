---
sidebar_position: 2
title: Relembrando a Ferramenta Docker e sua utilização
---

import useBaseUrl from '@docusaurus/useBaseUrl';
import Tabs from '@theme/Tabs';
import TabItem from '@theme/TabItem';

## Relembrando a Ferramenta Docker e sua utilização

Vamos relembrar alguns pontos importantes para utilização do Docker e aplicações conteinerizadas.

## Um pouco de contexto

Problemas comuns no desenvolvimento de soluções de software:
- Diferentes setup's de hardware e software;
- Diferentes conjuntos de requisitos para rodar uma aplicação;
- Demanda por isolamento entre aplicações;
- Necessidade de escala de partes da solução.

Quais são as possíveis soluções que temos para esse problema? Podemos utilizar máquinas virtuais!
Máquinas Virtuais (VMs) são ambientes computacionais simulados que funcionam como sistemas de computador completos, incluindo CPU, memória, disco e outros recursos. Elas são criadas e executadas em um servidor físico, permitindo que um único hardware execute vários sistemas operacionais e aplicativos independentes.

A virtualização é alcançada através de um software chamado hipervisor ou monitor de máquina virtual, que gerencia e aloca recursos entre as VMs. VMs oferecem isolamento, permitindo a execução segura de aplicativos e sistemas operacionais diferentes em uma mesma máquina física. São úteis para testes, desenvolvimento, consolidação de servidores, backup, recuperação de desastres e fornecimento rápido de ambientes replicáveis. Exemplos de tecnologias de virtualização incluem VMware, Microsoft Hyper-V, KVM (Kernel-based Virtual Machine) e VirtualBox.

<img src="https://cdn.ttgtmedia.com/rms/onlineimages/virtual_machines-h_half_column_mobile.png" style={{ display: 'block', marginLeft: 'auto', maxHeight: '40vh', marginRight: 'auto', marginBottom: '24px' }}/>

A imagem acima apresenta o processo de utilização das máquinas virtuais. Um servidor físico possui um hardware e um sistema operacional próprio. Estes elementos possuem uma característica de ser chamados de `elementos de host`. Neste servidor, é instalado um software chamado de `hypervisor`, ele que vai permitir executar os sistemas convidados neste sistema nativo. Cada máquina virtual será criada como uma instância que deve possuir `Guest OS` e as aplicações que estão sendo executadas dentro dela.

<img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRNScWo5JpS77L3GWqtDobfEHru5DpjBcsDkuSqcjCxIg&s" style={{ display: 'block', marginLeft: 'auto', maxHeight: '40vh', marginRight: 'auto', marginBottom: '24px' }}/>

Mas onde entram os containers nessa conversa?

Containers são como cestas de piquinique, tudo que precisamos para comer uma refeição está dentro dela, assim como tudo que precisamos para executar uma aplicação já está dentro dele. Para executar containers, é necessário um Container Engine sendo executado no sistema operacional host.

<img src="https://masterfromus.files.wordpress.com/2020/02/image-4.png?w=921" style={{ display: 'block', marginLeft: 'auto', maxHeight: '40vh', marginRight: 'auto', marginBottom: '24px' }}/>

A partir de agora vamos iniciar a utilização do Docker.

## Utilizando Docker

Vamos executar um container de `hello-world` no docker. No terminal, executar o comando:

```sh
docker run hello-world
```

Vamos obter a seguinte resposta:

```sh
Unable to find image 'hello-world:latest' locally
latest: Pulling from library/hello-world
719385e32844: Pull complete 
Digest: sha256:926fac19d22aa2d60f1a276b66a20eb765fbeea2db5dbdaafeb456ad8ce81598
Status: Downloaded newer image for hello-world:latest

Hello from Docker!
This message shows that your installation appears to be working correctly.

To generate this message, Docker took the following steps:
 1. The Docker client contacted the Docker daemon.
 2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
    (amd64)
 3. The Docker daemon created a new container from that image which runs the
    executable that produces the output you are currently reading.
 4. The Docker daemon streamed that output to the Docker client, which sent it
    to your terminal.

To try something more ambitious, you can run an Ubuntu container with:
 $ docker run -it ubuntu bash

Share images, automate workflows, and more with a free Docker ID:
 https://hub.docker.com/

For more examples and ideas, visit:
 https://docs.docker.com/get-started/
```

:::tip[O que aconteceu aqui?]

> Mas Murilo o que aconteceu aqui mesmo?

<img src="https://pa1.aminoapps.com/6925/606ef81cfe6a33308600d6a7444a8527a78dca27r1-288-216_00.gif" style={{ display: 'block', marginLeft: 'auto', maxHeight: '40vh', marginRight: 'auto', marginBottom: '24px' }}/>

Vamos avaliar o que aconteceu aqui:

1. O comando `docker run hello-world` foi executado no terminal;
2. O Docker Client entrou em contato com o Docker Daemon;
3. O Docker Daemon procurou a imagem do `hello-world` e não encontrou. Ele baixou a imagem `hello-world` do Docker Hub;
4. O Docker Daemon criou um novo container a partir da imagem baixada e executou o comando que produziu a saída que estamos lendo;


:::

