
function submitMedico(){
    let errorStr = '';
    let nombre = document.getElementById('nombre-medico').value;
    let experiencia = document.getElementById('experiencia-medico').value;
    let especialidad = document.getElementById('especialidad-medico').value;
    let email = document.getElementById('email-medico').value;
    let celular = document.getElementById('celular-medico').value;
    let foto = document.getElementById('foto-medico').value;
    let form = new FormData();
    form.append('nombre-medico', nombre);
    form.append('experiencia-medico',experiencia);
    form.append('especialidad-medico', especialidad);
    form.append('email-medico', email);
    form.append('celular-medico',celular);
    form.append('foto-medico',foto);

    let req = new XMLHttpRequest();
    req.open('POST','../cgi-bin/save_doctor.py');
    req.timeout = 300;
    req.onload = (data) => {
        let text = data.currentTarget.responseText;
        alert('Los datos fueron enviados correctamente')
        console.log(text);
    }
    req.send(form);
    return false;
}

function loadMedicos(){
    let xhr = new XMLHttpRequest();
    xhr.open('GET', '../cgi-bin/list.py');
    console.log("Cargando Medicos");
    xhr.timeout = 500;
    xhr.onload = function (data) {
        // noinspection JSUnresolvedVariable
        /** @type {string} */ let datatext = data.currentTarget.responseText;
        if (datatext.includes('EMPTY')) {
            alert("No hay médicos registrados");
            return;
        }
        console.log(datatext);
        datos = JSON.parse(datatext);
        ventanMedicos(datos);
    }
    xhr.send();
}

function ventanMedicos(datos){
    var root = document.documentElement;
    var preview = "";
    for (var i = 0; i < 5; i++){
        preview += `
        <div>
        <ul>
        ${datos[i]}
            <li> Nombre: ${datos[i]} </li>
            Experiencia: ${datos[i]}
            <br>
            Especialidad: ${datos[i]}
            <br>

            <br>
            Email: ${datos[i]}
            <br>
            Celular: ${datos[i]}
            <br>
        </ul>
        </div>`
    }
    if (root) root.innerHTML = preview;
} 