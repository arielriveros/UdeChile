
// INICIO EMULACIÓN BACKEND

let dataAvistamientos = []
let bounds = [0,5];
window.onload = () => {
    renderPage("inicio");
    insertForm();
    bounds = [0,5];
    fetch('cgi-bin/download_handler.py')
    .then(response => response.json())
    .then(data => dataAvistamientos = data)
    .then(()=>{loadPreview(dataAvistamientos); loadListado(0,5,dataAvistamientos)});
};

var locationData = [ { region: "Región Metropolitana de Santiago", comunas: [ "Cerrillos", "Cerro Navia", "Conchalí", "El Bosque", "Estación Central", "Huechuraba", "Independencia", "La Cisterna", "La Florida", "La Granja", "La Pintana", "La Reina", "Las Condes", "Lo Barnechea", "Lo Espejo", "Lo Prado", "Macul", "Maipú", "Ñuñoa", "Pedro Aguirre Cerda", "Peñalolén", "Providencia", "Pudahuel", "Quilicura", "Quinta Normal", "Recoleta", "Renca", "Santiago", "San Joaquín", "San Miguel", "San Ramón", "Vitacura", "Puente Alto", "Pirque", "San José de Maipo", "Colina", "Lampa", "Tiltil", "San Bernardo", "Buin", "Calera de Tango", "Paine", "Melipilla", "Alhué", "Curacaví", "María Pinto", "San Pedro", "Talagante", "El Monte", "Isla de Maipo", "Padre Hurtado", "Peñaflor" ] }, { region: "Región de Tarapacá", comunas: [ "Iquique", "Alto Hospicio", "Pozo Almonte", "Camiña", "Colchane", "Huara", "Pica" ] }, { region: "Región de Antofagasta", comunas: [ "Antofagasta", "Mejillones", "Sierra Gorda", "Taltal", "Calama", "Ollagüe", "San Pedro de Atacama", "Tocopilla", "María Elena" ] }, { region: "Región de Atacama", comunas: [ "Copiapó", "Caldera", "Tierra Amarilla", "Chañaral", "Diego de Almagro", "Vallenar", "Alto del Carmen", "Freirina", "Huasco" ] }, { region: "Región de Coquimbo", comunas: [ "La Serena", "Coquimbo", "Andacollo", "La Higuera", "Paiguano", "Vicuña", "Illapel", "Canela", "Los Vilos", "Salamanca", "Ovalle", "Combarbalá", "Monte Patria", "Punitaqui", "Río Hurtado" ] }, { region: "Región de Valparaíso", comunas: [ "Valparaíso", "Casablanca", "Concón", "Juan Fernández", "Puchuncaví", "Quintero", "Viña del Mar", "Isla de Pascua", "Los Andes", "Calle Larga", "Rinconada", "San Esteban", "La Ligua", "Cabildo", "Papudo", "Petorca", "Zapallar", "Quillota", "Calera", "Hijuelas", "La Cruz", "Nogales", "San Antonio", "Algarrobo", "Cartagena", "El Quisco", "El Tabo", "Santo Domingo", "San Felipe", "Catemu", "Llaillay", "Panquehue", "Putaendo", "Santa María", "Quilpué", "Limache", "Olmué", "Villa Alemana" ] }, { region: "Región del Libertador Bernardo OHiggins", comunas: [ "Rancagua", "Codegua", "Coinco", "Coltauco", "Doñihue", "Graneros", "Las Cabras", "Machalí", "Malloa", "San Francisco de Mostazal", "Olivar", "Peumo", "Pichidegua", "Quinta de Tilcoco", "Rengo", "Requínoa", "San Vicente de Tagua Tagua", "Pichilemu", "La Estrella", "Litueche", "Marchihue", "Navidad", "Paredones", "San Fernando", "Chépica", "Chimbarongo", "Lolol", "Nancagua", "Palmilla", "Peralillo", "Placilla", "Pumanque", "Santa Cruz" ] }, { region: "Región del Maule", comunas: [ "Talca", "Constitución", "Curepto", "Empedrado", "Maule", "Pelarco", "Pencahue", "Río Claro", "San Clemente", "San Rafael", "Cauquenes", "Chanco", "Pelluhue", "Curicó", "Hualañé", "Licantén", "Molina", "Rauco", "Romeral", "Sagrada Familia", "Teno", "Vichuquén", "Linares", "Colbún", "Longaví", "Parral", "Retiro", "San Javier de Loncomilla", "Villa Alegre", "Yerbas Buenas" ] }, { region: "Región del Biobío", comunas: [ "Concepción", "Coronel", "Chiguayante", "Florida", "Hualqui", "Lota", "Penco", "San Pedro de la Paz", "Santa Juana", "Talcahuano", "Tomé", "Hualpén", "Lebu", "Arauco", "Cañete", "Contulmo", "Curanilahue", "Los Álamos", "Tirúa", "Los Ángeles", "Antuco", "Cabrero", "Laja", "Mulchén", "Nacimiento", "Negrete", "Quilaco", "Quilleco", "San Rosendo", "Santa Bárbara", "Tucapel", "Yumbel", "Alto Biobío" ] }, { region: "Región de la Araucanía", comunas: [ "Temuco", "Carahue", "Cunco", "Curarrehue", "Freire", "Galvarino", "Gorbea", "Lautaro", "Loncoche", "Melipeuco", "Nueva Imperial", "Padre las Casas", "Perquenco", "Pitrufquén", "Pucón", "Saavedra", "Teodoro Schmidt", "Toltén", "Vilcún", "Villarrica", "Cholchol", "Angol", "Collipulli", "Curacautín", "Ercilla", "Lonquimay", "Los Sauces", "Lumaco", "Purén", "Renaico", "Traiguén", "Victoria" ] }, { region: "Región de Los Ríos", comunas: [ "Valdivia", "Corral", "Lanco", "Los Lagos", "Máfil", "Mariquina", "Paillaco", "Panguipulli", "La Unión", "Futrono", "Lago Ranco", "Río Bueno" ] }, { region: "Región de Los Lagos", comunas: [ "Puerto Montt", "Calbuco", "Cochamó", "Fresia", "Frutillar", "Los Muermos", "Llanquihue", "Maullín", "Puerto Varas", "Castro", "Ancud", "Chonchi", "Curaco de Vélez", "Dalcahue", "Puqueldón", "Queilén", "Quellón", "Quemchi", "Quinchao", "Osorno", "Puerto Octay", "Purranque", "Puyehue", "Río Negro", "San Juan de la Costa", "San Pablo", "Chaitén", "Futaleufú", "Hualaihué", "Palena" ] }, { region: "Región Aisén del General Carlos Ibáñez del Campo", comunas: [ "Coihaique", "Lago Verde", "Aisén", "Cisnes", "Guaitecas", "Cochrane", "O’Higgins", "Tortel", "Chile Chico", "Río Ibáñez" ] }, { region: "Región de Magallanes y de la Antártica Chilena", comunas: [ "Punta Arenas", "Laguna Blanca", "Río Verde", "San Gregorio", "Cabo de Hornos (Ex Navarino)", "Antártica", "Porvenir", "Primavera", "Timaukel", "Natales", "Torres del Paine" ] }, { region: "Región Arica y Parinacota", comunas: ["Arica", "Camarones", "Putre", "General Lagos"] }, { region: "Región del Ñuble", comunas: [ "Cobquecura", "Coelemu", "Ninhue", "Portezuelo", "Quirihue", "Ránquil", "Treguaco", "Bulnes", "Chillán Viejo", "Chillán", "El Carmen", "Pemuco", "Pinto", "Quillón", "San Ignacio", "Yungay", "Coihueco", "Ñiquén", "San Carlos", "San Fabián", "San Nicolás" ] } ];

