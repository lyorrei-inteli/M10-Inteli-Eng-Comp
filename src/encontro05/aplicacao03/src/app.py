# Aplicação 3 - CRUD de usuários com FastAPI e SQLite

from fastapi import FastAPI, HTTPException, Response, status
from pydantic import BaseModel
from typing import List #Por estar utilizando o Python 3.8
import sqlite3

app = FastAPI()

# Conexão com o banco de dados
def conectar_bd():
    return sqlite3.connect('usuarios.db')

# Modelo Pydantic para validação de dados
class Usuario(BaseModel):
    nome: str
    email: str

class UsuarioDisplay(BaseModel):
    id: int
    nome: str
    email: str

# Conexão CORS middleware
@app.middleware("http")
async def add_cors_headers(request, call_next):
    response = await call_next(request)
    response.headers['Access-Control-Allow-Origin'] = '*'
    response.headers['Access-Control-Allow-Methods'] = 'GET, POST, PUT, DELETE'
    response.headers['Access-Control-Allow-Headers'] = 'Content-Type, Authorization'
    return response

# Rota para listar todos os usuários
@app.get("/usuarios", response_model=List[UsuarioDisplay])
def listar_usuarios():
    con = conectar_bd()
    cursor = con.cursor()
    cursor.execute('SELECT * FROM usuarios')
    usuarios = [UsuarioDisplay(id=row[0], nome=row[1], email=row[2]) for row in cursor.fetchall()]
    con.close()
    return usuarios

# Rota para buscar um usuário pelo id
@app.get("/usuarios/{id}", response_model=UsuarioDisplay)
def buscar_usuario(id: int):
    con = conectar_bd()
    cursor = con.cursor()
    cursor.execute('SELECT * FROM usuarios WHERE id = ?', (id,))
    usuario = cursor.fetchone()
    con.close()
    if usuario:
        return UsuarioDisplay(id=usuario[0], nome=usuario[1], email=usuario[2])
    raise HTTPException(status_code=404, detail="Usuário não encontrado")

# Rota para cadastrar um usuário
@app.post("/usuarios", response_model=UsuarioDisplay, status_code=status.HTTP_201_CREATED)
def cadastrar_usuario(usuario: Usuario):
    con = conectar_bd()
    cursor = con.cursor()
    cursor.execute('INSERT INTO usuarios (nome, email) VALUES (?, ?)', (usuario.nome, usuario.email))
    usuario_id = cursor.lastrowid
    con.commit()
    con.close()
    return {**usuario.dict(), "id": usuario_id}

# Rota para atualizar um usuário
@app.put("/usuarios/{id}", response_model=UsuarioDisplay)
def atualizar_usuario(id: int, usuario: Usuario):
    con = conectar_bd()
    cursor = con.cursor()
    cursor.execute('UPDATE usuarios SET nome = ?, email = ? WHERE id = ?', (usuario.nome, usuario.email, id))
    if cursor.rowcount == 0:
        con.close()
        raise HTTPException(status_code=404, detail="Usuário não encontrado")
    con.commit()
    con.close()
    return {**usuario.dict(), "id": id}

# Rota para deletar um usuário
@app.delete("/usuarios/{id}", status_code=status.HTTP_204_NO_CONTENT)
def deletar_usuario(id: int):
    con = conectar_bd()
    cursor = con.cursor()
    cursor.execute('DELETE FROM usuarios WHERE id = ?', (id,))
    if cursor.rowcount == 0:
        con.close()
        raise HTTPException(status_code=404, detail="Usuário não encontrado")
    con.commit()
    con.close()
    return Response(status_code=status.HTTP_204_NO_CONTENT)

# Iniciar a aplicação
if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)