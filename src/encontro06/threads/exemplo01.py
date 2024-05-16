# Hello World em Python com Threads

import threading
import time

# Cria o comportamento de uma thread
def hello():
    print("Hello World!")
    time.sleep(3)

# Realiza a criação de uma thread
t = threading.Thread(target=hello)

# Inicia a thread
t.start()

# Espera a thread terminar
t.join()

print("Fim do programa")
