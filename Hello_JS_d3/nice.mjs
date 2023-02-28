import * as d3 from "d3";

const y = d3
.scaleLinear()
.domain([0, 42]).nice()
 // .range([height - margin.bottom, margin.top])
;

console.log(y)