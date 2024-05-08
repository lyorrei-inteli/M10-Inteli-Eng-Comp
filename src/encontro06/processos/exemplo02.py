# Exemplo de compartilhamento de recursos entre processos em Python

import os
import time
import multiprocessing

# Função que será executada em um processo
def funcao_processo(queue):
    print(f'Processo {os.getpid()} iniciado')
    time.sleep(2)
    queue.put(f'Mensagem do processo {os.getpid()}')
    print(f'Processo {os.getpid()} finalizado')


if __name__ == '__main__':
    print(f'Processo principal {os.getpid()} inicializado')

    # Criação de uma fila para compartilhar recursos
    queue = multiprocessing.Queue()

    # Criação de um processo
    processo = multiprocessing.Process(target=funcao_processo, args=(queue,))
    processo.start()

    # Aguarda o término do processo
    processo.join()

    # Lê a mensagem da fila
    mensagem = queue.get()
    print(f'Mensagem lida: {mensagem}')

    print(f'Processo principal {os.getpid()} finalizado')