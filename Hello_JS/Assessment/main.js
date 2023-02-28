const displayedImage = document.querySelector('.displayed-img');
const thumbBar = document.querySelector('.thumb-bar');

const btn = document.querySelector('button');
const overlay = document.querySelector('.overlay');

/* Looping through images */

let nImages = 5;
for (i = 1; i <= nImages; i++){
    const newImage = document.createElement('img');
    let fileName = 'images/pic' + i + '.jpg';
    newImage.setAttribute('src', fileName);
    thumbBar.appendChild(newImage);

    // add event handler to image so that clicking it will show it as main image
    newImage.addEventListener('click', function(){
        console.log('clicked');
        displayedImage.setAttribute('src', fileName);
    });

}

/* Wiring up the Darken/Lighten button */
btn.addEventListener('click', function(){
    if(btn.getAttribute('class') == 'dark') {
        btn.setAttribute('class', 'light'); // sets class of button to 'light'
        btn.textContent = 'Lighten'; // chages text in the button 
        overlay.style.backgroundColor = 'rgba(0,0,0,0.5)'; // sets background to be transparent 
    } else {
        btn.setAttribute('class', 'dark');
        btn.textContent = 'Darken';
        overlay.style.backgroundColor = 'rgba(0,0,0,0)';
    }

    
});

