from flask import Flask, render_template, request, redirect, url_for, flash
import os
import sqlite3

app = Flask(__name__)

app.secret_key = "chave_escola_123"

CAMINHO_BANCO = os.path.join(
    os.path.dirname(__file__),
    "escola.db"
)


def conectar_banco():
    conexao = sqlite3.connect(CAMINHO_BANCO)
    conexao.row_factory = sqlite3.Row

    return conexao


@app.route("/")
def inicio():
    return render_template("index.html")


@app.route("/alunos")
def alunos():
    conexao = conectar_banco()

    lista_alunos = conexao.execute(
        "SELECT * FROM alunos ORDER BY nome"
    ).fetchall()

    conexao.close()

    return render_template(
        "alunos.html",
        alunos=lista_alunos
    )


@app.route("/alunos/cadastrar", methods=["POST"])
def cadastrar_aluno():

    nome = request.form["nome"]
    data_nascimento = request.form["data_nascimento"]
    email = request.form["email"]
    telefone = request.form["telefone"]

    try:
        conexao = conectar_banco()

        conexao.execute("""
            INSERT INTO alunos
            (nome, data_nascimento, email, telefone)
            VALUES (?, ?, ?, ?)
        """, (
            nome,
            data_nascimento or None,
            email or None,
            telefone or None
        ))

        conexao.commit()
        conexao.close()

        flash("Aluno cadastrado com sucesso!", "sucesso")

    except sqlite3.IntegrityError:
        flash("Este e-mail já está cadastrado!", "erro")

    except sqlite3.Error as erro:
        flash(f"Erro ao cadastrar aluno: {erro}", "erro")

    return redirect(url_for("alunos"))


if __name__ == "__main__":
    app.run(debug=True)
