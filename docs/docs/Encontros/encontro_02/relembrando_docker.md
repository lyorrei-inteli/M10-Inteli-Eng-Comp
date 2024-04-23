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
5. O Docker Daemon enviou a saída para o Docker Client, que a enviou para o terminal.

Esse foi o processo de execução de um container no Docker. Vamos continuar com a execução de containers no Docker.

:::

Um detalhe importante é que um container apenas é executado enquanto o processo que ele está executando estiver em execução. Quando o processo termina, o container é encerrado. Para executar um container em modo interativo, é necessário utilizar o comando `docker run -it ubuntu bash`. Vamos executar este comando no terminal.

```sh
docker run -it ubuntu bash
```

O que vai acontecer agora é que a imagem do Ubuntu será baixada e um container será criado. O terminal será alterado para o terminal do container. Vamos executar o comando `ls` para listar os arquivos do container.

```sh
ls
```

Repare que os arquivos listados são os arquivos do container. Vamos executar o comando `exit` para sair do container.

```sh
exit
```

Agora o container foi encerrado e o terminal voltou ao terminal do host. Porque isso aconteceu? Porque o processo que estava sendo executado no container foi encerrado. E qual era o processo? O processo era o terminal bash. Quando o terminal bash foi encerrado, o container foi encerrado.

:::tip[O que aconteceu aqui?]

> Mas Murilo, calma ai! Como vou saber quais containers estão em execução?

<img src="https://pa1.aminoapps.com/6925/606ef81cfe6a33308600d6a7444a8527a78dca27r1-288-216_00.gif" style={{ display: 'block', marginLeft: 'auto', maxHeight: '40vh', marginRight: 'auto', marginBottom: '24px' }}/>

Vamos verificar isso! Para verificar os containers em execução, é necessário executar o comando `docker container ps`. Vamos executar este comando no terminal.

```sh
docker container ps
```

Vamos obter a seguinte resposta:

```sh
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
```

Repare que temos os cabeçalhos das informações dos containers. Neste caso, não temos nenhum container em execução. Vamos executar o comando `docker container ps -a` para verificar todos os containers que foram executados.

```sh
docker container ps -a
```

Agora vamos obter a seguinte resposta:

```sh
CONTAINER ID   IMAGE         COMMAND    CREATED          STATUS                          PORTS     NAMES
95def145d17a   ubuntu        "bash"     2 minutes ago    Exited (0) About a minute ago             boring_hugle
20f0398d420f   hello-world   "/hello"   23 minutes ago   Exited (0) 23 minutes ago                 trusting_taussig
```

Agora pessoal, vamos ver algumas coisas importantes aqui. O comando `docker container ps -a` nos mostra todos os containers que foram executados. Repare que temos o `CONTAINER ID`, `IMAGE`, `COMMAND`, `CREATED`, `STATUS`, `PORTS` e `NAMES`. O `CONTAINER ID` é um identificador único para o container. O `IMAGE` é a imagem que foi utilizada para criar o container. O `COMMAND` é o comando que foi executado no container. O `CREATED` é o tempo que o container foi criado. O `STATUS` é o status atual do container. O `PORTS` são as portas que estão sendo utilizadas pelo container. O `NAMES` é o nome do container. Quando nenhum nome é atribuído ao container, o Docker atribui um nome aleatório.

Vamos continuar estudando!

:::

Agora vamos utilizar algumas opções do comando `docker run`. Vamos executar o comando `docker run -d -p 8080:80 nginx` para executar um container do Nginx em modo `detached` e mapear a porta `8080` do host para a porta `80` do container.

```sh
docker run -d -p 8080:80 nginx
```

Agora o que vai acontecer? Vamos conseguir acessar o Nginx no navegador? Vamos verificar isso! Vamos acessar o endereço `http://localhost:8080` no navegador.

<img src={useBaseUrl("/img/docker-base/tela-saida-nginx.png")} alt="Utilizando baseUrl" style={{ display: 'block', marginLeft: 'auto', maxHeight: '40vh', marginRight: 'auto', marginBottom:'24px' }} />

Podemos conseguir acessar o Nginx no navegador. O que aconteceu aqui? O comando `docker run -d -p 8080:80 nginx` foi executado no terminal. O Docker Daemon procurou a imagem do Nginx e não encontrou. Ele baixou a imagem do Nginx do Docker Hub. O Docker Daemon criou um novo container a partir da imagem baixada e mapeou a porta `8080` do host para a porta `80` do container. O Nginx foi executado no container e o Nginx foi acessado no navegador.

:::tip[Onde será que estão essas imagens?]

<img src="https://pa1.aminoapps.com/6207/8a22f6d4b44447096b45b89b5416deb4780e9317_hq.gif" style={{ display: 'block', marginLeft: 'auto', maxHeight: '40vh', marginRight: 'auto', marginBottom: '24px' }}/>

