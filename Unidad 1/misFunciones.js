function funcionNota1(){
// Declaración de variables (const, let)
        const curso = "Desarrollo de Entornos Web";
        const codigoCurso = 4684;
        let esActivo = true;
        let nota1 = 15;
        let nota2 = 18;

        // Operaciones aritméticas y promedio
        let promedio = (nota1 + nota2) / 2;

        // Construcción de mensaje
        let mensaje = `
            <h2>Curso: ${curso} (${codigoCurso})</h2>
            <p><strong>Estado:</strong> ${esActivo ? 'Activo' : 'Inactivo'}</p>
            <p><strong>Nota 1:</strong> ${nota1}</p>
            <p><strong>Nota 2:</strong> ${nota2}</p>
            <p><strong>Promedio:</strong> $${promedio.toFixed(2)}$</p>
        `;

        document.getElementById("resultado").innerHTML = mensaje;

}

function funcionNota(){
    // Declaración de variables (const, let)
    const curso = "Desarrollo de Entornos Web";
    const codigoCurso = 4684;
    let esActivo = true;
    let nota1 = 15;
    let nota2 = 18;

    // Operaciones aritméticas y promedio
    let promedio = (nota1 + nota2) / 2;

    // Construcción de mensaje
    let mensaje = `
        <h2>Curso: ${curso} (${codigoCurso})</h2>
        <p><strong>Estado:</strong> ${esActivo ? 'Activo' : 'Inactivo'}</p>
        <p><strong>Nota 1:</strong> ${nota1}</p>
        <p><strong>Nota 2:</strong> ${nota2}</p>
        <p><strong>Promedio:</strong> ${promedio.toFixed(2)}</p>
    `;

    document.getElementById("resultado").innerHTML = mensaje;
}
function funcionNota1(){
// Invocamos la función directamente al cargar el archivo JS
//funcionNota();

 let notaFinal = 16;
        let estado = "";
        let categoria = "";

        // Condicional doble
        if (notaFinal >= 13) {
            estado = "<span style='color:green;'>Aprobado</span>";
        } else {
            estado = "<span style='color:red;'>Desaprobado</span>";
        }

        // Estructura Selectiva: switch
        let nivel = 2; // Nivel del estudiante
        switch (nivel) {
            case 1:
                categoria = "Principiante";
                break;
            case 2:
                categoria = "Intermedio";
                break;
            case 3:
                categoria = "Avanzado";
                break;
            default:
                categoria = "No especificado";
        }

        document.getElementById("salida").innerHTML = `
            <p><strong>Nota Final:</strong> ${notaFinal}</p>
            <p><strong>Estado:</strong> ${estado}</p>
            <p><strong>Categoría:</strong> ${categoria}</p>
        `;
    }