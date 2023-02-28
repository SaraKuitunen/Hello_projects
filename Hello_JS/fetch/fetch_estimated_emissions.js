function createParagraph() {
    const myInit = {
        method: 'POST',
        headers: {
          'Authorization' : 'Bearer QF02SH33JWMMA2P418E1APXJXBF0',
          'Accept': 'application/json',
          'Content-Type' : 'application/json',
        },
        body: {
            "emission_factor": "passenger_flight-route_type_outside_uk-aircraft_type_na-distance_na-class_economy-contrails_included",
            "parameters":{
                "route": ["MLA", "IST", "HEL"]
            }
        },
        mode: 'cors',
        cache: 'default'
      };
      
    let myRequest = new Request('https://beta2.api.climatiq.io/estimate', myInit);
    
    fetch(myRequest)
    .then(function(response) {
        if (!response.ok) {
          throw new Error(`HTTP error! status: ${response.status}`);
        }
        return response.json(); // json response
    })
    .then(json => {
        // this.users = json;
        //console.log(this.users);

        this.co2e = json;
        console.log(this.co2e)

        let para = document.createElement('p'); 
        para.textContent = this.co2e;
        document.body.appendChild(para);
    })
}


const buttons = document.querySelectorAll('button');

for(let i = 0; i < buttons.length; i++){
    buttons[i].addEventListener('click', createParagraph);
}

