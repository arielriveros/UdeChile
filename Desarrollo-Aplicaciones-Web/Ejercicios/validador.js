/**
 * Imprime error
 * @param {string|number} msg
 */
function mostrarError(msg) {

    let contenedor = document.getElementById('error');
 
    if (msg !== '') {
        contenedor.innerHTML = msg;
        contenedor.style.display = 'block';
        contenedor.style.fontWeight = '800';
    }

    

}

/**
 Validacion del formulario
 */
function validacionFormulario() {

    /** @type {string}*/
    let nombre = document.getElementById('nombre').value;
    let archivo = document.getElementById('archivo').value;
    let errorMsg = '';

    let regex = /^[a-zA-Z ]*$/;

    if (nombre.length < 10 || nombre.length > 100 || !regex.test(nombre)) {
        errorMsg.concat(' Nombre incorrecto ');
    }
    if (archivo.value === null) {
        errorMsg.concat(' Ingrese un archivo ');
    }
    mostrarError(errorMsg);

    /*
    La idea sería ir añadiendo más validaciones aquí, e ir concatenando el mensaje
    de error si es que existe, para al final realizar "mostrarError(mensaje_error_concatenado)".
     */

    return true;

}

console.log('app v1.0'); // stack trace