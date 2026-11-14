function calcularTotal() {
    const checkboxes = document.querySelectorAll(".producto");
    let acumulador = 0;

    checkboxes.forEach(chk => {
        if (chk.checked) {
            acumulador += parseFloat(chk.value);
        }
    });

    document.getElementById("totalPagar").textContent = `Total a pagar: S/ ${acumulador}`;
}

// Asociar el evento change a cada checkbox mediante un bucle for
const checkboxes = document.querySelectorAll(".producto");
for (let i = 0; i < checkboxes.length; i++) {
    checkboxes[i].addEventListener("change", calcularTotal);
}