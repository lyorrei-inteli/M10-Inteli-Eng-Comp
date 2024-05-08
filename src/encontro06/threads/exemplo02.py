# Hello World em Python com Threads

import threading
import time

# Cria o comportamento de uma thread
def hello():
    print("Hello World!")
    time.sleep(3)

# Cria um conjunto de threads
threads = []

# Realiza a criação de uma thread
for i in range(10):
    threads.append(threading.Thread(target=hello))

# Inicia as threads
for t in threads:
    t.start()

# Espera as threads terminar
for t in threads:
    t.join()

print("Fim do programa")
