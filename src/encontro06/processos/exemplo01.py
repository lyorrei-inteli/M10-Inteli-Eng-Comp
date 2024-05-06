# Exemplo de uso de processos em Python

import os
import time
import multiprocessing

# Função que será executada em um processo
def funcao_processo():
    print(f'Processo {os.getpid()} iniciado')
    time.sleep(2)
    print(f'Processo {os.getpid()} finalizado')


if __name__ == '__main__':
    print(f'Processo principal {os.getpid()} inicializado')

    # Criação de um processo
    processo = multiprocessing.Process(target=funcao_processo)
    processo.start()

    print(f'Processo principal {os.getpid()} finalizado')

    # Aguarda o término do processo
    processo.join()



