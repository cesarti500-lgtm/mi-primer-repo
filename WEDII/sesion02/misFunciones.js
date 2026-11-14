function funcion1(){
    nombre = document.getElementById("nombre").value;
    distrito = document.getElementById("distrito").value;
    idioma = '';
    if (document.getElementById("f").checked)
        sexo = document.getElementById("f").value;
    else
        sexo = document.getElementById("m").value;

    if (document.getElementById("ingles").checked) 
        idioma += document.getElementById("ingles").value;

    if (document.getElementById("frances").checked) 
        idioma += ' ' + document.getElementById("frances").value;

    if (document.getElementById("aleman").checked) 
        idioma += ' ' + document.getElementById("aleman").value;


    document.getElementById("datos").innerHTML = 
        "Nombre: " + nombre +
        "<br>Distrito: " + distrito +
        "<br>Sexo: " + sexo +
        "<br>Idioma: " + idioma;

}

function funcion2(){
    nota1 = parseInt(document.getElementById("nota1").value);
    nota2 = parseInt(document.getElementById("nota2").value);
    nota3 = parseInt(document.getElementById("nota3").value);
    promedio = (nota1 + nota2 + nota3) / 3;
    document.getElementById("datos").innerHTML = 
        "Promedio: " + Math.round(promedio * 100) / 100;
}