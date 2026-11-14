jsx
import React, { useState } from 'react';


// Componente Funcional React
export default function ContadorApp() {
    // Declaración del Estado
    const [contador, setContador] = useState(0);


    const incrementar = () => setContador(contador + 1);
    const decrementar = () => setContador(contador - 1);
    const reiniciar = () => setContador(0);


    return (
        <div style={styles.card}>
            <h2>Contador de Clics</h2>
            <h1 style={styles.numero}>{contador}</h1>
            <div>
                <button style={styles.btn} onClick={decrementar}>-1</button>
                <button style={{ ...styles.btn, backgroundColor: '#6c757d' }} onClick={reiniciar}>Reset</button>
                <button style={{ ...styles.btn, backgroundColor: '#28a745' }} onClick={incrementar}>+1</button>
            </div>
        </div>
    );
}


const styles = {
    card: { border: '1px solid #ccc', borderRadius: '8px', padding: '20px', textAlign: 'center', width: '280px' },
    numero: { fontSize: '3rem', margin: '10px 0', color: '#007bff' },
    btn: { margin: '0 5px', padding: '8px 14px', color: '#fff', backgroundColor: '#dc3545', border: 'none', borderRadius: '4px', cursor: 'pointer' }
};

