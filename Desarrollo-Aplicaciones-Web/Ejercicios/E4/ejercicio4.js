 /**
  * Válidar que el largo del nombre no se más de 20 carácteres y
  * solo puede contener letras
  */

function nameValidator(container) {
    var nombre  = document.getElementsByName("nombre")[0].value;
    var regex = /^[a-zA-Z]*$/;
    if (nombre.length > 20) {
        alert("Su nombre no debe exceder más de 20 carácteres ");
        return false;
    }
    if (!regex.test(nombre)) {
        alert(("Su nombre solo puede contener letras"   ));
        return false;
    }
    return true;
}

/**
 * Válidar que el campo teléfono no puede ser mayor a 10 carácteres y
 * sólo puede contener carácteres numéricos
 */

function phoneValidator(container) {
    var telefono  = document.getElementsByName("telefono")[0].value;
    var regex = /^\d+$/;
    if (telefono.length > 20) {
        alert("Su teléfono no debe exceder más de 10 carácteres ");
        return false;
    }
    if (!regex.test(telefono)) {
        alert(("Su teléfono solo puede contener carácteres numéricos"));
        return false;
    }
    return true;
}

/**
 * Cambiar foto de ingredientes de acuerdo a la selección
 */

function changeIngredients() {
    var ingrediente = document.getElementById("ingrediente").value;
    var carne = document.getElementById("carne");
    var pepperoni = document.getElementById("pepperoni");
    var aceitunas = document.getElementById("aceitunas");
    console.log(typeof ingrediente);
    if (ingrediente === '3') {
        carne.style.display = "";
        aceitunas.style.display = "none";
        pepperoni.style.display = "none";
    }
    else if (ingrediente === '1') {
        carne.style.display = "none";
        aceitunas.style.display = "none";
        pepperoni.style.display = "";
    } 
    else if (ingrediente === '2') {
        carne.style.display = "none";
        aceitunas.style.display = "";
        pepperoni.style.display = "none";
    } else {
        carne.style.display = "none";
        aceitunas.style.display = "none";
        pepperoni.style.display = "none";
    }
} 

/**
 * Validación de datos formulario.
 */

 function dataValidator() {
     container = document.getElementById("container");
     
     
     if (nameValidator(container) && phoneValidator(container)) {
         return true;
     }
     return false;

 }

 /**
  * Limpiar datos del formulario
  */

function cleanForm() {
    document.getElementById("myForm").reset();
}