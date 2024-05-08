---
sidebar_position: 5
title: Implementando Arquitetura
---

import useBaseUrl from '@docusaurus/useBaseUrl';
import Tabs from '@theme/Tabs';
import TabItem from '@theme/TabItem';

## Implementando Arquitetura de Microsserviços

Pessoas lindas do meu coração, aqui vamos gastar a ponta dos nossos dedos (ok exagerei mas foi para deixar tudo mais dramático) !!

Vamos implementar algumas arquiteturas de microsserviços, conforme os conceitos que discultimos anteriormente.

Nossa primeira arquitetura já está vindo!

:::warning[AGORA MUUUUITO SÉRIO, PRATIQUEM!]

Pessoal eu vou tentar ao máximo descrever todos os passos para realizarmos a implementação de diversas arquiteturas e serviços e padrões com vocês. Mas, eu apenas estou garantindo para vocês, se vocês não praticarem, não vai adiantar de nada.

<img src="https://external-preview.redd.it/eKcRAzHsHicyHykAqSJCpju139qFIRiPJt4v25TtMXA.jpg?auto=webp&s=6e59d055d1153e423a6c1735ebaa2d7c38a9c58b" style={{ display: 'block', marginLeft: 'auto', maxHeight: '65vh', marginRight: 'auto', marginBottom: '24px' }}/>


:::

---

### Arquitetura 01 - Comunicação Assíncrona com RabbitMQ

Pessoal, para iniciarmos nosso estudo, vamos implementar um sistema como descrito na imagem abaixo:

<img src={useBaseUrl("/img/microsservicos/arquitetura_01.png")} style={{ display: 'block', marginLeft: 'auto', maxHeight: '65vh', marginRight: 'auto', marginBottom: '24px' }}/>

O que está acontecendo aqui:

- Temos um `gateway`, implementado com o ***Nginx***, que recebe as requisições HTTP externa e as encaminha para o serviço adequado.
- Temos o nosso `Service01`, que é responsável por receber as requisições do `gateway` e encaminhar para o `RabbitMQ`. Ele recebe requisições do tipo `POST` e envia para o `RabbitMQ` a data e hora que a requisição ocorreu. Ele disponibiliza um endpoint `/ping` que recebe as requisições.
- Temos o nosso `Service02`, que é responsável por receber as mensagens do `RabbitMQ` e armazenar em um banco de dados em memória (isso mesmo é só uma lista de objetos em memória). Ele disponibiliza um endpoint `/pong` que recebe as requisições do tipo `GET` para retornar a lista de mensagens armazenadas.
- Por fim, temos nosso broker de mensagens, o `RabbitMQ`, que é responsável por receber as mensagens do `Service01` e encaminhar para o `Service02`.

#### Verificando os requisitos

Legal, agora que falamos como nossa arquitetura funciona, vamos verificar os requisitos para implementar ela:

- [ ] Ter o ***Nginx*** instalado e configurado para encaminhar as requisições para o `Service01` e para o `Service02`.
- [ ] Ter o ***RabbitMQ*** instalado e configurado para receber as mensagens do `Service01` e encaminhar para o `Service02`.
- [ ] Ter o `Service01` implementado para receber as requisições do `gateway` e encaminhar para o `RabbitMQ`.
- [ ] Ter o `Service02` implementado para receber as mensagens do `RabbitMQ` e armazenar em um banco de dados em memória.

Assim que tivermos todo o nosso ***checklist*** preenchido, vamos ter nosso sistema funcionando 🐨🐳!!

Pensado de forma pedagógica, seria mais interessante colocarmos esses passos em ordem. Masssss, vamos utilizar a premissa de que o time deve escolher o que vai priorizar para implementar primeiro! Logo, vamos criar um diretório para que os arquivos de nossa solução possam ser organizados.

A minha sugestão de diretórios seria:

```bash
microsservicos/
├── Service01/
│   ├── app.py
│   ├── Dockerfile
│   ├── requirements.txt
├── Service02/
│   ├── app.py
│   ├── Dockerfile
│   ├── requirements.txt
├── nginx/
│   ├── nginx.conf
├── rabbitmq/
├── docker-compose.yml
```

