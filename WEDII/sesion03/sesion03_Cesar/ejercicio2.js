function convertirMoneda(evento) {
    const valorDolares = evento.target.value;
    const parrafoResultado = document.getElementById("resultadoSoles");
    const tipoCambio = 3.75; // Tipo de cambio fijo

    if (valorDolares === "" || isNaN(valorDolares)) {
        parrafoResultado.textContent = "0.00 soles";
    } else {
        let soles = parseFloat(valorDolares) * tipoCambio;
        parrafoResultado.textContent = soles.toFixed(2) + " soles";
    }
}

const inputDolares = document.getElementById("txtDolares");
inputDolares.addEventListener("input", convertirMoneda);