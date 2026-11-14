const campoPassword = document.getElementById("txtPassword");
const botonVer = document.getElementById("btnVer");

// Evento mousedown: al presionar el botón del ratón
botonVer.addEventListener("mousedown", () => {
    campoPassword.setAttribute("type", "text");
});

// Evento mouseup: al soltar el botón del ratón
botonVer.addEventListener("mouseup", () => {
    campoPassword.setAttribute("type", "password");
});