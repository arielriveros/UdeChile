document.addEventListener('DOMContentLoaded', () => {
    addMarkers();
    grafico1();
    grafico2();
    grafico3();    
})

function addMarkers(){
    const tilesUrl = 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png'
    let mapa = L.map('map-container').setView([-33.41, -70.66], 10); // Pos inicial del mapa
    L.tileLayer(tilesUrl, { maxZoom: 13 }).addTo(mapa) 
    let xhr = new XMLHttpRequest();
    xhr.open('GET', 'cgi-bin/mapa.py');
    xhr.timeout = 500;
    
    xhr.onload = function (data) {
        let datatext = data.currentTarget.responseText;
        let datos = JSON.parse(datatext);
        let nombreComuna = datos.comunas
        datos.comunas.forEach(i => {
            coords[0].comunas.forEach(j => {
                if(i[0] === j.name){
                    let marker = L.marker([j.lat, j.lng],{title:`${i[1]} Fotos`}).addTo(mapa)
                }
            })
        })
    }
    xhr.send();
}

function grafico1(){
    let xhr = new XMLHttpRequest();
    xhr.open('GET', 'cgi-bin/grafico1.py');
    xhr.timeout = 500;
    xhr.onload = function (data) {
        let datatext = data.currentTarget.responseText;
        let datos = JSON.parse(datatext);
        console.log(datos)
        Highcharts.chart('grafico-avistamientos-dia', {
            chart: {
                scrollablePlotArea: {
                    minWidth: 900
                },
            },
            title: { text: 'Total de avistamientos al día' }, 
            yAxis: { title: { text: 'Avistamientos' } },
            xAxis: { title: { text: 'Fecha' }, categories: datos.categoria },
            plotOptions: {
                series: {
                    label: {
                        connectorAllowed: false
                    },
                    pointStart: 0
                }
            },
            series: [{
                name: 'Avistamientos',
                data: datos.fecha
            }],
            responsive: {
                rules: [{
                    condition: {
                        maxWidth: 600
                    }
                }]
            }
        
        });
    }
    xhr.send();
}
function grafico2(){
    let xhr = new XMLHttpRequest();
    xhr.open('GET', 'cgi-bin/grafico2.py');
    xhr.timeout = 500;
    xhr.onload = function (data) {
        let datatext = data.currentTarget.responseText;
        let datos = JSON.parse(datatext);
        Highcharts.chart('grafico-avistamientos-tipo', {
            chart: {
                plotBackgroundColor: null,
                plotBorderWidth: null,
                plotShadow: false,
                type: 'pie'
            },
            title: {
                text: 'Total de avistamientos por tipo'
            },
            tooltip: {
                pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
            },
            accessibility: {
                point: {
                    valueSuffix: '%'
                }
            },
            plotOptions: {
                pie: {
                    allowPointSelect: true,
                    cursor: 'pointer',
                    dataLabels: {
                        enabled: true,
                        format: '<b>{point.name}</b>: {point.percentage:.1f} %'
                    }
                }
            },
            series: [{
                name: 'Tipo',
                colorByPoint: true,
                data: datos
            }]
        });
    }
    xhr.send();
}
function grafico3(){
    let xhr = new XMLHttpRequest();
    xhr.open('GET', 'cgi-bin/grafico3.py');
    xhr.timeout = 500;
    xhr.onload = function (data){
        let datatext = data.currentTarget.responseText;
        let datos = JSON.parse(datatext);
        Highcharts.chart('grafico-estados-mes', {
            chart: {
                type: 'column'
            },
            title: {
                text: 'Estado de avistamiento al mes'
            },
            xAxis: {
                categories: [
                    'Ene',
                    'Feb',
                    'Mar',
                    'Abr',
                    'May',
                    'Jun',
                    'Jul',
                    'Ago',
                    'Sep',
                    'Oct',
                    'Nov',
                    'Dic'
                ],
                crosshair: true
            },
            yAxis: {
                min: 0,
                title: {
                    text: 'Cantidad de Avistamientos'
                }
            },
            tooltip: {
                headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
                pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
                    '<td style="padding:0"><b>{point.y:.1f}</b></td></tr>',
                footerFormat: '</table>',
                shared: true,
                useHTML: true
            },
            plotOptions: {
                column: {
                    pointPadding: 0.2,
                    borderWidth: 0
                }
            },
            series: datos
        });
    }
    xhr.send();
    // [{"vivo":[0, 0, 0, 2, 0, 0, 9, 0, 0, 0, 0, 0]}, {"muerto":[0, 0, 1, 0, 0, 0, 8, 0, 0, 0, 0, 0]}, {"no se":[0, 1, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0]}]
}

