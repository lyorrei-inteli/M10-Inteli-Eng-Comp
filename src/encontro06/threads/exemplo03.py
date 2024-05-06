# Exemplo de uso de threads em Python para realizar download de arquivos

import threading
import requests

def download_arquivo(url):
    print('Baixando arquivo: ', url)
    # Realiza o download do arquivo utilizando o pacote requests
    response = requests.get(url)
    # Salva o arquivo
    with open(url.split('/')[-1], 'wb') as f:
        f.write(response.content)
    print('Download finalizado: ', url)

# Cria um conjunto de imagens para fazer o download
imagens = [
    'https://www.pokemon.com/static-assets/content-assets/cms2/img/pokedex/detail/025.png',
    'https://www.pokemon.com/static-assets/content-assets/cms2/img/pokedex/detail/001.png',
    'https://www.pokemon.com/static-assets/content-assets/cms2/img/pokedex/detail/004.png',
    'https://www.pokemon.com/static-assets/content-assets/cms2/img/pokedex/detail/009.png',
    'https://www.pokemon.com/static-assets/content-assets/cms2/img/pokedex/detail/150.png',
]

# Cria uma thread para cada imagem
threads = []

for imagem in imagens:
    t = threading.Thread(target=download_arquivo, args=(imagem,))
    t.start()
    threads.append(t)

# Espera todas as threads terminarem
for t in threads:
    t.join()

print('Download de todas as imagens finalizado')