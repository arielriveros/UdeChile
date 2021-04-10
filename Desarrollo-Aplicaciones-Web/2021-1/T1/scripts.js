// INICIO EMULACIÓN BACKEND
var dataAvistamientos = [ 
    {nombre:"Ariel Riveros", email:"ariel@riveros.cl", celular:"+123456789", region:"Región Metropolitana de Santiago", comuna: "La Florida", sector:"Vicuña Mackenna", fecha:"2021-03-29 13:21 " , tipo: "Insecto", estado: "Vivo", fotos: ["./media/insecto1.png"]}, 
    {nombre:"Ariel Riveros", email:"ariel@riveros.cl", celular:"+123456789", region:"Región Metropolitana de Santiago", comuna: "Providencia", sector:"Plaza Italia", fecha:"2021-02-27 10:03 ", tipo: "Arácnido", estado: "Muerto", fotos: ["./media/aracnido1.png"]}, 
    {nombre:"Juan Pérez", email:"juan@perez.cl", celular:"+987654321", region:"Región Metropolitana de Santiago", comuna: "La Granja", sector:"Santa Rosa", fecha:"2021-02-02 21:31 ", tipo: "Insecto", estado: "No sé", fotos: ["./media/insecto2.png"]}, 
    {nombre:"Juana Pérez", email:"juana@perez.cl", celular:"+123456789", region:"Región Metropolitana de Santiago", comuna: "Maipú", sector:"Plaza de Maipú", fecha:"2021-01-16 00:09 ", tipo: "Miriápodo", estado: "Vivo", fotos: ["./media/miriapodo1.png"]}, 
    {nombre:"Juan Pérez", email:"juan@perez.cl", celular:"+987654321", region:"Región Metropolitana de Santiago", comuna: "Providencia", sector:"",  fecha:"2020-12-25 11:01 ", tipo: "Arácnido", estado: "No sé", fotos: ["./media/aracnido2.png"]},
    {nombre:"Ariel Riveros", email:"ariel@riveros.cl", celular:"+123456789", region:"Región Metropolitana de Santiago", comuna: "Vitacura", sector:"", fecha:"2020-10-11 18:35 ", tipo: "Insecto", estado: "Vivo", fotos: ["./media/insecto3.png", "./media/insecto4.png"]},
    {nombre:"Ariel Riveros", email:"ariel@riveros.cl", celular:"+123456789", region:"Región Metropolitana de Santiago", comuna: "Las Condes", sector:"", fecha:"2020-06-23 13:47 ", tipo: "Miriápodo", estado: "No sé", fotos: ["./media/miriapodo2.png"]} 
]