:::tip[Calma, calma, calma!]

Não precisamos já criar toda nossa estrutura de arquivos. Vamos implementando conforme vamos avançando. Mas, é sempre bom ter uma ideia de como vamos organizar nossos arquivos.

:::

#### Adicionando o Service01 e o docker-compose

Vamos iniciar implementando o nosso `Service01`, o `RabbitMQ` e o docker-compose que vai ligar esses dois. Como só temos parte da nossa estrutura, vamos ver como ficou nossa estrutura de pastas:

```bash
microsservicos/
├── Service01/
│   ├── app.py
│   ├── Dockerfile
│   ├── requirements.txt
├── rabbitmq/
│   ├── .gitkeep
├── docker-compose.yml
├── .env
```

> Calma lá Murilo, tem arquivos novos ai pô!

Sim, sim, sim! Vamos criar um arquivo `.env` dentro da pasta `Service01` para armazenar as variáveis de ambiente que vamos utilizar em nosso serviço. Por que vamos fazer isso? Você pode se perguntar. Com as nossas variáveis de ambiente armazenadas em um arquivo `.env`, podemos utilizar o `docker-compose` para passar essas variáveis para o nosso container. Assim, não precisamos ficar alterando o código toda vez que precisamos mudar uma variável de ambiente.

Vamos escrever primeiro nosso serviço `Service01`. Ele é uma aplicação que utilizar o Flask e o Uvicorn como dependências. Vamos criar o arquivo `app.py` dentro da pasta `Service01` com o seguinte conteúdo:

```python
# Service01/app.py

from fastapi import FastAPI
from pydantic import BaseModel
from datetime import datetime
app = FastAPI()

class Message(BaseModel):
    date: datetime = None
    msg: str

messages = []

@app.post("/ping")
async def ping(msg: Message):
    msg.date=datetime.now()
    return {"message": f"Created at {msg.date}", "content": f"{msg.msg}"}

# Executa a aplicação com a informação de HOST e PORTA enviados por argumentos
if __name__ == "__main__":
    import uvicorn
    import os
    print(os.environ)
    if "SERVICE_01_HOST" in os.environ and "SERVICE_01_PORT" in os.environ:
        uvicorn.run(app, host=os.environ["SERVICE_01_HOST"], port=os.environ["SERVICE_01_PORT"])
    else:
        raise Exception("HOST and PORT must be defined in environment variables")

```

Agora, vamos criar o arquivo `Dockerfile` dentro da pasta `Service01` com o seguinte conteúdo:

```Dockerfile
# Service01/Dockerfile

FROM python:3.8-slim

WORKDIR /app

COPY requirements.txt requirements.txt

RUN pip install -r requirements.txt

COPY . .

CMD ["python", "app.py"]
```

Por fim, vamos criar o arquivo `requirements.txt` dentro da pasta `Service01` com o seguinte conteúdo:

```txt
fastapi==0.68.1
uvicorn==0.15.0
```

Agora, vamos criar o arquivo `docker-compose.yml` na raiz do nosso projeto. Aqui teremos algumas diferenças, dentre elas, a utilização dos dados presentes no arquivo `.env` para passar as variáveis de ambiente para o nosso container. Vamos criar o arquivo `docker-compose.yml` com o seguinte conteúdo:

```yaml
# docker-compose.yml

version: '3.8'

services:
  service01:
    build:
      context: ./Service01
    ports:
      - "${SERVICE01_HOST_PORT}:${SERVICE_01_PORT}"
    environment:
      - SERVICE_01_HOST=${SERVICE_01_HOST}
      - SERVICE_01_PORT=${SERVICE_01_PORT}

```

Por fim, vamos criar o arquivo `.env` dentro da pasta `Service01` com o seguinte conteúdo:

```env
SERVICE_01_HOST=0.0.0.0
SERVICE_01_PORT=8001
SERVICE01_HOST_PORT=8000
```

