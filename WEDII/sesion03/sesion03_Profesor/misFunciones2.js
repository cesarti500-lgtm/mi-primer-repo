// --- DEFINICIÓN DE FUNCIONES ---

function cambiarColorFondo(evento) {
  // evento.target.value obtiene el valor de la opción elegida
  const colorElegido = evento.target.value;
  document.body.style.backgroundColor = colorElegido;
}

function mostrarAyuda() {
  const ayuda = document.getElementById('textoAyuda');
  ayuda.textContent = '¡Estás sobre la caja! Haz clic para continuar.';
}

function ocultarAyuda() {
  const ayuda = document.getElementById('textoAyuda');
  ayuda.textContent = '';
}

function resaltarCampo(evento) {
  evento.target.style.backgroundColor = '#e8f0fe';
  evento.target.style.outline = '2px solid #1a73e8';
}

function restaurarCampo(evento) {
  evento.target.style.backgroundColor = 'white';
  evento.target.style.outline = 'none';
}

// --- ASIGNACIÓN DE EVENTOS ---

const selector = document.getElementById('selectorColor');
selector.addEventListener('change', cambiarColorFondo);

const caja = document.getElementById('cajaInfo');
caja.addEventListener('mouseover', mostrarAyuda);
caja.addEventListener('mouseout', ocultarAyuda);

const inputNombre = document.getElementById('campoNombre');
inputNombre.addEventListener('focus', resaltarCampo);
inputNombre.addEventListener('blur', restaurarCampo);