function addItem(datos, itemToAdd){
    datos.push(itemToAdd)
}
function numeroAvistamientos(datos, nombreContacto){
    var count = 0;
    datos.forEach(elem => {
        if(elem.nombre === nombreContacto) count++;
        }
    )
    return count;
}
// FIN EMULACIÓN BACKEND

// FUNCIONES AUXILIARES
let numFormularios = 0;
function showElementById(id,show){
    if (document.getElementById(id)){
        show ?
        document.getElementById(id).removeAttribute("hidden")
        : document.getElementById(id).setAttribute("hidden",true)
    }
}
function disableElementById(name, enable = false){
    var formElement = document.getElementsByName(name);
    if (formElement){
        enable ? 
        formElement.forEach(elem=> elem.removeAttribute("disabled")) 
        : formElement.forEach(elem=> elem.setAttribute("disabled",true))
    }
}
function showDetailsById(id, show){
    for(var i = 0; i < document.getElementById("details-container").childElementCount; i++){
        document.getElementById(`details-${i}`).setAttribute("hidden",true);
    }
    if(show) showElementById(id,true);
}
function enlargeImg(src,enlarge){
    showElementById('details-img',enlarge)
    document.getElementById('details-img-photo').innerHTML = 
    !enlarge ? '' :
    `
    <img src=${src}>
    `
}
// FIN FUNCIONES AUXILIARES
function renderPage(page){
    const sections = ["inicio", "informar", "listado","stats"];
    sections.forEach(elem => {
        document.getElementById(`${elem}`).setAttribute("hidden",true);
        document.getElementById(`${elem}-title`).setAttribute("hidden",true);
        document.getElementById(`${elem}-btn`).removeAttribute("disabled");
    })
    document.getElementById(`${page}`).removeAttribute("hidden");
    document.getElementById(`${page}-title`).removeAttribute("hidden");
    document.getElementById(`${page}-btn`).setAttribute("disabled",true);
}
function loadPreview(datos){
    var previewElement = document.getElementById("previews");
    var preview = "";
    var j = 5;
    datos.length < 5 ? j = datos.length : j = 5;
    for (var i = 0; i < j; i++){
        preview += `
        <div class="preview-capsule">
        <table>
        <thead>
        <tr> 
        <td> Fecha </td>
        <td> Comuna </td>
        <td> Sector </td>
        <td> Tipo </td>
        <td> Foto </td>
        </tr>
        </thead>
        <tbody>
        <tr> 
        <td><h5>${datos[i].fecha}</h5></td>
        <td><h5>${datos[i].comuna}</h5></td>
        <td><h5>${datos[i].sector}</h5></td>
        <td><h5>${datos[i].tipo}</h5></td>
        <td><img src="${datos[i].fotos[0]}" alt="Fotografia del animal"></td>
        </tr>
        </tbody>
        </table>
        </div>`
    }
    if (previewElement) previewElement.innerHTML = preview;
} 
function loadRegiones(ID){
    var formElement = document.getElementById(`region-${ID}`);
    var options = `<option value="" name="disable-this-${ID}">Seleccione</option>`;
    locationData.forEach(elem => {
        options += `<option> ${elem.region} </option>`
    })
    if (formElement){
        formElement.innerHTML = options;
    }
}
function loadComunas(selectedRegion, ID){
    var formElement = document.getElementById(`comuna-${ID}`);
    var region = selectedRegion.value;
    var comunas;
    if(selectedRegion !==undefined){ 
        comunas = locationData.find(elem => elem.region === region).comunas;
    }
    var options = `<option name="disable-this-${ID}" value="">Seleccione</option>`;
    comunas.forEach(elem => {
        options += `<option> ${elem} </option>`
    })
    if (formElement){
        formElement.innerHTML = options;
    }
}
function addFileInput(ID){
    var fileInputs = document.getElementById(`file-list-${ID}`)
    var newFileInput = `<li class="file-list"><input type="file" name="foto-avistamiento-${ID}" id="foto-avistamiento-${ID}"></li>`
    if (fileInputs.childElementCount <= 5) fileInputs.insertAdjacentHTML("beforeend",newFileInput);
}
function insertForm(){
    const renderForm = (ID) => { 
        return `
        <div>
        <h4> Avistamiento ${ID+1} </h4>
            <ul>      
                <li>
                    <label> Región<i class="req">*</i> </label>
                    <select onchange="loadComunas(this, ${ID}); disableElementById('disable-this-${ID}')" id="region-${ID}" name="region" ></select>
                    <label> Comuna<i class="req">*</i> </label>
                    <select onchange="showElementById('unhide-this-${ID}',true); disableElementById('disable-this-${ID}')" id="comuna-${ID}" name="comuna" ></select>
                </li>
                <li hidden id="unhide-this-${ID}">
                    <label> Sector </label>
                    <textarea name="sector" maxlength="200" rows="4" cols="40"> </textarea>
                </li>
            </ul>   
            <div style="display:flex; justify-content: space-between; margin: 5px;">         
                <ul>
                    <li>
                        <label> Hora y Fecha <i class="req">*</i></label>
                        <input type="datetime-local" name="dia-hora-avistamiento" id="dia-hora-avistamiento-${ID}">
                    </li>
                    <li>
                        <label> Tipo <i class="req">*</i></label>
                        <select name="tipo-avistamiento" id="tipo-avistamiento-${ID}">
                            <option value=""> Seleccione</option>
                            <option> No sé </option>
                            <option> Insecto </option>
                            <option> Aráctnido </option>
                            <option> Miriápodo </option>
                        </select>
                        <label> Estado <i class="req">*</i></label>
                        <select name="estado-avistamiento" id="estado-avistamiento-${ID}">
                            <option value=""> Seleccione</option>
                            <option> No sé </option>
                            <option> Vivo </option>
                            <option> Muerto </option>
                        </select>
                    </li>
                </ul>          
                <ul id="file-list-${ID}">
                    <li><label> Fotografías<i class="req">*</i> 
                        <button type="button" onclick="addFileInput(${ID})"> Agregar </button> </label></li>
                    <li class="file-list"><input type="file" id="foto-avistamiento-${ID}" name="foto-avistamiento-${ID}"></li>
                </ul>
            </div>                
        </div>
        `
    }
    var ID = numFormularios; // Variable global
    var newForm = document.getElementById("informar-form");
    newForm.insertAdjacentHTML("beforeend", renderForm(ID))
    loadRegiones(numFormularios);
    numFormularios++;
}
function validateForm(send){
    var message = "";
    // Validar contacto:
    var nombre = document.getElementsByName("nombre")[0].value;
    var email = document.getElementsByName("email")[0].value;
    const emailRegex = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    const numberRegex = /^\+[0-9]+$/;
    const dateRegex = /^[0-9]+-0?[1-9]|[12][0-9]|3[01]-[0-9]+T[0-9]+:[0-9]+$/;
    var celular = document.getElementsByName("celular")[0].value;
    var regiones = document.getElementsByName("region");
    var comunas = document.getElementsByName("comuna");
    var sectores = document.getElementsByName("sector");
    var fechas = document.getElementsByName("dia-hora-avistamiento");
    var tipos = document.getElementsByName("tipo-avistamiento");
    var estados = document.getElementsByName("estado-avistamiento");
    
    if(nombre === ""){
        message += "Nombre vacío\n";
    }
    else if(nombre.length > 99){
        message += "Nombre muy largo\n"; 
    }
    if(email === ""){
        message += "Correo vacío\n"; 
    }
    else if(email.length > 99){
        message += "Correo muy largo\n"; 
    }
    else if(!emailRegex.test(email)){
        message += "Formato de correo incorrecto\n"; 
    }
    if(celular.length > 14){
        message += "Teléfono muy largo\n"; 
    }
    else if(!numberRegex.test(celular) && celular !== ""){
        message += "Formato de teléfono incorrecto\n"; 
    }
    for(var i = 0; i < numFormularios ; i++){
        if(regiones[i].value === ""){
            message += `Región vacía en avistamiento ${i+1}\n`
        }
        if(comunas[i].value === ""){
            message += `Comuna vacía en avistamiento ${i+1}\n`
        }
        if(sectores[i].value.length >= 100){
            message += `Sector muy largo en avistamiento ${i+1}\n`
        }
        if(fechas[i].value === ""){
            message += `Fecha vacía en avistamiento ${i+1}\n`
        }
        else if (!dateRegex.test(fechas[i].value)){
            message += `Formato de fecha incorrecta en avistamiento ${i+1}\n`
        }
        if(tipos[i].value === ""){
            message += `Tipo vacío en avistamiento ${i+1}\n`
        }
        if(estados[i].value === ""){
            message += `Estado vacío en avistamiento ${i+1}\n`
        }
        var fotos = document.getElementsByName(`foto-avistamiento-${i}`)[0];
        if(fotos.value === ""){
            message += `Ingresar al menos una foto en avistamiento ${i+1}\n`
        }
    }

    if(message!== ""){
        alert(message)
    }
    else{
        send ? showElementById("confirm-window",true) : insertForm() ;
    }
}
function pageListado(flag){
    console.log(bounds);
    if(flag){
        if(bounds[0] < bounds[1] && bounds[1] < dataAvistamientos.length) {
            bounds[0] += 5;
            bounds[1] += 5;
        }else{
            bounds[1] = dataAvistamientos.length;
            bounds[0] = bounds[1] - 5;
        }
    }else{
        if(bounds[0] < bounds[1] && bounds[0] > 0){
            bounds[0] -= 5;
            bounds[1] -= 5;
        }else{
            bounds[0] = 0;
            bounds[1] = bounds[0] + 5;
        }
    }
    console.log(bounds);
    loadListado(bounds[0],bounds[1])
}
function loadListado(lower, upper,datos=dataAvistamientos){
    var listadoElement = document.getElementById("table-body");
    var detallesElement = document.getElementById("details-container");
    var tbody = "";
    var details = "";
    var fotos = "";
    const loadFotos = (listaDeFotos) => {
        listaDeFotos.forEach(elem => {
            fotos += `<img onclick="enlargeImg('${elem}',true)" src="${elem}">`
        })
    }
    if(lower < 0) lower = 0;
    if(upper > datos.length) upper = datos.length;
    for (var i = lower; i < upper; i++){
        loadFotos(datos[i].fotos)
        details += `
                    <div hidden class="details" id="details-${i}">
                    <div style="display:flex; justify-content:space-between ">
                    <h3>Detalles</h3>
                    <button class="menu-button" onclick="renderPage('inicio')" id="inicio-btn"> Volver a inicio </button>
                    <button class="menu-button" onclick="showDetailsById('details-${i}',false)"> Cerrar </button>
                    </div>
                    Nombre: ${datos[i].nombre}
                    <br>
                    Correo: ${datos[i].email}
                    <br>
                    Teléfono: ${datos[i].celular}
                    <br>
                    Región: ${datos[i].region}
                    <br>
                    Comuna: ${datos[i].comuna}
                    <br>
                    Sector: ${datos[i].sector !== "" ? 
                        datos[i].sector : "No especificado"}
                    <br>
                    Tipo: ${datos[i].tipo}
                    <br>
                    Estado: ${datos[i].estado}
                    <br>
                    Fotos: 
                    <div style="display:flexbox; width: 200px;"> ${fotos} </div>                    
                    </div>
        `
        tbody += `
        <tr onclick="showDetailsById('details-${i}',true)">
        <td> ${datos[i].fecha} </td>
        <td> ${datos[i].comuna} </td>
        <td> ${datos[i].sector !== "" ? 
        datos[i].sector : "No especificado"} </td>
        <td> ${datos[i].nombre} </td>
        <td> ${numeroAvistamientos(datos,datos[i].nombre)} </td>
        <td> ${(datos[i].fotos).length} </td>
        </tr>`
        fotos = "";
    }
    if (listadoElement){
        detallesElement.innerHTML = `${details}`;
        listadoElement.innerHTML = `${tbody}`;
    }
}
