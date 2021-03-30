
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

    if (edadMascota.value === "" || edadMascota.value.length < 0) {
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

function agrandarImagen1() {
    document.getElementById('foto1').style.height = '600px';
    document.getElementById('foto1').style.width = '800px';
    mostrarInfo1();
}

function mostrarInfo1() {
    document.getElementById('infoOculta1').style.display = 'block';
}
function ocultarInfo1() {
    document.getElementById('foto1').style.height = '240px';
    document.getElementById('foto1').style.width = '320px';
    document.getElementById('infoOculta1').style.display = 'none';
}
function agrandarImagen1() {
    document.getElementById('foto1').style.height = '600px';
    document.getElementById('foto1').style.width = '800px';
    mostrarInfo1();
}

function mostrarInfo2() {
    document.getElementById('infoOculta2').style.display = 'block';
}
function ocultarInfo2() {
    document.getElementById('foto2').style.height = '240px';
    document.getElementById('foto2').style.width = '320px';
    document.getElementById('infoOculta2').style.display = 'none';
}
function agrandarImagen2() {
    document.getElementById('foto2').style.height = '600px';
    document.getElementById('foto2').style.width = '800px';
    mostrarInfo3();
}

function mostrarInfo3() {
    document.getElementById('infoOculta3').style.display = 'block';
}
function ocultarInfo3() {
    document.getElementById('foto3').style.height = '240px';
    document.getElementById('foto3').style.width = '320px';
    document.getElementById('infoOculta3').style.display = 'none';
}
function agrandarImagen3() {
    document.getElementById('foto3').style.height = '600px';
    document.getElementById('foto3').style.width = '800px';
    mostrarInfo3();
}

function mostrarInfo4() {
    document.getElementById('infoOculta4').style.display = 'block';
}
function ocultarInfo4() {
    document.getElementById('foto4').style.height = '240px';
    document.getElementById('foto4').style.width = '320px';
    document.getElementById('infoOculta4').style.display = 'none';
}
function agrandarImagen4() {
    document.getElementById('foto4').style.height = '600px';
    document.getElementById('foto4').style.width = '800px';
    mostrarInfo4();
}

function mostrarInfo5() {
    document.getElementById('infoOculta5').style.display = 'block';
}
function ocultarInfo5() {
    document.getElementById('foto5').style.height = '240px';
    document.getElementById('foto5').style.width = '320px';
    document.getElementById('infoOculta5').style.display = 'none';
}
function agrandarImagen5() {
    document.getElementById('foto5').style.height = '600px';
    document.getElementById('foto5').style.width = '800px';
    mostrarInfo5();
}