var locationData = [ { region: "Región Metropolitana de Santiago", comunas: [ "Cerrillos", "Cerro Navia", "Conchalí", "El Bosque", "Estación Central", "Huechuraba", "Independencia", "La Cisterna", "La Florida", "La Granja", "La Pintana", "La Reina", "Las Condes", "Lo Barnechea", "Lo Espejo", "Lo Prado", "Macul", "Maipú", "Ñuñoa", "Pedro Aguirre Cerda", "Peñalolén", "Providencia", "Pudahuel", "Quilicura", "Quinta Normal", "Recoleta", "Renca", "Santiago", "San Joaquín", "San Miguel", "San Ramón", "Vitacura", "Puente Alto", "Pirque", "San José de Maipo", "Colina", "Lampa", "Tiltil", "San Bernardo", "Buin", "Calera de Tango", "Paine", "Melipilla", "Alhué", "Curacaví", "María Pinto", "San Pedro", "Talagante", "El Monte", "Isla de Maipo", "Padre Hurtado", "Peñaflor" ] }, { region: "Tarapacá", comunas: [ "Iquique", "Alto Hospicio", "Pozo Almonte", "Camiña", "Colchane", "Huara", "Pica" ] }, { region: "Antofagasta", comunas: [ "Antofagasta", "Mejillones", "Sierra Gorda", "Taltal", "Calama", "Ollagüe", "San Pedro de Atacama", "Tocopilla", "María Elena" ] }, { region: "Atacama", comunas: [ "Copiapó", "Caldera", "Tierra Amarilla", "Chañaral", "Diego de Almagro", "Vallenar", "Alto del Carmen", "Freirina", "Huasco" ] }, { region: "Coquimbo", comunas: [ "La Serena", "Coquimbo", "Andacollo", "La Higuera", "Paiguano", "Vicuña", "Illapel", "Canela", "Los Vilos", "Salamanca", "Ovalle", "Combarbalá", "Monte Patria", "Punitaqui", "Río Hurtado" ] }, { region: "Valparaíso", comunas: [ "Valparaíso", "Casablanca", "Concón", "Juan Fernández", "Puchuncaví", "Quintero", "Viña del Mar", "Isla de Pascua", "Los Andes", "Calle Larga", "Rinconada", "San Esteban", "La Ligua", "Cabildo", "Papudo", "Petorca", "Zapallar", "Quillota", "Calera", "Hijuelas", "La Cruz", "Nogales", "San Antonio", "Algarrobo", "Cartagena", "El Quisco", "El Tabo", "Santo Domingo", "San Felipe", "Catemu", "Llaillay", "Panquehue", "Putaendo", "Santa María", "Quilpué", "Limache", "Olmué", "Villa Alemana" ] }, { region: "Región del Libertador Gral. Bernardo O’Higgins", comunas: [ "Rancagua", "Codegua", "Coinco", "Coltauco", "Doñihue", "Graneros", "Las Cabras", "Machalí", "Malloa", "San Francisco de Mostazal", "Olivar", "Peumo", "Pichidegua", "Quinta de Tilcoco", "Rengo", "Requínoa", "San Vicente de Tagua Tagua", "Pichilemu", "La Estrella", "Litueche", "Marchihue", "Navidad", "Paredones", "San Fernando", "Chépica", "Chimbarongo", "Lolol", "Nancagua", "Palmilla", "Peralillo", "Placilla", "Pumanque", "Santa Cruz" ] }, { region: "Región del Maule", comunas: [ "Talca", "Constitución", "Curepto", "Empedrado", "Maule", "Pelarco", "Pencahue", "Río Claro", "San Clemente", "San Rafael", "Cauquenes", "Chanco", "Pelluhue", "Curicó", "Hualañé", "Licantén", "Molina", "Rauco", "Romeral", "Sagrada Familia", "Teno", "Vichuquén", "Linares", "Colbún", "Longaví", "Parral", "Retiro", "San Javier de Loncomilla", "Villa Alegre", "Yerbas Buenas" ] }, { region: "Región del Biobío", comunas: [ "Concepción", "Coronel", "Chiguayante", "Florida", "Hualqui", "Lota", "Penco", "San Pedro de la Paz", "Santa Juana", "Talcahuano", "Tomé", "Hualpén", "Lebu", "Arauco", "Cañete", "Contulmo", "Curanilahue", "Los Álamos", "Tirúa", "Los Ángeles", "Antuco", "Cabrero", "Laja", "Mulchén", "Nacimiento", "Negrete", "Quilaco", "Quilleco", "San Rosendo", "Santa Bárbara", "Tucapel", "Yumbel", "Alto Biobío" ] }, { region: "Región de la Araucanía", comunas: [ "Temuco", "Carahue", "Cunco", "Curarrehue", "Freire", "Galvarino", "Gorbea", "Lautaro", "Loncoche", "Melipeuco", "Nueva Imperial", "Padre las Casas", "Perquenco", "Pitrufquén", "Pucón", "Saavedra", "Teodoro Schmidt", "Toltén", "Vilcún", "Villarrica", "Cholchol", "Angol", "Collipulli", "Curacautín", "Ercilla", "Lonquimay", "Los Sauces", "Lumaco", "Purén", "Renaico", "Traiguén", "Victoria" ] }, { region: "Región de Los Ríos", comunas: [ "Valdivia", "Corral", "Lanco", "Los Lagos", "Máfil", "Mariquina", "Paillaco", "Panguipulli", "La Unión", "Futrono", "Lago Ranco", "Río Bueno" ] }, { region: "Región de Los Lagos", comunas: [ "Puerto Montt", "Calbuco", "Cochamó", "Fresia", "Frutillar", "Los Muermos", "Llanquihue", "Maullín", "Puerto Varas", "Castro", "Ancud", "Chonchi", "Curaco de Vélez", "Dalcahue", "Puqueldón", "Queilén", "Quellón", "Quemchi", "Quinchao", "Osorno", "Puerto Octay", "Purranque", "Puyehue", "Río Negro", "San Juan de la Costa", "San Pablo", "Chaitén", "Futaleufú", "Hualaihué", "Palena" ] }, { region: "Región Aisén del Gral. Carlos Ibáñez del Campo", comunas: [ "Coihaique", "Lago Verde", "Aisén", "Cisnes", "Guaitecas", "Cochrane", "O’Higgins", "Tortel", "Chile Chico", "Río Ibáñez" ] }, { region: "Región de Magallanes y de la Antártica Chilena", comunas: [ "Punta Arenas", "Laguna Blanca", "Río Verde", "San Gregorio", "Cabo de Hornos (Ex Navarino)", "Antártica", "Porvenir", "Primavera", "Timaukel", "Natales", "Torres del Paine" ] }, { region: "Arica y Parinacota", comunas: ["Arica", "Camarones", "Putre", "General Lagos"] }, { region: "Región de Ñuble", comunas: [ "Cobquecura", "Coelemu", "Ninhue", "Portezuelo", "Quirihue", "Ránquil", "Treguaco", "Bulnes", "Chillán Viejo", "Chillán", "El Carmen", "Pemuco", "Pinto", "Quillón", "San Ignacio", "Yungay", "Coihueco", "Ñiquén", "San Carlos", "San Fabián", "San Nicolás" ] } ];

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

