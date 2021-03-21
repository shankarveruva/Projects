window.onload = function (){
//    console.log("Content loaded.");
    
    var titleElement = document.getElementsByTagName("h1")[0];
        
    titleElement.onmouseover = function(){
        titleElement.innerHTML = "FIT5147";
    };
    
    titleElement.onmouseout = function() {
        titleElement.innerHTML = 'Mantis Shrimps';
    };
}