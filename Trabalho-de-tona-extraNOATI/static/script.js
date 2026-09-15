const nome = document.getElementById("nome");
const mensagem = document.getElementById("mensagem");

nome.addEventListener("input", function () {
    if (nome.value.trim() !== "") {
        mensagem.textContent = "Olá, " + nome.value + "! Preencha suas notas.";
    } else {
        mensagem.textContent = "";
    }
});
