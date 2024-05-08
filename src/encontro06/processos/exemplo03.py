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


# Função que aguarda existir mensagens em uma fila
def aguardar_mensagens(queue):
    print(f'Processo {os.getpid()} iniciado')
    mensagem = queue.get()
    print(f'Mensagem lida: {mensagem}')
    print(f'Processo {os.getpid()} finalizado')

if __name__ == '__main__':
    print(f'Processo principal {os.getpid()} inicializado')

    # Criação de uma fila
    queue = multiprocessing.Queue()

    # Criação de um processo
    processo = multiprocessing.Process(target=funcao_processo, args=(queue,))
    processo.start()

    # Criação de um segundo processo
    processo2 = multiprocessing.Process(target=aguardar_mensagens, args=(queue,))
    processo2.start()

    print(f'Processo principal {os.getpid()} finalizado')

    # Aguarda o término dos processos
    processo.join()
    processo2.join()