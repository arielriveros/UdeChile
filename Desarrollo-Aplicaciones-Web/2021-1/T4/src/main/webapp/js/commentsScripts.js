function enlargeImg(src,enlarge){
    showElementById('details-img',enlarge)
    document.getElementById('details-img-photo').innerHTML =
        !enlarge ? '' :
            `
    <img src=${src} height="600" width="800"><div id="details-body"></div>
    `
}
function showElementById(id,show){
    if (document.getElementById(id)){
        show ?
            document.getElementById(id).removeAttribute("hidden")
            : document.getElementById(id).setAttribute("hidden",true)
    }
}
function loadComments(foto_id, src, enlarge){
    enlargeImg(src,enlarge);
    let detalle = document.getElementById("details-body");
    let id_foto = document.getElementById("id-foto");
    id_foto.value = foto_id;
    detalle.innerHTML = '<div>  </div>';

}