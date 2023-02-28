/* JavaScript test file */

let AR_no_data =  ["no data", "no data", "no data", "no data", "no data"]



let n_year = [1,5,10,15,20];
let AR = []

/* Compute mortality risk (absolute risk) for each follow-up time using baseline hazard, age, sex, and birth year */
for(let i = 0; i < n_year.length; i ++) {

    /*AR[i] = (1 - this.compute_S(this.age + n_year[i], sex) / this.compute_S(this.age, sex)) * 100 */
    AR[i] = NaN

    if (isNaN(AR[i])) { // some of the input values is not available
        AR[i] = "no data";
    } else if(AR[i] < 0.001) {
        AR[i] = "<" + String.fromCharCode(160) + "0.001%"; // Non-breakable space is char 160
    } else if(AR[i] > 95) {
        AR[i] = ">" + String.fromCharCode(160) + "95%";
    } else {
        AR[i] = AR[i].toFixed(3) + "%";
    }
}

console.log(AR_no_data)
console.log(AR)

AR_copy = AR
console.log(AR_copy)

console.log(AR_no_data == AR)

console.log(AR_copy == AR)

/* see difference between the arrays  */

/* AR_no_data & AR*/
let difference = AR_no_data.filter(x => !AR.includes(x));
difference = AR.filter(x => !AR_no_data.includes(x));
console.log(difference)

test = ["test"]
difference = test.filter(x => !AR.includes(x));

console.log(difference)

const allEqual = arr => arr.every( v => v === arr[0] )
console.log(allEqual( [1,1,1,1] ))  // true

let all_no_data = AR.every( v => v == "no data" )
console.log("all_no_data: ")
console.log(all_no_data)

if (AR.every( v => v == "no data" ) == true) {
    console.log("all 'no data'")
}

if (AR.every( v => v == 'no data' ) == true) {
    console.log("all 'no data'")
}

/* empty list */
let data = [];
console.log(data)

/* does not equal true */
if (data == []) {
    console.log("no data")
}

if (data.length == 0) {
    console.log("no data, array length is 0")
}

if (!data.length) {
    console.log("no data, no array length")
}

