import sqlite3

# Conectar ao banco de dados SQLite, ou criar se não existir
conn = sqlite3.connect('usuarios.db')

# Criar um objeto cursor para executar comandos SQL
cursor = conn.cursor()

# Criar uma tabela com as colunas especificadas
cursor.execute('''
CREATE TABLE IF NOT EXISTS usuarios (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT NOT NULL,
    email TEXT NOT NULL
)
''')

# Commit as mudanças
conn.commit()

# Fechar a conexão com o banco de dados
conn.close()

print("Tabela 'usuarios' criada com sucesso.")
