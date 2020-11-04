function show () {
  
  window.pickupImage = function pickupImage(element) {
    const blob = element.src;

    const mainImage = document.getElementById('main-image');
    mainImage.remove();

    const mainImageNew = document.createElement('img');
    mainImageNew.setAttribute('src', blob);
    mainImageNew.setAttribute('class', 'main-image');
    mainImageNew.setAttribute('id', 'main-image');

    const mainImageBox = document.getElementById('main-image-box');
    mainImageBox.appendChild(mainImageNew);
  }
}

if (document.URL.match( /cars/ )) {
  window.addEventListener('DOMContentLoaded',show);
}