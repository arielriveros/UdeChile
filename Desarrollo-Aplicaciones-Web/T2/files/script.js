
function validarFormulario() {

    /** @type (string) */
    let region = document.getElementById('region');
        comuna = document.getElementById('comuna');
        calle = document.getElementById('calle'),
        numero = document.getElementById('numero'),
        sector = document.getElementById('sector');
        nombre = document.getElementById('nombre'),
        email = document.getElementById('email'),
        celular = document.getElementById('celular'),
        edadMascota = document.getElementById('edad-mascota'),
        colorMascota = document.getElementById('color-mascota'),
        razaMascota = document.getElementById('raza-mascota');

    var formatoEmail = /^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$/;
    var formatoCelular = /^\d{8}$/;

    if (region.value === "") {
        mensajeError('Seleccione region');
        return false;
    }

    if (comuna.value === "") {
        mensajeError('Seleccione comuna');
        return false;
    }

    if (calle.value === "" || calle.value.length > 250) {
        mensajeError('Ingrese calle valida');
        return false;
    }

    if (numero.value === "" || numero.value.length > 20) {
        mensajeError('Ingrese numero valido');
        return false;
    }

    if (sector.value.length > 100) {
        mensajeError('Sector invalido');
        return false;
    }

    if (nombre.value === "" || numero.value.length > 200) {
        mensajeError('Ingrese nombre valido');
        return false;
    }

    if (email.value === "" || !email.value.match(formatoEmail)) {
        mensajeError('Ingrese e-mail valido');
        return false;
    }

    if (celular.value !== "" && !celular.value.match(formatoCelular)) {
        mensajeError('Celular invalido');
        return false;
    }

    if (document.getElementById('tipo-mascota').value === '9' &&
        document.getElementById('tipo').value === "" ||
        document.getElementById('tipo').value.length > 40) {
        mensajeError('Ingrese tipo de mascota');
        return false;
    }

    if (edadMascota.value === "" || edadMascota.value < 0) {
        mensajeError('Ingrese edad valida');
        return false;
    }

    if (colorMascota.value === "" || colorMascota.value.length > 30) {
        mensajeError('Ingrese color valido');
        return false;
    }

    if (razaMascota.value === "" || razaMascota.value.length > 30) {
        mensajeError('Ingrese raza valida');
        return false;
    }

    if (document.getElementById('foto-mascota').value === "") {
        mensajeError('Seleccione una imagen');
        return false;
    }

    document.getElementById('error').style.display = 'none';
    return true;
}

function mensajeError(msg) {
    let mensajeFinal = document.getElementById('error')
    mensajeFinal.innerHTML = msg;
    mensajeFinal.style.display = 'block';
}

function checkOtro() {
    var m = document.getElementById('tipo-mascota');
    if (m.value === '9') {
        document.getElementById('tipo').style.display = 'block';
    } else {
        document.getElementById('tipo').style.display = 'none';
        document.getElementById('error').style.display = 'none';
    }
}

/**
 * Como es pagina estatica voy a dejar este desastre de funciones
 * lo arreglo en proximas entregas ;)
 * */

function agrandarImagen(name) {
    document.getElementById(name).style.height = '600px';
    document.getElementById(name).style.width = '800px';
    mostrarInfo1();
}

function mostrarInfo(name) {
    document.getElementById(name).style.display = 'block';
}
function ocultarInfo(name) {
    document.getElementById(name).style.height = '240px';
    document.getElementById(name).style.width = '320px';
    document.getElementById(name).style.display = 'none';
}