var coords = [{ "comunas": [{ "name": "Santiago", "lng": "-70.6666667", "lat": "-33.4500000" }, { "name": "Alhue", "lng": "-71.1164", "lat": "-34.0278" }, { "name": "Cerro Navia", "lng": "-70.7166667", "lat": "-33.4166667" }, { "name": "El Bosque", "lng": "-70.7000000", "lat": "-33.5666667" }, { "name": "Huechuraba", "lng": "-70.6666667", "lat": "-33.3500000" }, { "name": "La Cisterna", "lng": "-70.6833333", "lat": "-33.5500000" }, { "name": "La Granja", "lng": "-70.5833333", "lat": "-33.5833333" }, { "name": "La Reina", "lng": "-70.5500000", "lat": "-33.4500000" }, { "name": "Lo Barnechea", "lng": "-70.5166667", "lat": "-33.3500000" }, { "name": "Lo Prado", "lng": "-70.7166667", "lat": "-33.4333333" }, { "name": "Maipu", "lng": "-70.7666667", "lat": "-33.5166667" }, { "name": "Pedro Aguirre Cerda", "lng": "-70.6780860", "lat": "-33.4924550" }, { "name": "Providencia", "lng": "-70.6166667", "lat": "-33.4333333" }, { "name": "Quilicura", "lng": "-70.7500000", "lat": "-33.3666667" }, { "name": "Recoleta", "lng": "-33.4081480", "lat": "-70.6391920" }, { "name": "San Joaquin", "lng": "-70.6166667", "lat": "-33.5000000" }, { "name": "San Ramon", "lng": "-70.5000000", "lat": "-33.4500000" }, { "name": "Puente Alto", "lng": "-70.5833333", "lat": "-33.6166667" }, { "name": "Padre Hurtado", "lng": "-70.8333333", "lat": "-33.5666667" }, { "name": "El Monte", "lng": "-71.0166667", "lat": "-33.6833333" }, { "name": "San Pedro", "lng": "-71.4666667", "lat": "-33.9000000" }, { "name": "Curacavi", "lng": "-71.1500000", "lat": "-33.4000000" }, { "name": "Melipilla", "lng": "-71.2166667", "lat": "-33.7000000" }, { "name": "Calera de Tango", "lng": "-70.8166667", "lat": "-33.6500000" }, { "name": "San Bernardo", "lng": "-70.7166667", "lat": "-33.6000000" }, { "name": "Lampa", "lng": "-70.9000000", "lat": "-33.2833333" }, { "name": "San Jose de Maipo", "lng": "-70.3666667", "lat": "-33.6333333" }, { "name": "Peñaflor", "lng": "-70.9166667", "lat": "-33.6166667" }, { "name": "Isla de Maipo", "lng": "-70.9000000", "lat": "-33.7500000" }, { "name": "Talagante", "lng": "-70.9333333", "lat": "-33.6666667" }, { "name": "Maria Pinto", "lng": "-71.1333333", "lat": "-33.5333333" }, { "name": "Paine", "lng": "-70.7500000", "lat": "-33.8166667" }, { "name": "Buin", "lng": "-70.7500000", "lat": "-33.7333333" }, { "name": "Tiltil", "lng": "-70.9333333", "lat": "-33.0833333" }, { "name": "Colina", "lng": "-70.6833333", "lat": "-33.2000000" }, { "name": "Pirque", "lng": "-70.5500000", "lat": "-33.6333333" }, { "name": "Vitacura", "lng": "-70.6000000", "lat": "-33.4000000" }, { "name": "San Miguel", "lng": "-70.6666667", "lat": "-33.5000000" }, { "name": "Renca", "lng": "-70.7333333", "lat": "-33.4000000" }, { "name": "Quinta Normal", "lng": "-70.7000000", "lat": "-33.4500000" }, { "name": "Pudahuel", "lng": "-70.7166667", "lat": "-33.4333333" }, { "name": "Peñalolen", "lng": "-70.5333333", "lat": "-33.4833333" }, { "name": "Ñuñoa", "lng": "-70.6000000", "lat": "-33.4666667" }, { "name": "Macul", "lng": "-70.5666667", "lat": "-33.5000000" }, { "name": "Lo Espejo", "lng": "-70.7166667", "lat": "-33.5333333" }, { "name": "Las Condes", "lng": "-70.5833333", "lat": "-33.4166667" }, { "name": "La Pintana", "lng": "-70.6166667", "lat": "-33.5833333" }, { "name": "La Florida", "lng": "-70.5666667", "lat": "-33.5500000" }, { "name": "Independencia", "lng": "-70.6549320", "lat": "-33.4219880" }, { "name": "Estacion Central", "lng": "-70.7029760", "lat": "-33.4633150" }, { "name": "Conchali", "lng": "-70.6166667", "lat": "-33.3500000" }, { "name": "Cerrillos", "lng": "-70.7000000", "lat": "-33.4833333" }, { "name": "Arica", "lng": "-70.3144444", "lat": "-18.4750000" }, { "name": "Camarones", "lng": "-69.8666667", "lat": "-19.0166667" }, { "name": "Putre", "lng": "-69.5977778", "lat": "-18.1916667" }, { "name": "Gral. Lagos", "lng": "-69.5000000", "lat": "-17.5666667" }, { "name": "Iquique", "lng": "-70.1666667", "lat": "-20.2166667" }, { "name": "Alto Hospicio", "lng": "-70.1166667", "lat": "-20.2500000" }, { "name": "Pozo Almonte", "lng": "-69.7833333", "lat": "-20.2666667" }, { "name": "Camiña", "lng": "-69.4166667", "lat": "-19.3000000" }, { "name": "Colchane", "lng": "-68.6166667", "lat": "-19.2666667" }, { "name": "Huara", "lng": "-69.7666667", "lat": "-19.9666667" }, { "name": "Pica", "lng": "-69.3333333", "lat": "-20.5000000" }, { "name": "Antofagasta", "lng": "-70.4000000", "lat": "-23.6333333" }, { "name": "Mejillones", "lng": "-70.4500000", "lat": "-23.1000000" }, { "name": "Sierra Gorda", "lng": "-69.3166667", "lat": "-22.8833333" }, { "name": "Taltal", "lng": "-69.7666667", "lat": "-25.2833333" }, { "name": "Calama", "lng": "-68.9166667", "lat": "-22.4666667" }, { "name": "Ollague", "lng": "-68.2666667", "lat": "-21.2166667" }, { "name": "San Pedro Atacama", "lng": "-68.2166667", "lat": "-22.9166667" }, { "name": "Maria Elena", "lng": "-69.6666667", "lat": "-22.3500000" }, { "name": "Tocopilla", "lng": "-70.2000000", "lat": "-22.0666667" }, { "name": "Copiapo", "lng": "-70.3166667", "lat": "-27.3666667" }, { "name": "Caldera", "lng": "-70.8166667", "lat": "-27.0666667" }, { "name": "Tierra Amarilla", "lng": "-70.2666667", "lat": "-27.4666667" }, { "name": "Chañaral", "lng": "-70.6000000", "lat": "-26.3333333" }, { "name": "Diego de Almagro", "lng": "-70.0500000", "lat": "-26.3666667" }, { "name": "Vallenar", "lng": "-70.7500000", "lat": "-28.5666667" }, { "name": "Alto del Carmen", "lng": "-70.4622222", "lat": "-28.9336111" }, { "name": "Freirina", "lng": "-71.0666667", "lat": "-28.5000000" }, { "name": "Huasco", "lng": "-71.2166667", "lat": "-28.4500000" }, { "name": "Rio Hurtado", "lng": "-70.7000000", "lat": "-30.2666667" }, { "name": "Monte Patria", "lng": "-70.9333333", "lat": "-30.6833333" }, { "name": "Ovalle", "lng": "-71.2000000", "lat": "-30.5833333" }, { "name": "Los Vilos", "lng": "-71.5166667", "lat": "-31.9000000" }, { "name": "Illapel", "lng": "-71.1500000", "lat": "-31.6166667" }, { "name": "Paihuano", "lng": "-70.5166667", "lat": "-30.0166667" }, { "name": "Andacollo", "lng": "-71.0833333", "lat": "-30.2166667" }, { "name": "La Serena", "lng": "-71.2500000", "lat": "-29.9000000" }, { "name": "Punitaqui", "lng": "-71.2666667", "lat": "-30.9000000" }, { "name": "Combarbala", "lng": "-71.0500000", "lat": "-31.1666667" }, { "name": "Salamanca", "lng": "-70.9666667", "lat": "-31.7666667" }, { "name": "Canela", "lng": "-71.4500000", "lat": "-31.4000000" }, { "name": "Vicuña", "lng": "-70.7000000", "lat": "-30.0166667" }, { "name": "La Higuera", "lng": "-71.2666667", "lat": "-29.5000000" }, { "name": "Coquimbo", "lng": "-71.3333333", "lat": "-29.9500000" }, { "name": "Valparaiso", "lng": "-71.6163889", "lat": "-33.0458333" }, { "name": "Concon", "lng": "-71.5166667", "lat": "-32.9166667" }, { "name": "Puchuncavi", "lng": "-71.4166667", "lat": "-32.7333333" }, { "name": "Los Andes", "lng": "-70.6166667", "lat": "-32.8166667" }, { "name": "Viña del Mar", "lng": "-71.5333333", "lat": "-33.0333333" }, { "name": "Rinconada", "lng": "-70.7000000", "lat": "-32.8333333" }, { "name": "La Ligua", "lng": "-71.2166667", "lat": "-32.4500000" }, { "name": "Papudo", "lng": "-71.4500000", "lat": "-32.5166667" }, { "name": "Zapallar", "lng": "-71.4666667", "lat": "-32.5333333" }, { "name": "La Calera", "lng": "-71.2166667", "lat": "-32.7833333" }, { "name": "San Antonio", "lng": "-71.6166667", "lat": "-33.6000000" }, { "name": "Cartagena", "lng": "-71.6000000", "lat": "-33.5500000" }, { "name": "El Tabo", "lng": "-71.6666667", "lat": "-33.4500000" }, { "name": "San Felipe", "lng": "-70.7333333", "lat": "-32.7500000" }, { "name": "Llay Llay", "lng": "-70.9666667", "lat": "-32.8500000" }, { "name": "La Cruz", "lng": "-71.2333333", "lat": "-32.8166667" }, { "name": "Villa Alemana", "lng": "-71.3666667", "lat": "-33.0500000" }, { "name": "Limache", "lng": "-71.2833333", "lat": "-32.9833333" }, { "name": "Putaendo", "lng": "-70.7333333", "lat": "-32.6333333" }, { "name": "Olmue", "lng": "-71.2000000", "lat": "-33.0000000" }, { "name": "Quilpue", "lng": "-71.4500000", "lat": "-33.0500000" }, { "name": "Santa Maria", "lng": "-70.6666667", "lat": "-32.7500000" }, { "name": "Panquehue", "lng": "-70.8333333", "lat": "-32.8000000" }, { "name": "Catemu", "lng": "-71.0333333", "lat": "-32.6333333" }, { "name": "Santo Domingo", "lng": "-71.6500000", "lat": "-33.6333333" }, { "name": "El Quisco", "lng": "-71.7000000", "lat": "-33.4000000" }, { "name": "Algarrobo", "lng": "-71.6927778", "lat": "-33.3911111" }, { "name": "Nogales", "lng": "-71.2333333", "lat": "-32.7166667" }, { "name": "Hijuelas", "lng": "-71.1666667", "lat": "-32.8000000" }, { "name": "Quillota", "lng": "-71.2666667", "lat": "-32.8833333" }, { "name": "Petorca", "lng": "-70.9333333", "lat": "-32.2500000" }, { "name": "Cabildo", "lng": "-71.1333333", "lat": "-32.4166667" }, { "name": "San Esteban", "lng": "-70.5833333", "lat": "-32.8000000" }, { "name": "Calle Larga", "lng": "-70.6333333", "lat": "-32.8500000" }, { "name": "Isla de Pascua", "lng": "-109.3750000", "lat": "-27.0833333" }, { "name": "Quintero", "lng": "-71.5333333", "lat": "-32.7833333" }, { "name": "Juan Fernandez", "lng": "-78.8666667", "lat": "-33.6166667" }, { "name": "Casablanca", "lng": "-71.4166667", "lat": "-33.3166667" }, { "name": "Rancagua", "lng": "-70.7397222", "lat": "-34.1652778" }, { "name": "Coinco", "lng": "-70.9666667", "lat": "-34.2666667" }, { "name": "Doñihue", "lng": "-70.9666667", "lat": "-34.2333333" }, { "name": "Las Cabras", "lng": "-71.3166667", "lat": "-34.3000000" }, { "name": "Malloa", "lng": "-70.9500000", "lat": "-34.4500000" }, { "name": "Olivar", "lng": "-70.8175000", "lat": "-34.2100000" }, { "name": "San Vicente", "lng": "-71.1333333", "lat": "-34.5000000" }, { "name": "Marchigue", "lng": "-71.6333333", "lat": "-34.4000000" }, { "name": "Paredones", "lng": "-71.1666667", "lat": "-34.7833333" }, { "name": "Chepica", "lng": "-71.2833333", "lat": "-34.7333333" }, { "name": "Lolol", "lng": "-71.6447222", "lat": "-34.7286111" }, { "name": "Palmilla", "lng": "-71.3666667", "lat": "-34.6000000" }, { "name": "Santa Cruz", "lng": "-71.3666667", "lat": "-34.6333333" }, { "name": "Placilla", "lng": "-71.1166667", "lat": "-34.6333333" }, { "name": "La Estrella", "lng": "-71.6666667", "lat": "-34.2000000" }, { "name": "Rengo", "lng": "-70.8666667", "lat": "-34.4166667" }, { "name": "Pichidegua", "lng": "-71.3000000", "lat": "-34.3500000" }, { "name": "Pumanque", "lng": "-71.6666667", "lat": "-34.6000000" }, { "name": "Peralillo", "lng": "-71.4833333", "lat": "-34.4833333" }, { "name": "Nancagua", "lng": "-71.2166667", "lat": "-34.6666667" }, { "name": "Chimbarongo", "lng": "-71.0500000", "lat": "-34.7000000" }, { "name": "San Fernando", "lng": "-70.9666667", "lat": "-34.5833333" }, { "name": "Navidad", "lng": "-71.8333333", "lat": "-33.9333333" }, { "name": "Litueche", "lng": "-71.7333333", "lat": "-34.1166667" }, { "name": "Pichilemu", "lng": "-72.0000000", "lat": "-34.3833333" }, { "name": "Requinoa", "lng": "-70.8333333", "lat": "-34.2833333" }, { "name": "Quinta Tilcoco", "lng": "-70.9833333", "lat": "-34.3500000" }, { "name": "Peumo", "lng": "-71.1666667", "lat": "-34.4000000" }, { "name": "Mostazal", "lng": "-70.7000000", "lat": "-33.9833333" }, { "name": "Machali", "lng": "-70.6511111", "lat": "-34.1825000" }, { "name": "Graneros", "lng": "-70.7266667", "lat": "-34.0647222" }, { "name": "Coltauco", "lng": "-71.0857230", "lat": "34.2872290" }, { "name": "Codegua", "lng": "-70.6666667", "lat": "-34.0333333" }, { "name": "Talca", "lng": "-71.6666667", "lat": "-35.4333333" }, { "name": "Curepto", "lng": "-72.0166667", "lat": "-35.0833333" }, { "name": "Maule", "lng": "-71.7000000", "lat": "-35.5333333" }, { "name": "Pencahue", "lng": "-71.8166667", "lat": "-35.4000000" }, { "name": "San Clemente", "lng": "-71.4833333", "lat": "-35.5500000" }, { "name": "Cauquenes", "lng": "-72.3500000", "lat": "-35.9666667" }, { "name": "Pelluhue", "lng": "-72.6333333", "lat": "-35.8333333" }, { "name": "Hualañe", "lng": "-71.8047222", "lat": "-34.9766667" }, { "name": "Molina", "lng": "-71.2833333", "lat": "-34.1166667" }, { "name": "Romeral", "lng": "-71.1333333", "lat": "-34.9666667" }, { "name": "Teno", "lng": "-71.1833333", "lat": "-34.8666667" }, { "name": "Linares", "lng": "-71.6000000", "lat": "-35.8500000" }, { "name": "Longavi", "lng": "-71.6833333", "lat": "-35.9666667" }, { "name": "Retiro", "lng": "-71.7666667", "lat": "-36.0500000" }, { "name": "Villa Alegre", "lng": "-71.7500000", "lat": "-35.6666667" }, { "name": "Constitucion", "lng": "-72.4166667", "lat": "-35.3333333" }, { "name": "Empedrado", "lng": "-72.2833333", "lat": "-35.6000000" }, { "name": "Pelarco", "lng": "-71.4500000", "lat": "-35.3833333" }, { "name": "Rio Claro", "lng": "-71.2666667", "lat": "-35.2833333" }, { "name": "San Rafael", "lng": "-71.5333333", "lat": "-35.3166667" }, { "name": "Curico", "lng": "-71.2333333", "lat": "-34.9833333" }, { "name": "Chanco", "lng": "-72.5333333", "lat": "-35.7333333" }, { "name": "Licanten", "lng": "-72.0000000", "lat": "-34.9833333" }, { "name": "Rauco", "lng": "-71.3166667", "lat": "-34.9333333" }, { "name": "Sagrada Familia", "lng": "-71.3833333", "lat": "-35.0000000" }, { "name": "Vichuquen", "lng": "-72.0000000", "lat": "-34.8833333" }, { "name": "Colbun", "lng": "-71.4166667", "lat": "-35.7000000" }, { "name": "Parral", "lng": "-71.8333333", "lat": "-36.1500000" }, { "name": "San Javier", "lng": "-71.7500000", "lat": "-35.6000000" }, { "name": "Yerbas Buenas", "lng": "-71.5833333", "lat": "-35.7500000" }, { "name": "Concepcion", "lng": "-73.0500000", "lat": "-36.8333333" }, { "name": "Chiguayante", "lng": "-73.0166667", "lat": "-36.9166667" }, { "name": "Hualqui", "lng": "-72.9333333", "lat": "-36.9666667" }, { "name": "Penco", "lng": "-72.9833333", "lat": "-36.7333333" }, { "name": "Santa Juana", "lng": "-72.9333333", "lat": "-37.1666667" }, { "name": "Tome", "lng": "-72.9500000", "lat": "-36.6166667" }, { "name": "Lebu", "lng": "-73.6500000", "lat": "-37.6166667" }, { "name": "Cañete", "lng": "-73.3833333", "lat": "-37.8000000" }, { "name": "Curanilahue", "lng": "-73.3500000", "lat": "-37.4666667" }, { "name": "Tirua", "lng": "-73.5000000", "lat": "-38.3333333" }, { "name": "Antuco", "lng": "-71.6833333", "lat": "-37.3333333" }, { "name": "Laja", "lng": "-72.7000000", "lat": "-37.2666667" }, { "name": "Nacimiento", "lng": "-72.6666667", "lat": "-37.5000000" }, { "name": "Quilaco", "lng": "-71.9833333", "lat": "-37.6666667" }, { "name": "San Rosendo", "lng": "-72.7166667", "lat": "-37.2666667" }, { "name": "Tucapel", "lng": "-71.9500000", "lat": "-37.2833333" }, { "name": "Alto Bio Bio", "lng": "-71.3166667", "lat": "-38.0500000" }, { "name": "Bulnes", "lng": "-72.3014290", "lat": "-36.7419870" }, { "name": "Coelemu", "lng": "-72.7000000", "lat": "-36.4833333" }, { "name": "Chillan Viejo", "lng": "-72.1333333", "lat": "-36.6166667" }, { "name": "Ninhue", "lng": "-72.4000000", "lat": "-36.4000000" }, { "name": "Pemuco", "lng": "-72.1000000", "lat": "-36.9666667" }, { "name": "Portezuelo", "lng": "-72.4333333", "lat": "-36.5333333" }, { "name": "Quirihue", "lng": "-72.5333333", "lat": "-36.2833333" }, { "name": "Trehuaco", "lng": "-72.6666667", "lat": "-36.4333333" }, { "name": "San Ignacio", "lng": "-72.0333333", "lat": "-36.8000000" }, { "name": "San Carlos", "lng": "-71.9580556", "lat": "-36.4247222" }, { "name": "Yungay", "lng": "-72.0166667", "lat": "-37.1166667" }, { "name": "San Nicolas", "lng": "-72.2166667", "lat": "-36.5000000" }, { "name": "San Fabian", "lng": "-71.5500000", "lat": "-36.5500000" }, { "name": "Ranquil", "lng": "-72.5500000", "lat": "-36.6500000" }, { "name": "Quillon", "lng": "-72.4666667", "lat": "-36.7333333" }, { "name": "Pinto", "lng": "-71.9000000", "lat": "-36.7000000" }, { "name": "Ñiquen", "lng": "-71.9000000", "lat": "-36.3000000" }, { "name": "El Carmen", "lng": "-72.0323130", "lat": "-36.8994440" }, { "name": "Coihueco", "lng": "-71.8333333", "lat": "-36.6166667" }, { "name": "Cobquecura", "lng": "-72.7833333", "lat": "-36.1333333" }, { "name": "Chillan", "lng": "-72.1166667", "lat": "-36.6000000" }, { "name": "Yumbel", "lng": "-72.5333333", "lat": "-37.1333333" }, { "name": "Santa Barbara", "lng": "-72.0166667", "lat": "-37.6666667" }, { "name": "Quilaco", "lng": "-71.9666667", "lat": "-37.4666667" }, { "name": "Negrete", "lng": "-72.5166667", "lat": "-37.5833333" }, { "name": "Mulchen", "lng": "-72.2333333", "lat": "-37.7166667" }, { "name": "Cabrero", "lng": "-72.4000000", "lat": "-37.0333333" }, { "name": "Los Angeles", "lng": "-72.3500000", "lat": "-37.4666667" }, { "name": "Los Alamos", "lng": "-73.4666667", "lat": "-37.6166667" }, { "name": "Contulmo", "lng": "-73.2333333", "lat": "-38.0000000" }, { "name": "Arauco", "lng": "-73.3166667", "lat": "-37.2500000" }, { "name": "Hualpen", "lng": "-73.0833333", "lat": "-36.7833333" }, { "name": "Talcahuano", "lng": "-73.1166667", "lat": "-36.7166667" }, { "name": "San Pedro de la Paz", "lng": "-73.1166667", "lat": "-36.8333333" }, { "name": "Lota", "lng": "-73.1560560", "lat": "-37.0870730" }, { "name": "Florida", "lng": "-72.6666667", "lat": "-36.8166667" }, { "name": "Coronel", "lng": "-73.1333333", "lat": "-37.0166667" }, { "name": "Temuco", "lng": "-72.6666667", "lat": "-38.7500000" }, { "name": "Cunco", "lng": "-72.0333333", "lat": "-38.9166667" }, { "name": "Freire", "lng": "-72.6333333", "lat": "-38.9500000" }, { "name": "Gorbea", "lng": "-72.6833333", "lat": "-39.1000000" }, { "name": "Loncoche", "lng": "-72.6333333", "lat": "-39.3666667" }, { "name": "Nueva Imperial", "lng": "-72.9500000", "lat": "-38.7333333" }, { "name": "Perquenco", "lng": "-72.3833333", "lat": "-38.4166667" }, { "name": "Pucon", "lng": "-71.9666667", "lat": "-39.2666667" }, { "name": "Teodoro Schmidt", "lng": "-73.0500000", "lat": "-38.9666667" }, { "name": "Vilcun", "lng": "-72.3794444", "lat": "-39.1183333" }, { "name": "Cholchol", "lng": "-72.8500000", "lat": "-38.6000000" }, { "name": "Collipulli", "lng": "-72.4333333", "lat": "-37.9500000" }, { "name": "Ercilla", "lng": "-72.3833333", "lat": "-38.0500000" }, { "name": "Los Sauces", "lng": "-72.8333333", "lat": "-37.9666667" }, { "name": "Puren", "lng": "-73.0833333", "lat": "-38.0166667" }, { "name": "Traiguen", "lng": "-72.6833333", "lat": "-38.2500000" }, { "name": "Carahue", "lng": "-73.1666667", "lat": "-38.7000000" }, { "name": "Curarrehue", "lng": "-71.5833333", "lat": "-39.3500000" }, { "name": "Carahue", "lng": "-73.161.01", "lat": "-38.71122" }, { "name": "Galvarino", "lng": "-72.7833333", "lat": "-38.4000000" }, { "name": "Lautaro", "lng": "-72.4350000", "lat": "-38.5291667" }, { "name": "Padre Las Casas", "lng": "-72.6000000", "lat": "-38.7666667" }, { "name": "Pitrufquen", "lng": "-72.6500000", "lat": "-38.9833333" }, { "name": "Tolten", "lng": "-73.2333333", "lat": "-39.2166667" }, { "name": "Villarrica", "lng": "-72.2166667", "lat": "-39.2666667" }, { "name": "Angol", "lng": "-72.7166667", "lat": "-37.8000000" }, { "name": "Curacautin", "lng": "-71.8833333", "lat": "-38.4333333" }, { "name": "Lonquimay", "lng": "-71.2333333", "lat": "-38.4333333" }, { "name": "Lumaco", "lng": "-72.9166667", "lat": "-38.1500000" }, { "name": "Renaico", "lng": "-72.5833333", "lat": "-37.6666667" }, { "name": "Victoria", "lng": "-72.3333333", "lat": "-38.2166667" }, { "name": "Puerto Saavedra", "lng": "-73.4000000", "lat": "-38.7833333" }, { "name": "Melipeuco", "lng": "-71.7000000", "lat": "-38.8500000" }, { "name": "Valdivia", "lng": "-73.2333333", "lat": "-39.8000000" }, { "name": "Corral", "lng": "-73.4333333", "lat": "-39.8666667" }, { "name": "Lanco", "lng": "-72.7666667", "lat": "-39.4333333" }, { "name": "Los Lagos", "lng": "-72.8333333", "lat": "-39.8500000" }, { "name": "Mafil", "lng": "-72.9500000", "lat": "-39.6500000" }, { "name": "Mariquina", "lng": "-72.9666667", "lat": "-39.5166667" }, { "name": "Paillaco", "lng": "-72.8833333", "lat": "-40.0666667" }, { "name": "Panguipulli", "lng": "-72.3333333", "lat": "-39.6333333" }, { "name": "La Union", "lng": "-73.0833333", "lat": "-40.2833333" }, { "name": "Futrono", "lng": "-72.4000000", "lat": "-40.1333333" }, { "name": "Lago Ranco", "lng": "-72.5000000", "lat": "-40.3166667" }, { "name": "Rio Bueno", "lng": "-72.9666667", "lat": "-40.3166667" }, { "name": "Puerto Montt", "lng": "-72.9333333", "lat": "-41.4666667" }, { "name": "Cochamo", "lng": "-72.3166667", "lat": "-41.5000000" }, { "name": "Frutillar", "lng": "-73.1000000", "lat": "-41.1166667" }, { "name": "Puerto Varas", "lng": "-72.9833333", "lat": "-41.3166667" }, { "name": "Ancud", "lng": "-73.8333333", "lat": "-41.8666667" }, { "name": "Curaco de Velez", "lng": "-73.5833333", "lat": "-42.4333333" }, { "name": "Puqueldon", "lng": "-73.6333333", "lat": "-42.5833333" }, { "name": "Quellon", "lng": "-73.6000000", "lat": "-43.1000000" }, { "name": "Quinchao", "lng": "-73.4166667", "lat": "-42.5333333" }, { "name": "Puerto Octay", "lng": "-72.9000000", "lat": "-40.9666667" }, { "name": "Puyehue", "lng": "-72.6166667", "lat": "-40.6666667" }, { "name": "Hualaihue", "lng": "-72.6833333", "lat": "-42.0166667" }, { "name": "Chaiten", "lng": "-72.7088889", "lat": "-42.9194444" }, { "name": "San Juan", "lng": "-73.4000000", "lat": "-40.5166667" }, { "name": "Llanquihue", "lng": "-73.0166667", "lat": "-41.2500000" }, { "name": "Calbuco", "lng": "-73.1333333", "lat": "-41.7666667" }, { "name": "Fresia", "lng": "-73.4500000", "lat": "-41.1500000" }, { "name": "Los Muermos", "lng": "-73.4833333", "lat": "-41.4000000" }, { "name": "Maullin", "lng": "-73.6000000", "lat": "-41.6166667" }, { "name": "Castro", "lng": "-73.8000000", "lat": "-42.4666667" }, { "name": "Queilen", "lng": "-73.4666667", "lat": "-42.8666667" }, { "name": "Quemchi", "lng": "-73.5166667", "lat": "-42.1333333" }, { "name": "Osorno", "lng": "-73.1500000", "lat": "-40.5666667" }, { "name": "Purranque", "lng": "-73.1666667", "lat": "-40.9166667" }, { "name": "Rio Negro", "lng": "-73.2333333", "lat": "-40.7833333" }, { "name": "San Pablo", "lng": "-73.0166667", "lat": "-40.4000000" }, { "name": "Futaleufu", "lng": "-71.8500000", "lat": "-43.1666667" }, { "name": "Palena", "lng": "-71.8000000", "lat": "-43.6166667" }, { "name": "Dalcahue", "lng": "-73.7000000", "lat": "-42.3666667" }, { "name": "Chonchi", "lng": "-73.8166667", "lat": "-42.6166667" }, { "name": "Coyhaique", "lng": "-72.0666667", "lat": "-45.5666667" }, { "name": "Aysen", "lng": "-72.7000000", "lat": "-45.4000000" }, { "name": "Guaitecas", "lng": "-73.7333333", "lat": "-43.8833333" }, { "name": "O'Higgins", "lng": "-72.5666667", "lat": "-48.4666667" }, { "name": "Chile Chico", "lng": "-71.7333333", "lat": "-46.5500000" }, { "name": "Lago Verde", "lng": "-71.8333333", "lat": "-44.2333333" }, { "name": "Cisnes", "lng": "-72.7000000", "lat": "-44.7500000" }, { "name": "Cochrane", "lng": "-72.5500000", "lat": "-47.2666667" }, { "name": "Tortel", "lng": "-73.5666667", "lat": "-47.8333333" }, { "name": "Rio Ibañez", "lng": "-71.9333333", "lat": "-46.3000000" }, { "name": "Punta Arenas", "lng": "-70.9336111", "lat": "-53.1669444" }, { "name": "Rio Verde", "lng": "-71.4833333", "lat": "-52.6500000" }, { "name": "Porvenir", "lng": "-70.3666667", "lat": "-53.3000000" }, { "name": "Timaukel", "lng": "-69.9000000", "lat": "-53.6666667" }, { "name": "Torres del Paine", "lng": "-72.3500000", "lat": "-51.2666667" }, { "name": "Puerto Natales", "lng": "-72.5166667", "lat": "-51.7333333" }, { "name": "Primavera", "lng": "-69.2500000", "lat": "-52.7166667" }, { "name": "Antartica", "lng": "-71.5000000", "lat": "-75.0000000" }, { "name": "San Gregorio", "lng": "-69.6833333", "lat": "-52.3166667" }, { "name": "Laguna Blanca", "lng": "-71.9166667", "lat": "-52.2500000" }]}];