> Murilo, eita nóis, tem muita coisa nova ai!

<img src="https://pbs.twimg.com/media/Ei8Gep-XYAADnPO.jpg" style={{ display: 'block', marginLeft: 'auto', maxHeight: '65vh', marginRight: 'auto', marginBottom: '24px' }}/>

Calma, calma, calma! Vamos entender o que fizemos:

- Arquivo `app.py`:
    - Criamos uma aplicação `FastAPI` que possui um endpoint `/ping` que recebe uma mensagem e retorna a data e hora que a mensagem foi recebida.
    - Utilizamos o `pydantic` para definir o modelo da mensagem que será recebida. Assim, podemos definir qual o formato da mensagem que será recebida. Se o JSON enviado não estiver no formato esperado, o `FastAPI` retorna um erro.
    - Para receber as variáveis de ambiente `SERVICE_01_HOST` e `SERVICE_01_PORT`, utilizamos a biblioteca `os`. Com o `os.environ`, conseguimos acessar as variáveis de ambiente do sistema operacional. No nosso caso, as variáveis de ambiente são passadas pelo `docker-compose` e ficam acessíveis para a aplicação.
    - Utilizamos o `uvicorn` para executar a aplicação. O `uvicorn` é um servidor ASGI que permite executar aplicações `FastAPI`.

- Arquivo `Dockerfile`:
    - Utilizamos a imagem `python:3.8-slim` como base para a nossa aplicação. Essa imagem já possui o Python 3.8 instalado e é uma versão mais leve da imagem `python:3.8`.
    - Definimos o diretório de trabalho como `/app`.
    - Copiamos o arquivo `requirements.txt` para o diretório `/app`.
    - Instalamos as dependências do arquivo `requirements.txt` com o comando `pip install -r requirements.txt`.
    - Copiamos todos os arquivos do diretório atual para o diretório `/app`.
    - Definimos o comando que será executado quando o container for iniciado. Neste caso, executamos o arquivo `app.py`.

- Arquivo `.env`:
    - Definimos as variáveis de ambiente `SERVICE_01_HOST`, `SERVICE_01_PORT` e `SERVICE01_HOST_PORT`. Essas variáveis de ambiente são utilizadas para definir o host, a porta e a porta de exposição do serviço `Service01`.

- Arquivo `docker-compose.yml`:
    - Definimos a versão do `docker-compose` como `3.8`.
    - Criamos um serviço chamado `service01` que utiliza o `Dockerfile` presente no diretório `Service01` para construir a imagem do serviço.
    - Mapeamos a porta `${SERVICE01_HOST_PORT}` do host para a porta `${SERVICE_01_PORT}` do container. Assim, podemos acessar o serviço `Service01` na porta definida em `SERVICE01_HOST_PORT`.
    - Passamos as variáveis de ambiente `SERVICE_01_HOST` e `SERVICE_01_PORT` para o container. Essas variáveis de ambiente são definidas no arquivo `.env` e são utilizadas pela aplicação `Service01`.

Pessoal, vocês virão a beleza desse processo? Se nós alterarmos o nosso arquivo `.env`, não precisamos alterar o nosso código. Isso é muito legal, pois podemos alterar as variáveis de ambiente sem precisar alterar o código da aplicação. Isso facilita a configuração e o gerenciamento das variáveis de ambiente.

<img src="https://i.gifer.com/A5OX.gif" style={{ display: 'block', marginLeft: 'auto', maxHeight: '65vh', marginRight: 'auto', marginBottom: '24px' }}/>

:::danger[Cuidado com apenas o resultado pronto]

Pessoal eu queria muito dizer para vocês que foi super fácil, sem problemas, que passar mantega no pão foi mais dificil. Mas, ao menos para mim, não foi assim que eu implementei esses passos. Eu tive que pesquisar, errar, testar, errar, corrigir, errar, errar, erarrr, errrarrrr e até que enfim conseguir implementar a solução da maneira que eu gostaria de apresentar para vocês.

