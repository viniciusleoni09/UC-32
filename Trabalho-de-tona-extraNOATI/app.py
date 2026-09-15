from flask import Flask, render_template, request

app = Flask(__name__)

@app.route("/")
def inicio():
    return render_template("index.html")

@app.route("/calcular", methods=["POST"])
def calcular():
    nome = request.form["nome"]
    nota1 = float(request.form["nota1"])
    nota2 = float(request.form["nota2"])

    media = (nota1 + nota2) / 2

    if media >= 6:
        resultado = "Aprovado"
    else:
        resultado = "Reprovado"

    return render_template(
        "resultado.html",
        nome=nome,
        media=media,
        resultado=resultado
    )

if __name__ == "__main__":
    app.run(debug=True)
