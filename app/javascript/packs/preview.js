function preview () {
  const ImageList = document.getElementById('image-list');
  const CarImage = document.getElementById('car-image');

  const selectFile = document.getElementById('select-file');
  selectFile.addEventListener('click', () => {
    CarImage.click();
  });

  const createImageHTML = (blob) => {

    if (selectFile) {
      selectFile.remove();
    }
    const selectHTMLNew = document.getElementById('select-file-new');
    if (selectHTMLNew) {
      selectHTMLNew.remove();
    }
    
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
    inputHTML.setAttribute('style','display: none;');

    const selectHTML = document.createElement('div');
    selectHTML.setAttribute('id', 'select-file-new');
    selectHTML.setAttribute('class', 'select-file');

    const selectFileBox = document.getElementById("select-file-box");

    imageElement.appendChild(blobImage);
    ImageList.appendChild(imageElement);
    selectHTML.appendChild(inputHTML);
    selectFileBox.appendChild(selectHTML);

    selectHTML.addEventListener('click', () => {
      inputHTML.click();
    });

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