Temos uma pergunta importante a ser respondida. Onde estão as imagens que foram baixadas? As imagens que foram baixadas estão armazenadas no Docker Host. 

> Mas Murilo, como vou saber quais imagens estão armazenadas no Docker Host?

Você pode verificar as imagens que estão armazenadas no Docker Host utilizando o comando `docker image ls`. Vamos executar este comando no terminal. Vamos obter a seguinte saída:

```sh
REPOSITORY    TAG       IMAGE ID       CREATED         SIZE
nginx         latest    2ac752d7aeb1   7 days ago      188MB
ubuntu        latest    7af9ba4f0a47   12 days ago     77.9MB
hello-world   latest    d2c94e258dcb   11 months ago   13.3kB
```

> Mas Murilo, onde é o Docker Host?

O Docker Host é o sistema operacional onde o Docker está sendo executado. No nosso caso, o Docker Host é o sistema operacional Ubuntu.
Outro ponto bastante importante, pode ser que você queira remover uma imagem que não está sendo utilizada. Para remover uma imagem, é necessário executar o comando `docker image rm <IMAGE_ID>`. Vamos remover a imagem do Nginx. Para isso, vamos executar o comando `docker image rm 2ac752d7aeb1`.

Ao tentar executar esse comando, você vai obter a seguinte resposta:

```sh
Error response from daemon: conflict: unable to delete 2ac752d7aeb1 (cannot be forced) - image is being used by running container e9e805427010
```

Por que isso aconteceu? Isso aconteceu porque a imagem do Nginx está sendo utilizada por um container. Para remover a imagem, é necessário remover o container que está utilizando a imagem. Vamos remover o container que está utilizando a imagem do Nginx. Quando as imagens não estão sendo utilizadas, podemos remover as imagens sem problemas. Basta baixar elas novamente quando for necessário.

:::

Agora vamos parar a execução do container do Nginx. Para parar a execução de um container, é necessário executar o comando `docker container stop <CONTAINER_ID>`. Vamos parar a execução do container do Nginx. 

```sh
docker container ls
docker container stop <ID_DO_CONTAINER_NGINX>
```

Agora vamos executar um container de Nginx, fornecendo uma página HTML para ele. Vamos fazer isso de algumas formas diferentes. Vamos criar um arquivo chamado `index.html` com o seguinte conteúdo:

```html
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Teste de Página HTML</title>
</head>
<body>
    <h1>Teste de Página HTML</h1>
    <p>Esta é uma página HTML de teste.</p>
</body>
</html>
```

Vamos executar o comando `docker run -d -p 8080:80 -v $(pwd)/index.html:/usr/share/nginx/html/index.html nginx` para executar um container do Nginx em modo `detached`, mapear a porta `8080` do host para a porta `80` do container e fornecer a página HTML para o Nginx.

```sh
docker run -d -p 8080:80 -v $(pwd)/index.html:/usr/share/nginx/html/index.html nginx
```

Observe que quando acessamos o endereço `http://localhost:8080` no navegador, a página HTML que fornecemos é exibida.

<img src={useBaseUrl("/img/docker-base/server-personalizado-01.png")} alt="Utilizando baseUrl" style={{ display: 'block', marginLeft: 'auto', maxHeight: '40vh', marginRight: 'auto', marginBottom:'24px' }} />

Vamos fazer uma modificação no código HTML e vamos recarregar a página no navegador.

```html
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Teste de Página HTML</title>
</head>
<body>
    <h1>Teste de Página HTML</h1>
    <p>Esta é uma página HTML de teste.</p>
    <img src="https://www.icegif.com/wp-content/uploads/2021/11/icegif-110.gif" />
</body>
</html>
```

Agora, vamos apenas recarregar a página no navegador. O que aconteceu?

<img src={useBaseUrl("/img/docker-base/server-personalizado-02.png")} alt="Utilizando baseUrl" style={{ display: 'block', marginLeft: 'auto', maxHeight: '40vh', marginRight: 'auto', marginBottom:'24px' }} />

Repare que a aplicação não parou de ser executada. O que aconteceu foi que o Nginx recarregou a página HTML que fornecemos. Isso é uma das vantagens de utilizar containers. Mas como isso aconteceu? Nós ligamos um volume do host para o container. O volume é um diretório ou arquivo que é montado no container. Quando o arquivo é modificado no host, o arquivo é modificado no container. Isso é uma das vantagens de utilizar volumes.

:::tip[O que é um volume?]

<img src="https://orig00.deviantart.net/5462/f/2016/314/1/4/porygon_flip_by_cortoony-danyc80.gif" style={{ display: 'block', marginLeft: 'auto', maxHeight: '40vh', marginRight: 'auto', marginBottom: '24px' }}/>

Os volumes são uma forma de persistir dados em containers. Eles são diretórios ou arquivos que são montados no container. Quando um volume é montado no container, o diretório ou arquivo é acessível no container. 

