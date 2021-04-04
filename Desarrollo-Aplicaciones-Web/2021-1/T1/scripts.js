
// INICIO EMULACIÓN BACKEND
var previewData = [ {fecha:"2021-03-29 \r 13:21 ", comuna: "La Florida", sector:"Vicuña Mackenna", tipo: "Insecto", foto: "./media/chinita.png" }, {fecha:"2021-03-27 \n 10:03 ", comuna: "Providencia", sector:"Plaza Italia", tipo: "Arácnido", foto: "./media/arana.png" }, {fecha:"2021-03-02 \n 21:31 ", comuna: "La Granja", sector:"Santa Rosa", tipo: "Insecto", foto: "./media/palo.png" }, {fecha:"2021-02-15 \n 11:09 ", comuna: "Maipú", sector:"Plaza de Maipú", tipo: "Insecto", foto: "./media/palo.png" }, {fecha:"2021-02-15 \n 11:09 ", comuna: "Maipú", sector:"Plaza de Maipú", tipo: "Insecto", foto: "./media/palo.png" }, {fecha:"2021-02-15 \n 11:09 ", comuna: "Maipú", sector:"Plaza de Maipú", tipo: "Insecto", foto: "./media/palo.png" }, {fecha:"2021-02-15 \n 11:09 ", comuna: "Maipú", sector:"Plaza de Maipú", tipo: "Insecto", foto: "./media/palo.png" } ]
var locationData = [ { region: "Región Metropolitana de Santiago", comunas: [ "Cerrillos", "Cerro Navia", "Conchalí", "El Bosque", "Estación Central", "Huechuraba", "Independencia", "La Cisterna", "La Florida", "La Granja", "La Pintana", "La Reina", "Las Condes", "Lo Barnechea", "Lo Espejo", "Lo Prado", "Macul", "Maipú", "Ñuñoa", "Pedro Aguirre Cerda", "Peñalolén", "Providencia", "Pudahuel", "Quilicura", "Quinta Normal", "Recoleta", "Renca", "Santiago", "San Joaquín", "San Miguel", "San Ramón", "Vitacura", "Puente Alto", "Pirque", "San José de Maipo", "Colina", "Lampa", "Tiltil", "San Bernardo", "Buin", "Calera de Tango", "Paine", "Melipilla", "Alhué", "Curacaví", "María Pinto", "San Pedro", "Talagante", "El Monte", "Isla de Maipo", "Padre Hurtado", "Peñaflor" ] }, { region: "Tarapacá", comunas: [ "Iquique", "Alto Hospicio", "Pozo Almonte", "Camiña", "Colchane", "Huara", "Pica" ] }, { region: "Antofagasta", comunas: [ "Antofagasta", "Mejillones", "Sierra Gorda", "Taltal", "Calama", "Ollagüe", "San Pedro de Atacama", "Tocopilla", "María Elena" ] }, { region: "Atacama", comunas: [ "Copiapó", "Caldera", "Tierra Amarilla", "Chañaral", "Diego de Almagro", "Vallenar", "Alto del Carmen", "Freirina", "Huasco" ] }, { region: "Coquimbo", comunas: [ "La Serena", "Coquimbo", "Andacollo", "La Higuera", "Paiguano", "Vicuña", "Illapel", "Canela", "Los Vilos", "Salamanca", "Ovalle", "Combarbalá", "Monte Patria", "Punitaqui", "Río Hurtado" ] }, { region: "Valparaíso", comunas: [ "Valparaíso", "Casablanca", "Concón", "Juan Fernández", "Puchuncaví", "Quintero", "Viña del Mar", "Isla de Pascua", "Los Andes", "Calle Larga", "Rinconada", "San Esteban", "La Ligua", "Cabildo", "Papudo", "Petorca", "Zapallar", "Quillota", "Calera", "Hijuelas", "La Cruz", "Nogales", "San Antonio", "Algarrobo", "Cartagena", "El Quisco", "El Tabo", "Santo Domingo", "San Felipe", "Catemu", "Llaillay", "Panquehue", "Putaendo", "Santa María", "Quilpué", "Limache", "Olmué", "Villa Alemana" ] }, { region: "Región del Libertador Gral. Bernardo O’Higgins", comunas: [ "Rancagua", "Codegua", "Coinco", "Coltauco", "Doñihue", "Graneros", "Las Cabras", "Machalí", "Malloa", "San Francisco de Mostazal", "Olivar", "Peumo", "Pichidegua", "Quinta de Tilcoco", "Rengo", "Requínoa", "San Vicente de Tagua Tagua", "Pichilemu", "La Estrella", "Litueche", "Marchihue", "Navidad", "Paredones", "San Fernando", "Chépica", "Chimbarongo", "Lolol", "Nancagua", "Palmilla", "Peralillo", "Placilla", "Pumanque", "Santa Cruz" ] }, { region: "Región del Maule", comunas: [ "Talca", "Constitución", "Curepto", "Empedrado", "Maule", "Pelarco", "Pencahue", "Río Claro", "San Clemente", "San Rafael", "Cauquenes", "Chanco", "Pelluhue", "Curicó", "Hualañé", "Licantén", "Molina", "Rauco", "Romeral", "Sagrada Familia", "Teno", "Vichuquén", "Linares", "Colbún", "Longaví", "Parral", "Retiro", "San Javier de Loncomilla", "Villa Alegre", "Yerbas Buenas" ] }, { region: "Región del Biobío", comunas: [ "Concepción", "Coronel", "Chiguayante", "Florida", "Hualqui", "Lota", "Penco", "San Pedro de la Paz", "Santa Juana", "Talcahuano", "Tomé", "Hualpén", "Lebu", "Arauco", "Cañete", "Contulmo", "Curanilahue", "Los Álamos", "Tirúa", "Los Ángeles", "Antuco", "Cabrero", "Laja", "Mulchén", "Nacimiento", "Negrete", "Quilaco", "Quilleco", "San Rosendo", "Santa Bárbara", "Tucapel", "Yumbel", "Alto Biobío" ] }, { region: "Región de la Araucanía", comunas: [ "Temuco", "Carahue", "Cunco", "Curarrehue", "Freire", "Galvarino", "Gorbea", "Lautaro", "Loncoche", "Melipeuco", "Nueva Imperial", "Padre las Casas", "Perquenco", "Pitrufquén", "Pucón", "Saavedra", "Teodoro Schmidt", "Toltén", "Vilcún", "Villarrica", "Cholchol", "Angol", "Collipulli", "Curacautín", "Ercilla", "Lonquimay", "Los Sauces", "Lumaco", "Purén", "Renaico", "Traiguén", "Victoria" ] }, { region: "Región de Los Ríos", comunas: [ "Valdivia", "Corral", "Lanco", "Los Lagos", "Máfil", "Mariquina", "Paillaco", "Panguipulli", "La Unión", "Futrono", "Lago Ranco", "Río Bueno" ] }, { region: "Región de Los Lagos", comunas: [ "Puerto Montt", "Calbuco", "Cochamó", "Fresia", "Frutillar", "Los Muermos", "Llanquihue", "Maullín", "Puerto Varas", "Castro", "Ancud", "Chonchi", "Curaco de Vélez", "Dalcahue", "Puqueldón", "Queilén", "Quellón", "Quemchi", "Quinchao", "Osorno", "Puerto Octay", "Purranque", "Puyehue", "Río Negro", "San Juan de la Costa", "San Pablo", "Chaitén", "Futaleufú", "Hualaihué", "Palena" ] }, { region: "Región Aisén del Gral. Carlos Ibáñez del Campo", comunas: [ "Coihaique", "Lago Verde", "Aisén", "Cisnes", "Guaitecas", "Cochrane", "O’Higgins", "Tortel", "Chile Chico", "Río Ibáñez" ] }, { region: "Región de Magallanes y de la Antártica Chilena", comunas: [ "Punta Arenas", "Laguna Blanca", "Río Verde", "San Gregorio", "Cabo de Hornos (Ex Navarino)", "Antártica", "Porvenir", "Primavera", "Timaukel", "Natales", "Torres del Paine" ] }, { region: "Arica y Parinacota", comunas: ["Arica", "Camarones", "Putre", "General Lagos"] }, { region: "Región de Ñuble", comunas: [ "Cobquecura", "Coelemu", "Ninhue", "Portezuelo", "Quirihue", "Ránquil", "Treguaco", "Bulnes", "Chillán Viejo", "Chillán", "El Carmen", "Pemuco", "Pinto", "Quillón", "San Ignacio", "Yungay", "Coihueco", "Ñiquén", "San Carlos", "San Fabián", "San Nicolás" ] } ];