// FUNCIONES VARIAS
var numFormularios = 0;
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
function test(){
    var str = `
    Nombre: ${document.getElementsByName("nombre")[0].value}
    Correo: ${document.getElementsByName("email")[0].value}
    Celular: ${document.getElementsByName("celular")[0].value}
    `
    for(var i = 0; i < numFormularios ; i++){
        var x = "";
        var fotos = document.getElementsByName(`foto-avistamiento-${i}`);
        fotos.forEach(elem => x += `${elem.value}; `)
        str += `\n ---------------------
    Avistamiento ${i}
    Region: ${document.getElementsByName("region")[i].value}
    Comuna: ${document.getElementsByName("comuna")[i].value}
    Sector: ${document.getElementsByName("sector")[i].value}
    Fecha: ${document.getElementsByName("dia-hora-avistamiento")[i].value}
    Tipo: ${document.getElementsByName("tipo-avistamiento")[i].value}
    Estado: ${document.getElementsByName(`estado-avistamiento`)[i].value}
    Fotos:
    ${x}`}
    console.log(str);
}
function showDetailsById(id, show){
    for(var i = 0; i < document.getElementById("details-container").childElementCount; i++){
        document.getElementById(`details-${i}`).setAttribute("hidden",true);
    }
    if(show) showElementById(id,true);
}
// FIN FUNCIONES VARIAS

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
    for (var i = 0; i < 5; i++){
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
    var newFileInput = `<li class="file-list"><input type="file" name="foto-avistamiento-${ID}"></li>`
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
                    <select onchange="loadComunas(this, ${ID}); disableElementById('disable-this-${ID}')" id="region-${ID}" name="region" required></select>
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
                    <li><label> Fotografías<i class="req">*</i> <button type="button" onclick="addFileInput(${ID})"> Agregar </button> </label></li>
                    <li class="file-list"><input type="file" name="foto-avistamiento-${ID}"></li>
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
    var celular = document.getElementsByName("celular")[0].value;
    var regiones = document.getElementsByName("region");
    var comunas = document.getElementsByName("comuna");
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
    }

    if(message!== ""){
        alert(message)
    }
    else{
        send ? document.getElementsByTagName("form")[0].submit() : insertForm() ;
    }
}
function loadListado(datos){
    var listadoElement = document.getElementById("table-body");
    var detallesElement = document.getElementById("details-container");
    var tbody = "";
    var details = "";
    var fotos = "";
    const loadFotos = (listaDeFotos) => {
        listaDeFotos.forEach(elem => {
            fotos += `<img src="${elem}">`
        })
    }
    for (var i = 0; i < datos.length; i++){
        loadFotos(datos[i].fotos)
        details += `<div hidden class="details" id="details-${i}">
                    <h3>Detalles</h3>
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
                    <br><br>
                    <button onclick="showDetailsById('details-${i}',false)"> Cerrar </button>
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

window.onload = () => {
    renderPage("listado");
    insertForm();
    loadPreview(dataAvistamientos);
    loadListado(dataAvistamientos)
};