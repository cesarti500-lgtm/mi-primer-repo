// ==========================================
// EJERCICIO 1: Interruptor de luz
// ==========================================
let luzEncendida = false;

function alternarLuz() {
  const titulo = document.getElementById('tituloLuz');
  const cuadro = document.getElementById('cuadroLuz');
  const boton = document.getElementById('btnLuz');

  luzEncendida = !luzEncendida; // Invierte el estado de true a false y viceversa

  if (luzEncendida) {
    cuadro.style.backgroundColor = 'yellow';
    titulo.textContent = 'La habitación está iluminada';
    boton.textContent = 'Apagar luz';
  } else {
    cuadro.style.backgroundColor = 'black';
    titulo.textContent = 'La habitación está oscura';
    boton.textContent = 'Encender luz';
  }
}

document.getElementById('btnLuz').addEventListener('click', alternarLuz);


// ==========================================
// EJERCICIO 2: Conversor de moneda en tiempo real
// ==========================================
function convertirASoles(evento) {
  const resultado = document.getElementById('resultadoSoles');
  const dolares = parseFloat(evento.target.value);
  const tipoCambio = 3.75;

  if (isNaN(dolares) || dolares <= 0) {
    resultado.textContent = '0.00 soles';
  } else {
    const soles = (dolares * tipoCambio).toFixed(2);
    resultado.textContent = `${soles} soles`;
  }
}

document.getElementById('inputDolares').addEventListener('input', convertirASoles);


// ==========================================
// EJERCICIO 3: Mostrar y ocultar contraseña
// ==========================================
function mostrarClave() {
  document.getElementById('inputClave').type = 'text';
}

function ocultarClave() {
  document.getElementById('inputClave').type = 'password';
}

const btnClave = document.getElementById('btnVerClave');
btnClave.addEventListener('mousedown', mostrarClave);
btnClave.addEventListener('mouseup', ocultarClave);
// Agregamos mouseleave por seguridad si el usuario suelta el clic fuera del botón
btnClave.addEventListener('mouseleave', ocultarClave);


// ==========================================
// EJERCICIO 4: Calculadora de total de compra
// ==========================================
function calcularTotal() {
  const casillas = document.querySelectorAll('.producto');
  let suma = 0;

  casillas.forEach((casilla) => {
    if (casilla.checked) {
      suma += Number(casilla.value);
    }
  });

  document.getElementById('totalCompra').textContent = `Total a pagar: S/ ${suma}`;
}

const listaCheckboxes = document.querySelectorAll('.producto');
listaCheckboxes.forEach((checkbox) => {
  checkbox.addEventListener('change', calcularTotal);
});


