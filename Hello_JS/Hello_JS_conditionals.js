//// CONDITIONALS ////

/*
Logical operators: 
AND: && 
OR: || 
NOT: !
*/

///// if, else if, else
if (x === 5 || x === 7 && !(x === 20 || x ===10)) {
    console.log('x is 5 or 7 and not 10 or 20.');
  }
else if (x === 13) {
    console.log('x is 13.');
} 
else {
    console.log('x is something else.');
}  


///// switch ... case
/* 
take a single expression/value as an input, 
and then look through a number of choices until they find one that matches that value, 
executing the corresponding code that goes along with it.
*/ 

// pseudo code
switch (expression) {
    case choice1:
      //run this code
      break;
  
    case choice2:
      //run this code instead
      break;
  
    // include as many cases as you like
  
    default:
      //actually, just run this code. 
      // doesn't need break because is the last one
  }



  let response;
  let score = 1;
  let machineActive = true;
  
  if(machineActive) {
      // Add your code here
    switch(true){
      case (score >=0 && score <= 19):
      response = "That was a terrible score — total fail!";
      break;
  
      case (score >= 20 && score <= 39):
      response = "You know some things, but it\'s a pretty bad score. Needs improvement.";
      break;
  
      case (score >= 40 && score <= 69):
      response ="You did a passable job, not bad!";
      break;
  
      case (score >= 70 && score <= 89):
      response = "That\'s a great score, you really know your stuff.";
      break;
  
      case (score >= 90 && score <= 100):
      response = "What an amazing score! Did you cheat? Are you for real?";
      break;
  
      default:
      response = "This is not possible, an error has occurred.";
    }
  } else {
    response = 'The machine is turned off. Turn it on to process your score.';
  }
        

///// Ternary operator: "one liner if...else"

// Here we have a variable called isBirthday — if this is true, 
// we give our guest a happy birthday message; if not, we give her the standard daily greeting.

// NOTE, that in JavaScript console undefined variable name gives ReferenceError

let greeting = ( isBirthday ) ? 'Happy birthday Mrs. Smith — we hope you have a great day!' : 'Good morning Mrs. Smith.';



