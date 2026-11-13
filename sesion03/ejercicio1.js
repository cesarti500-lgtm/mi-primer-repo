function interruptorLuz() {
    const titulo = document.getElementById("titulo");
    const cuadro = document.getElementById("cuadro");
    const boton = document.getElementById("btnLuz");

    // Verificamos el estado actual por el color de fondo del cuadro
    if (cuadro.style.backgroundColor === "yellow") {
        cuadro.style.backgroundColor = "black";
        titulo.textContent = "La habitación está oscura";
        boton.textContent = "Encender luz";
    } else {
        cuadro.style.backgroundColor = "yellow";
        titulo.textContent = "La habitación está iluminada";
        boton.textContent = "Apagar luz";
    }
}

const botonLuz = document.getElementById("btnLuz");
botonLuz.addEventListener("click", interruptorLuz);