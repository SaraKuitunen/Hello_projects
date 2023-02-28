// Hello JavaScript//

/*
Run these pieces of code on browser JavaScript console!

JavaScript is a scripting or programming language that
allows you to implement complex features on web pages

In html files JS can be written within <script> </script> tags */

// end lines with ;//

/********** VARIABLES **********/
// variable names are case sensitive -> use camelCase naming  //

// declaring variable and storing values with assignment operator //
let myVar; // declares a variable to be called "myVar". variable is uninitialized because it does not have a value//
myVar = 2; // initializing a variable myVar by assigns value 2 to it //
let myVar2 = 2; // declares a variable to be called "myVar2" and assigns a value 2 to it. "let myVar" is declaring the  variable and "= 2" is initializing the variable //

// show in console //
console.log(myVar2);

// two ways to declare a variable: var & let. const is for constants. //
var myName = "Beau" // can be used thoughout the whole program //
let ourName = "freeCodeCamp" // can be used within the scope where it is declared //

/* let is modern and does not have some weird charasteristics that var does
--> "use let as much as possible in your code, rather than var.
There is no reason to use var, unless you need to support old versions of Internet Explorer "
https://developer.mozilla.org/en-US/docs/Learn/JavaScript/First_steps/Variables
*/

/*
VARAIBLE TYPES:
- Booleans
- Numbers (both integers and floats are numbers)
- Strings
- Arrays
- Objects
*/

typeof myVar; // tells datatype of the variable //
///// BOOLEANS //////
// Any value that is not false, undefined, null, 0, NaN, or an empty string (''), returns true
let shoppingDone = false;
let childsAllowance;

if (shoppingDone) { // don't need to explicitly specify '=== true'
  childsAllowance = 10;
} else {
  childsAllowance = 5;
}


///// NUMBERS //////

/* TYPES of numbers:
- INTEGERS are floating-point numbers without a fraction, e.g. 3
- FLOATING POINT NUMBERS (floats) have decimal points and decimal places, e.g. 13.2 and 56.7786543.
- DOUBLEs are a specific type of floating point number that have greater precision than standard
  floating point numbers (meaning that they are accurate to a greater number of decimal places).

  --> datatype of all of these is Number. (there's also dsatataype of BigInt that is use for huge integers)

Types of number systems
- Decimal: base 10 (meaning it uses 0–9 in each column)
- Binary: 0s and 1s
- Octal: Base 8, uses 0–7 in each column
- Hexadecimal: Base 16, uses 0–9 and then a–f in each column (used in srtting colors in CSS)

  --> in general, decimal is used


/*
math operators/ Arithmetic operators:
Operator precedence in JavaScript is the same as is taught in math classes in school
NOTE that these operators work also for other datatypes than numbers!

addition: +
substarction: -
multiplication: *
division: /
remainder (modulo): %
exponent: **, e.g. 5 ** 2 (returns 25), equivalent to Math.pow(5,2);

Increment and decrement operators:
incrementing numbers: ++, e.g. num1++; is same as num1 = num1 + 1; is same as ++num1;
decrementing numbers: --
NOTE that after typing e.g. num1++; the browser returns the CURRENT value, then increments the variable. ++num1 first increments, then returns the value

Assignment operators:
basic assignment: =
addition assignment, compound assignment with augmented addition: +=, e.g. a = a + 12; is same as a += 12;
subtraction assignment, compound assignment with augmented substraction: -=
multiplication assignment, compound assignment with augmented multiplication: *=
division assignment, compound assignment with augmented division: /=

Comparison operators:
equality: ==
non-equality: !=
strict equality, also datatype need to be same: ===
strict non-equality, also datatype need to be same: !==
<
>
<=
>=
*/

/* The Number Object has many methods for manipulating numbers.
(All standard numbers seen in JavaScript are instances of Number Object) */

//toFixed() – round a number to a fixed number of decimal places//
let lotsOfDecimal = 1.766584958675746364;
lotsOfDecimal;
let twoDecimalPlaces = lotsOfDecimal.toFixed(2);
twoDecimalPlaces;
typeof twoDecimalPlaces; // note that toFixed changes datatype to string!! //

// Number() – convert string to number
myNumber = "3.4"; // coming e.g. from input field//
typeof myNumber; // "string" //
myNumber = Number(myNumber);
typeof myNumber; // "number" //

///// STRINGS /////

// Escaping literal quotes in strings //
var myStr = "use \"backslash\" to escape quotes"

// quoting strings with single quotes //
var myStr = 'using "single quotes" is also possible'

// back ticks //
var myStr = `'if "back ticks" are used, no need to escape "" or '' quotes'`

/* escape sequences in string

\' single quote
\" double quote
\\ backslash
\n new line
\r carriage return
\t tab
\b backspace
\f form feed
*/

// concatenating strings with plus operator//
var myStr = "This is the start, " + "and this is the end.";

// concatenating strings with plus equals operator//
var myStr = "This is the start, ";
myStr += "and this is the end.";

// constructing strings with variables //
var myStr = "my name is " + myName;

// appending variables to strings //
var myStr = "my name is ";
myStr += myName;

// finding length of string //
myStrLength = myStr.length;

// bracket notation to find firts/ Nth/ last character in string //
var firstLetter = myStr[0];
var secondLetter = myStr[1];
var lastChar = myStr[myStr.length -1];
var seconLastChar = myStr[myStr.length -2];


