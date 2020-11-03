function preview () {
  const ImageList = document.getElementById('image-list');
  const CarImage = document.getElementById('car-image');

  const createImageHTML = (blob) => {
  
    const imageElement = document.createElement('div');
    imageElement.setAttribute('class', 'image-element');
    let imageElementNum = document.querySelectorAll('.image-element').length;

    const blobImage = document.createElement('img');
    blobImage.setAttribute('src', blob);
    blobImage.setAttribute('class', 'preview-car-image');

    const inputHTML = document.createElement('input');
    inputHTML.setAttribute('id',`car_image_${imageElementNum}`);
    inputHTML.setAttribute('name', 'car[images][]');
    inputHTML.setAttribute('type','file');
    
    imageElement.appendChild(blobImage);
    imageElement.appendChild(inputHTML);
    ImageList.appendChild(imageElement);

    inputHTML.addEventListener('change', (e) => {
      const file = e.target.files[0];
      const blob = window.URL.createObjectURL(file);
      createImageHTML(blob)
    });
  }

  CarImage.addEventListener('change', (e) => {

    const file = e.target.files[0];
    const blob = window.URL.createObjectURL(file);
    createImageHTML(blob)
  });
}

if (document.URL.match( /new/ ) || document.URL.match( /edit/ )) {
  window.addEventListener('load',preview);
}