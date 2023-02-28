x = "<" + String.fromCharCode(160) + "0.001"

console.log((1 - "no data" / "no data") * 100)

console.log((1 - undefined / undefined) * 100)

v = (1 - undefined / undefined) * 100

if (isNaN(v)) {
    console.log("v is NaN")
} else {
    console.log(v)
}