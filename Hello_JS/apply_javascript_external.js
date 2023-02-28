/* this is an external JavaScript file insterted to HTML file, so the following part is not needed
document.addEventListener("DOMContentLoaded", function() { # removed
    <this code is only needed in this file> 
}); #removed
*/ 
function createParagraph() {
    let para = document.createElement('p'); // remember to have the "document" and be careful with spelling//
    para.textContent = 'You clicked the button!';
    document.body.appendChild(para);
}
const buttons = document.querySelectorAll('button');

for(let i = 0; i < buttons.length; i++){
    buttons[i].addEventListener('click', createParagraph);
}
