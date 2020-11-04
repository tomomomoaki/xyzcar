function preview () {
  const ImageList = document.getElementById('image-list');
  const CarImage = document.getElementById('car-image-0');

  const selectFile = document.getElementById('select-file');
  selectFile.addEventListener('click', () => {
    CarImage.click();
  });

  let Num = 0;

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
    // let imageElementNum = document.querySelectorAll('.image-element').length;
    imageElement.setAttribute('id', `image-element-${Num}`);

    const blobImage = document.createElement('img');
    blobImage.setAttribute('src', blob);
    blobImage.setAttribute('class', 'preview-car-image');

    const deleteBtn = document.createElement('div');
    deleteBtn.setAttribute('class', 'delete-btn');
    deleteBtn.setAttribute('id', `delete-btn-${Num}`);
    deleteBtn.setAttribute('onclick', 'deleteId(this)');
    deleteBtn.innerHTML = '削除';

    Num += 1;
    const inputHTML = document.createElement('input');
    inputHTML.setAttribute('id',`car-image-${Num}`);
    inputHTML.setAttribute('name', 'car[images][]');
    inputHTML.setAttribute('type','file');
    inputHTML.setAttribute('style','display: none;');

    const selectHTML = document.createElement('div');
    selectHTML.setAttribute('id', 'select-file-new');
    selectHTML.setAttribute('class', 'select-file');

    const selectHTMLText = document.createElement('div');
    selectHTMLText.setAttribute('class', 'select-file-text');
    selectHTMLText.innerHTML = '画像を追加';

    const selectFileBox = document.getElementById("select-file-box");

    imageElement.appendChild(deleteBtn);
    imageElement.appendChild(blobImage);
    ImageList.appendChild(imageElement);
    selectFileBox.appendChild(inputHTML);
    selectHTML.appendChild(selectHTMLText);
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

  window.deleteId = function deleteId(element) {
    console.log(element);
    const ID = element.id.slice(-1);
    document.getElementById(`car-image-${ID}`).remove();
    document.getElementById(`image-element-${ID}`).remove();
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