// string immutability: string cannot be modified, but new value can be assigned //
myStr[0] = "M"; // This would give error //
myStr = "My name" // this would change the string//

// converting to strings
let num = 3;
let str = num.toString();
typeof str;

let str2 = toString(num); // this will throw an error: "[object Undefined]"

// strings - test your skills 2, https://developer.mozilla.org/en-US/docs/Learn/JavaScript/First_steps/Test_your_skills:_Strings
let quote = 'I do not like green eggs and ham. I do not like them, Sam-I-Am.';
let substring = 'green eggs and ham';

// Add your code here
quoteLength = quote.length;
index = quote.indexOf(substring); // 14, substring starts at index 14
revisedQuote = quote.slice(0, index) + substring; // returns a slices of quote string from 0 to index 13 and concatenates substring
/* The slice() method returns a shallow copy of a portion of an array into
a new array object selected from start to end (end not included) where
start and end represent the index of items in that array.
The original array will not be modified.' */

// Don't edit the code below here!

section.innerHTML = ' ';
let para1 = document.createElement('p');
para1.textContent = `The quote is ${ quoteLength } characters long.`;
let para2 = document.createElement('p');
para2.textContent = revisedQuote;

section.appendChild(para1);
section.appendChild(para2);

//// TEMPLATE LITERALS
let strLiteral = 'this is string literal';
let tmplLiteral = `this is template literal`;

// see the difference between making the sentence with string literal VS template literal
let score = 9;
let highestScore = 10;
let output = 'I like the song "' + song + '". I gave it a score of ' + (score/highestScore * 100) + '%.';

output = `I like the song "${ song }". I gave it a score of ${ score/highestScore * 100 }%.`;

// complex expressions can be included inside template literals, for example:
// The fourth placeholder includes a TERNARY OPERATOR to check whether the score
// is above a certain mark and print a pass or fail message depending on the result.

// Math.round() rounds to nearest integer

let examScore = 45;
let examHighestScore = 70;
examReport = `You scored ${ examScore }/${ examHighestScore } (${ Math.round(examScore/examHighestScore*100) }%). ${ examScore >= 49 ? 'Well done, you passed!' : 'Bad luck, you didn\'t pass this time.' }`;

// Template literals respect the line breaks in the source code,
// so newline characters (\n) are no longer needed for making a new line.
let output_2 = `I scored ${ examScore }.
It's ${ Math.round(examScore/examHighestScore * 100) }%. of max points`;


///// Strings as objects: -> String methods

/*
Most things are objects in JavaScript.
A string variable is an instance of string object
--> lot of properties and methods are avialable for string variables
*/
let property1 = "length-property";
property1.length;

// last character
property1[property1.length-1];

// find a substring
property1.indexOf('-'); // 6
property1.indexOf('.'); // returns -1 because . is not found in the string

// slice
property1.slice(0,7); // slice from the first position, up to, but not including, the last position.
property1.slice(0,7);  // with only first parameter given, slice everything after the given index

let input = 'MAN675847583748sjt567654;Manchester Piccadilly'
let result = input.slice(0,3) + ': ' + input.slice(input.indexOf(';') +1); // "MAN: Manchester Piccadilly"

// toUpperCase() & toLowerCase()
// one way to make all lowercase, except for upper case first letter
let case_quote = 'I dO nOT lIke gREen eGgS anD HAM';
let fixedQuote = case_quote[0].toUpperCase() + case_quote.slice(1).toLowerCase();

// replace: Replaces first match with string or all matches with RegExp.
property1.replace("length", "replace");

// split: split string to array
let myData_cities = 'Manchester,London,Liverpool,Birmingham,Leeds,Carlisle';
let myArray_cities = myData.split(',');

///// ARRAYS. store multiple values with arrays /////

/// list-like objects

let myArray = ["John", 23];

// nested array or multidimensional array //
let nestedArray = [["John", 23], ["Peter", 52]];
let threeLayerArray = [[1,2,3], [4,5,6], [[7,8,9], 10, 11]];

// indexing //
let myData = myArray[1];
myData = threeLayerArray[0][0]; // 1 //
threeLayerArray[2][0][1] // 8

// length
threeLayerArray.length; // 3

// Manipulate arrays: //

// insert item using indexing //
myArray[1] = 24;

// join: convert array to string (opposite of split)
let newString = myArray.join(';');
newString = threeLayerArray.join(',');

// toString: convert array to string. seprator is always comma.
let otherString = myArray.toString();

// add item to end  with push() //
myArray.push(["content", "to", "end"]); // ["John", 23, ["content", "to", "end"]] //

// remove item from the end with pop()
myArray = myArray.pop();

// remove first item with shift //
myArray = myArray.shift();

// add element to the strat with unshift
myArray.unshift("Paul");


/*
///// OBJECTS //////

In programming, an object is a structure of code that models a real-life object.
You can have a simple object that represents a box and contains information about its
width, length, and height, or you could have an object that represents a person,
and contains data about their name, height, weight, what language they speak, and more.
*/

let dog = { name : 'Spot', breed : 'Dalmatian' };
dog.name
dog.owner // this would return "undefined"//


typeof dog; // "object"


/********** CONSTANTS **********/

/* Many programming languages have the concept of a constant
— a value that once declared can't be changed.
There are many reasons why you'd want to do this, from security
(if a third party script changed such values it could cause problems)
to debugging and code comprehension (it is harder to accidentally
change values that shouldn't be changed and mess things up).*/

const pi = 3.14 // immutable! //