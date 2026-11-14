// --- DEFINICIÓN DE FUNCIONES ---

function alternarTema() {
  const mensaje = document.getElementById('mensaje');
  document.body.classList.toggle('oscuro');
  mensaje.textContent = 'Has cambiado el tema de la página.';
}

function validarFormulario(evento) {
  evento.preventDefault(); // Evita que la página se recargue
  const correo = document.getElementById('correo').value;

  if (correo === '') {
    alert('Por favor, escribe tu correo antes de enviar.');
  } else {
    alert(`Correo registrado: ${correo}`);
  }
}

function actualizarContador(evento) {
  const contador = document.getElementById('contador');
  const restantes = 100 - evento.target.value.length;
  contador.textContent = restantes;
}

function detectarTeclaEscape(evento) {
  if (evento.key === 'Escape') {
    alert('Has presionado la tecla Escape.');
  }
}

function tacharTarea(evento) {
  if (evento.target.tagName === 'LI') {
    evento.target.style.textDecoration = 'line-through';
  }
}

// --- ASIGNACIÓN DE EVENTOS ---

const botonTema = document.getElementById('btnTema');
botonTema.addEventListener('click', alternarTema);

const formulario = document.getElementById('formularioRegistro');
formulario.addEventListener('submit', validarFormulario);

const campoTexto = document.getElementById('comentario');
campoTexto.addEventListener('input', actualizarContador);

document.addEventListener('keydown', detectarTeclaEscape);

const lista = document.getElementById('listaTareas');
lista.addEventListener('click', tacharTarea);