Os volumes são utilizados para persistir dados em containers. Eles são utilizados para armazenar dados que precisam ser persistidos, como arquivos de configuração, arquivos de log, arquivos de banco de dados, entre outros. 

Os volumes são utilizados para armazenar dados que precisam ser compartilhados entre containers. Os volumes são utilizados para armazenar dados que precisam ser acessados por múltiplos containers. Os volumes são utilizados para armazenar dados que precisam ser acessados por containers que estão sendo executados em diferentes hosts.

:::

> Mas Murilo, e quando eu preciso publicar uma imagem em produção?

Em geral, mantemos os volumes de dados separados dos containers. Isso é feito para garantir que os dados sejam mantidos mesmo que o container seja removido. Para publicar uma imagem em produção, é necessário criar um Dockerfile. O Dockerfile é um arquivo que contém as instruções para criar uma imagem. O Dockerfile contém as instruções para instalar as dependências, copiar os arquivos, configurar o ambiente, entre outras coisas. O Dockerfile é utilizado para criar uma imagem que pode ser executada em produção.

Vamos criar um Dockerfile para publicar a página HTML em produção. Vamos criar um arquivo chamado `Dockerfile` com o seguinte conteúdo:

```Dockerfile
FROM nginx:latest

COPY index.html /usr/share/nginx/html/index.html
```

Agora vamos construir uma imagem a partir do Dockerfile. Para construir uma imagem a partir de um Dockerfile, é necessário executar o comando `docker build -t <NOME_DA_IMAGEM> .`. Vamos construir uma imagem a partir do Dockerfile.

```sh
docker build -t meu-nginx .
```

Agora vamos executar um container a partir da imagem que construímos. Vamos executar o comando `docker run -d -p 8080:80 meu-nginx` para executar um container a partir da imagem que construímos.

```sh
docker run -d -p 8080:80 meu-nginx
```

Agora vamos acessar o endereço `http://localhost:8080` no navegador. A página HTML que fornecemos é exibida. A imagem que construímos pode ser utilizada em produção. Quando alguma modificação é feita no código HTML, é necessário construir uma nova imagem e executar um novo container.

:::tip[O que é um Dockerfile?]

<img src="https://64.media.tumblr.com/f575f13ebd2a66e30615c7c4115bc21c/tumblr_oboyc1iMXf1v6bs4yo1_500.gif" style={{ display: 'block', marginLeft: 'auto', maxHeight: '40vh', marginRight: 'auto', marginBottom: '24px' }}/>

Um arquivo Dockerfile é um arquivo de texto que contém as instruções para construir uma imagem. O Dockerfile é utilizado para criar uma imagem que pode ser executada em produção. O Dockerfile contém as instruções para instalar as dependências, copiar os arquivos, configurar o ambiente, entre outras coisas.

Construímos os nossos containers a partir de imagens. As imagens são arquivos que contêm o sistema operacional, as bibliotecas, os binários e os arquivos necessários para executar uma aplicação. As imagens são criadas a partir de um Dockerfile. O Dockerfile é um arquivo de texto que contém as instruções para construir uma imagem.

Nossas imagens são construídas a partir dos Dockerfiles.

Mais informações podem ser encontradas na [documentação oficial do Docker](https://docs.docker.com/engine/reference/builder/). E também na documentação do [Dockerfile](https://docs.docker.com/reference/dockerfile/).

:::

Legal até aqui avançamos bastante no desenvolvimento utilizando Docker. Vamos continuar estudando mais sobre Docker e containers.

---

## Docker Compose

Em diversas aplicações que vamos desenvolver, vai ser necessário utilizar mais de um container. Para facilitar a execução de múltiplos containers, o Docker Compose é uma ferramenta que permite definir e executar aplicações multi-container. 

O Docker Compose é utilizado para definir os serviços, as redes e os volumes que compõem a aplicação. O Docker Compose é utilizado para executar os containers da aplicação.

Vamos lançar um serviço que utiliza o Postgres e o Adminer. Para isso, vamos criar um arquivo chamado `docker-compose.yml` com o seguinte conteúdo:

```yml
# Use postgres/example user/password credentials
version: '3.9'

services:

  db:
    image: postgres
    restart: always
    # set shared memory limit when using docker-compose
    shm_size: 128mb
    # or set shared memory limit when deploy via swarm stack
    #volumes:
    #  - type: tmpfs
    #    target: /dev/shm
    #    tmpfs:
    #      size: 134217728 # 128*2^20 bytes = 128Mb
    environment:
      POSTGRES_PASSWORD: example

  adminer:
    image: adminer
    restart: always
    ports:
      - 8080:8080
```

Para executar os containers, é necessário executar o comando `docker-compose up -d`. Vamos executar este comando no terminal.

```sh
docker-compose up -d
```

Agora vamos acessar o endereço `http://localhost:8080` no navegador. O Adminer é exibido. O Adminer é um cliente de banco de dados que permite gerenciar os bancos de dados.

:::tip[O que é está acontecendo aqui?]

:::
