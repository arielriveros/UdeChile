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
    console.log("AAAA")
    enlargeImg(src,enlarge);
    httpRequest = new XMLHttpRequest();
    if(!httpRequest){
        console.log("Error AJAX instance");
        return false;
    }
    httpRequest.open("GET","/AjaxHandler");
    httpRequest.responseType = "json";
    httpRequest.send();
    httpRequest.onreadystatechange = function(){
        if(httpRequest.readyState === XMLHttpRequest.DONE){
            var arr = [,httpRequest.response];
            for(var i = 0; i < arr.length;i++){
                let detalle = document.getElementById("details-body");
                detalle.innerHTML = '<div> PROBANDO PROBANDO </div>';
            }
        }
    }
}