Então, não se preocupem se vocês não conseguirem implementar de primeira. O importante é tentar, errar, corrigir e tentar de novo. A prática leva a perfeição. As 32x que eu tive que remover a imagem desse Service01 que o digam.

:::

Beleza, mas agora vamos lá, ainda não devemos comemorar!! Faltam muitas coisas aqui para terminarmos nosso primeiro passo! Vamos adicionar o RabbitMQ nessa brincadeira!

#### Adicionando o RabbitMQ

Vamos utilizar a imagem oficial do RabbitMQ, disponível no [DockerHub](https://hub.docker.com/_/rabbitmq). Essa imagem vai ser adicionada no nosso arquivo `docker-compose.yml` para que o `docker-compose` possa baixar e executar o RabbitMQ. Além disso, vamos configurar dentro do nosso arquivo de `.env` uma variável para definir o nosso usuário e a senha do RabbitMQ.

Vamos adicionar as variáveis de ambiente no arquivo `.env`:

```env
# Configurações do Service01

SERVICE_01_HOST=0.0.0.0
SERVICE_01_PORT=8001
SERVICE01_HOST_PORT=8000

# Configurando o RabbitMQ

RABBITMQ_DEFAULT_USER=inteli
RABBITMQ_DEFAULT_PASS=inteli_secret
RABBITMQ_HOST=rabbitmq
RABBITMQ_PORT=5672
RABBITMQ_QUEUE=mensagens_async
```

Agora vamos adicionar o serviço do RabbitMQ no nosso arquivo `docker-compose.yml`:

```yaml
# docker-compose.yml

version: '3.8'

services:
  service01:
    build:
      context: ./Service01
    ports:
      - "${SERVICE01_HOST_PORT}:${SERVICE_01_PORT}"
    env_file:
      - .env
    depends_on:
      - rabbitmq

  rabbitmq:
    image: rabbitmq:3.12.14-management-alpine
    ports:
      - "5672:5672"
      - "15672:15672"
    environment:
      - RABBITMQ_DEFAULT_USER=${RABBITMQ_DEFAULT_USER}
      - RABBITMQ_DEFAULT_PASS=${RABBITMQ_DEFAULT_PASS}
```

Quando utilizamos a versão `management-alpine` da imagem do RabbitMQ, temos acesso a uma interface web que nos permite visualizar as filas, as trocas e os usuários do RabbitMQ. Essa interface é muito útil para debugar e monitorar o RabbitMQ. Para acessar a interface web, basta acessar o endereço [`http://localhost:15672`](http://localhost:15672/) no navegador e informar o usuário e a senha configurados no arquivo `.env`.

Pessoal reparem que adicionamos a variável `depends_on` no serviço `service01`. Essa variável indica que o serviço `service01` depende do serviço `rabbitmq`. Com isso, o `docker-compose` garante que o serviço `rabbitmq` seja iniciado antes do serviço `service01`. Isso é importante, pois o `service01` precisa do `rabbitmq` para enviar as mensagens.

Outro ponto importante, o `env_file` no serviço `service01` indica que as variáveis de ambiente do arquivo `.env` serão passadas para o container do serviço `service01`. Assim, as variáveis de ambiente definidas no arquivo `.env` ficam acessíveis para a aplicação `Service01`.

E boa!!! Temos nosso RabbitMQ funcionando, mas ainda não temos a comunicação entre o Service01 e o RabbitMQ. Vamos implementar essa comunicação agora!

#### Comunicação entre Service01 e RabbitMQ

Para enviar mensagens para o RabbitMQ, vamos utilizar a biblioteca `pika`. Essa biblioteca é uma implementação do protocolo AMQP (Advanced Message Queuing Protocol) para Python. Com o `pika`, podemos enviar e receber mensagens do RabbitMQ de forma assíncrona. Mais informações sobre a biblioteca, podemos acessar a [documentação oficial](https://pika.readthedocs.io/en/stable/).

Para isso, vamos ter que fazer algumas modificações no nosso arquivo `app.py` do `Service01`. Vamos adicionar a comunicação com o RabbitMQ para enviar as mensagens recebidas no endpoint `/ping`. Vamos modificar também o arquivo `requirements.txt` para adicionar a dependência do `pika`.

```txt
fastapi==0.68.1
uvicorn==0.15.0
pika==1.2.0
```

:::danger[Mudança na estrutura da imagem]

Pessoal, aqui chegamos em um ponto importante. Nós vamos ter que modificar a estrutura da nossa imagem do `Service01` para que ele consiga se comunicar com o RabbitMQ. Vamos adicionar a comunicação com o RabbitMQ no arquivo `app.py`. Vamos precisar informar que o docker precisa reconstruir a imagem do `Service01` para que ele possa adicionar a dependência do `pika`.

Vamos excluir nossas imagens  Excluir nossa imagem antiga e criar uma nova imagem com o comando `docker-compose up --build`.


:::

Vamos modificar o arquivo `app.py` do `Service01` para adicionar a comunicação com o RabbitMQ:

```python

# Service01/app.py

# Adicionando a funcionalidade de enviar mensagens com data e hora para o broker do RabbitMQ

from fastapi import FastAPI
from pydantic import BaseModel
from datetime import datetime
import pika

app = FastAPI()

class Message(BaseModel):
    date: datetime = None
    msg: str

# Cria uma função que faz o envio das mensagens para o RabbitMQ
def send_message_rabbitmq(msg: Message):
    # Verifica se as variáveis de ambiente estão definidas
    if "RABBITMQ_HOST" not in os.environ or "RABBITMQ_PORT" not in os.environ:
        raise Exception("RABBITMQ_HOST and RABBITMQ_PORT must be defined in environment variables")

    credentials = pika.PlainCredentials(os.environ["RABBITMQ_DEFAULT_USER"], os.environ["RABBITMQ_DEFAULT_PASS"])
    connection = pika.BlockingConnection(pika.ConnectionParameters(
        os.environ["RABBITMQ_HOST"]
        , os.environ["RABBITMQ_PORT"]
        , '/'
        , credentials))
    channel = connection.channel()
    channel.queue_declare(queue=os.environ["RABBITMQ_QUEUE"], durable=True)
    channel.basic_publish(exchange='', routing_key='messages', body=f"{msg.date} - {msg.msg}")
    connection.close()

@app.post("/ping")
async def ping(msg: Message):
    msg.date=datetime.now()
    send_message_rabbitmq(msg)
    return {"message": f"Created at {msg.date}", "content": f"{msg.msg}"}

# Executa a aplicação com a informação de HOST e PORTA enviados por argumentos
if __name__ == "__main__":
    import uvicorn
    import os
    print(os.environ)
    if "SERVICE_01_HOST" in os.environ and "SERVICE_01_PORT" in os.environ:
        uvicorn.run(app, host=os.environ["SERVICE_01_HOST"], port=os.environ["SERVICE_01_PORT"])
    else:
        raise Exception("HOST and PORT must be defined in environment variables")

```

E pronto, agora temos nosso `Service01` enviando mensagens para o RabbitMQ. Vamos testar se a comunicação está funcionando corretamente. Para isso, vamos iniciar o RabbitMQ e o Service01 com o comando `docker-compose up`. Em seguida, vamos acessar o endpoint `/ping` do Service01 para enviar uma mensagem para o RabbitMQ.

Estamos avançando!! Como está nosso estado atual:

- [ ] Ter o ***Nginx*** instalado e configurado para encaminhar as requisições para o `Service01` e para o `Service02`.
- [x] Ter o ***RabbitMQ*** instalado e configurado para receber as mensagens do `Service01` e encaminhar para o `Service02`.
- [x] Ter o `Service01` implementado para receber as requisições do `gateway` e encaminhar para o `RabbitMQ`.
- [ ] Ter o `Service02` implementado para receber as mensagens do `RabbitMQ` e armazenar em um banco de dados em memória.

Vamos agora configurar o `Service02` para receber as mensagens do RabbitMQ e armazenar em um banco de dados em memória.

#### Adicionando o Service02

