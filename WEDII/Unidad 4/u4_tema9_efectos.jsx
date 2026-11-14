jsx
import React, { useState, useEffect } from 'react';


export default function TemporizadorEfecto() {
    const [segundos, setSegundos] = useState(0);
    const [activo, setActivo] = useState(false);


    // useEffect para simular ciclo de vida / temporizador
    useEffect(() => {
        let intervalo = null;
        if (activo) {
            intervalo = setInterval(() => {
                setSegundos(prev => prev + 1);
            }, 1000);
        } else if (!activo && segundos !== 0) {
            clearInterval(intervalo);
        }
        return () => clearInterval(intervalo);
    }, [activo, segundos]);


    return (
        <div style={{ padding: '20px', fontFamily: 'sans-serif' }}>
            <h3>Temporizador React (useEffect)</h3>
            <p>Tiempo transcurrido: <strong>{segundos}s</strong></p>
            <button onClick={() => setActivo(!activo)}>
                {activo ? 'Pausar' : 'Iniciar'}
            </button>
            <button onClick={() => { setActivo(false); setSegundos(0); }}>
                Reiniciar
            </button>
        </div>
    );
}
