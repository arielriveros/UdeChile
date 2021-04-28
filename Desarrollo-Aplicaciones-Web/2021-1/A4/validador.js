/**
 * Imprime error
 * @param {string|number} msg
 */
function mostrarError(msg) {

    let contenedor = document.getElementById('error');

    contenedor.innerHTML = msg;
    contenedor.style.display = 'block';
    contenedor.style.fontWeight = '800';

}

/**
 Validacion del formulario
 */
function validacionFormulario() {
	
	// Este string va concatenando los errores
	let msgError = '';

	/**
	Validacion nombre
	*/
	let nombre = document.getElementById('nombre').value;
    let regex = /^[a-zA-Z ]*$/;
    if (nombre.length < 10 || nombre.length > 100 || !regex.test(nombre)) {
        msgError += 'Nombre ';
    }

    /*
    La idea sería ir añadiendo más validaciones aquí, e ir concatenando el mensaje
    de error si es que existe, para al final realizar "mostrarError(mensaje_error_concatenado)".
     */
	 
	/**
     Validacion archivo
     */
    if (document.getElementById('archivo').files.length === 0) {
        msgError += 'Archivo no adjunto ';

    }
	
	/**
    Validacion privacidad
     */
    let privacidad = document.getElementById('privacidad').value;
    if (privacidad === '') {
        msgError += 'Privacidad no seleccionada '

    }
	
	/**
    Validacion password
     */
    let pass = document.getElementById('password').value;
    let easy_pass = ['password', '1234', 'pass', 'user', 'hackbox']
    for (let i = 0; i < easy_pass.length; i++) {
        if (pass === easy_pass[i]) {
            msgError += 'Contraseña debil ';
        }
    } /** También se puede hacer con easy_pass.includes(pass) */
    if (pass.length >= 10) {
        msgError += 'Contraseña muy larga ';
    }
	
	/**
    Validacion Autodestruir
     */
    let autoDestruir = document.getElementById('autodestruir').value;
    if (!(autoDestruir === '')) { // Ya que es opcional
        if (autoDestruir < 1 || autoDestruir > 3153600) {
            msgError += 'Tiempo autodestruir invalido ';
        }
    }

	/***
	Validacion comentario
	*/
	let comentario = document.getElementById('comentario');
    if (!comentario.value == ''){ // Ya que es opcional
        if(comentario.value.length>1000){
            msgError += 'Comentario excede el largo maximo ';
        }
    }
	
	/**
	Mostramos el error y retornamos el estado de la validacion
	*/
	if (msgError.length >0) {
		mostrarError('Tu formulario fallo en: ' + msgError);
		return false;
	}
    return true;

}

console.log('app v1.0'); // stack trace