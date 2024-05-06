# Aplicação 1 - CRUD de usuários com Flask e SQLite

from flask import Flask, request, jsonify
import sqlite3

app = Flask(__name__)

# Cria a o conector com o banco de dados
def conectar_bd():
    return sqlite3.connect('usuarios.db')

# Resolve problema do CORS
@app.after_request
def after_request(response):
    response.headers.add('Access-Control-Allow-Origin', '*')
    response.headers.add('Access-Control-Allow-Headers', 'Content-Type,Authorization')
    response.headers.add('Access-Control-Allow-Methods', 'GET,PUT,POST,DELETE')
    return response

# Cria uma entidade para o usuário
class Usuario:
    def __init__(self, id, nome, email):
        self.id = id
        self.nome = nome
        self.email = email
    def __repr__(self):
        return f'<Usuario nome:{self.nome}; email:{self.email}; id:{self.id}>'

# Rota para listar todos os usuários
@app.route('/usuarios', methods=['GET'])
def listar_usuarios():
    con = conectar_bd()
    cursor = con.cursor()
    cursor.execute('select * from usuarios')
    usuarios = cursor.fetchall()
    con.close()
    return jsonify(usuarios)

# Rota para buscar um usuário pelo id
@app.route('/usuarios/<int:id>', methods=['GET'])
def buscar_usuario(id):
    con = conectar_bd()
    cursor = con.cursor()
    cursor.execute('select * from usuarios where id = ?', (id,))
    usuario = cursor.fetchone()
    con.close()
    return jsonify(usuario)

# Rota para cadastrar um usuário
@app.route('/usuarios', methods=['POST'])
def cadastrar_usuario():
    # Pega o JSON enviado no corpo da requisição
    # O corpo da requisição deve possuir o seguinte formato:
    # {
    #   "nome": "Fulano",
    #   "email": "email@mail.com"
    # }
    novo_usuario = request.json
    con = conectar_bd()
    cursor = con.cursor()
    cursor.execute('insert into usuarios (nome, email) values (?, ?)', (novo_usuario['nome'], novo_usuario['email']))
    con.commit()
    con.close()
    return jsonify(novo_usuario), 201

# Rota para atualizar um usuário
@app.route('/usuarios/<int:id>', methods=['PUT'])
def atualizar_usuario(id):
    # Pega o JSON enviado no corpo da requisição
    # O corpo da requisição deve possuir o seguinte formato:
    # {
    #   "nome": "Fulano",
    #   "email": "
    # }
    usuario_atualizado = request.json
    con = conectar_bd()
    cursor = con.cursor()
    cursor.execute('update usuarios set nome = ?, email = ? where id = ?', (usuario_atualizado['nome'], usuario_atualizado['email'], id))
    con.commit()
    con.close()
    return jsonify(usuario_atualizado)

# Rota para deletar um usuário
@app.route('/usuarios/<int:id>', methods=['DELETE'])
def deletar_usuario(id):
    con = conectar_bd()
    cursor = con.cursor()
    cursor.execute('delete from usuarios where id = ?', (id,))
    con.commit()
    con.close()
    return '', 204

if __name__ == '__main__':
    app.run(debug=False, host='0.0.0.0', port=8000, threaded=False)