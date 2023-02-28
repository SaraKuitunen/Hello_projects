// functions 
// anonymous functions do not have name and they are genrally used along with event handler 

const myButton = document.querySelector('button');

myButton.onclick = function() {
  alert('hello');
}


// pick random name

let names = ['Chris', 'Li Kang', 'Anne', 'Francesca', 'Mustafa', 'Tina', 'Bert', 'Jada']
let para = document.createElement('p');

function chooseName() {
  para.textContent = names[Math.floor(Math.random()*7)]; // indexes between 0 and 7 -> covers the whole name list
}

chooseName()

section.appendChild(para);

// updated version with function to generate random number

// Some functions require parameters to be specified when invoking them
// Parameters are sometimes called arguments, properties, or even attributes.
// Optional parameters have a default value

function random(myMin, myMax){
    return Math.floor(Math.random()*(myMax - myMin)) + myMin;
}
  
function chooseName(myArray){
    para.textContent = myArray[random(0, myArray.length -1)];
}
  
chooseName(names);