function addItem(itemToAdd){
    previewData.push(itemToAdd)
}

// FIN EMULACIÓN BACKEND

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

function loadPreview(){
    var previewElement = document.getElementById("previews");
    var table_head = `
    <thead>
        <tr>
            <td> Fecha-Hora </td>
            <td> Comuna </td>
            <td> Sector </td>
            <td> Tipo </td>
            <td> Foto </td>
        </tr>
    </thead>`
    var table_body = "";
    for (var i = 0; i < 5; i++){
        table_body += `
        <tr>
        <td>${previewData[i].fecha}</td>
        <td>${previewData[i].comuna}</td>
        <td>${previewData[i].sector}</td>
        <td>${previewData[i].tipo}</td>
        <td><img src="${previewData[i].foto}" alt="Fotografia del animal"></td>
        </tr>`
    }
    
    if (previewElement){
        previewElement.innerHTML = 
            `${table_head}<tbody>${table_body}</tbody>`;}
} 
function loadRegiones(){
    var formElement = document.getElementById("region");
    var options = `<option name="disable-this">Seleccione</option>`;
    locationData.forEach(elem => {
        options += `<option> ${elem.region} </option>`
    })
    if (formElement){
        formElement.innerHTML = options;
    }
}
function loadComunas(selectedRegion){
    var formElement = document.getElementById("comuna");
    var region = selectedRegion.value;
    var comunas;
    if(selectedRegion !==undefined){ 
        comunas = locationData.find(elem => elem.region === region).comunas;}
    var options = `<option name="disable-this" value="">Seleccione</option>`;
    var formElement = document.getElementById("comuna");
    comunas.forEach(elem => {
        options += `<option> ${elem} </option>`
    })
    if (formElement){
        formElement.innerHTML = options;
    }
}
function showElementById(id){
    var formElement = document.getElementById(id);
    if (formElement){
        formElement.removeAttribute("hidden")
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
var n  = 2;
function addFileInput(){
    showElementById(`foto-avistamiento-${n}`)
    n++;
}

window.onload = () => {
    loadRegiones();
    loadPreview();
};