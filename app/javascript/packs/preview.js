function preview () {

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
    if (document.querySelectorAll('.image-element').length <= 9) {
      selectFileBox.appendChild(inputHTML);
      selectHTML.appendChild(selectHTMLText);
      selectFileBox.appendChild(selectHTML);
    }
    selectHTML.addEventListener('click', () => {
      inputHTML.click();
    });
    inputHTML.addEventListener('change', (e) => {
      const file = e.target.files[0];
      const blob = window.URL.createObjectURL(file);
      createImageHTML(blob)
    });
  }
  const ImageList = document.getElementById('image-list');
  const CarImage = document.getElementById('car-image-0');
  const selectFile = document.getElementById('select-file');
  let oldElementIds = [];
  let Num = 0;

  //編集画面に遷移時、最初にもともと保存されていた画像をプレビュー表示させる
  const beforeCarImagesHtml = document.getElementById('before-car-images');
  if (beforeCarImagesHtml) {
    const beforeCarImages = JSON.parse(beforeCarImagesHtml.dataset.json);
    beforeCarImages.forEach( function(image) {
      oldElementIds.push(Num);
      createImageHTML(image.url);
    });
    document.getElementById('old-image-ids').value = oldElementIds;
  }
  
  //「画像を選択する」という要素をクリックすると、input要素がクリックされたことになる
  selectFile.addEventListener('click', () => {
    CarImage.click();
  });

  //画像が選択されるとプレビュー表示へ
  CarImage.addEventListener('change', (e) => {
    const file = e.target.files[0];
    const blob = window.URL.createObjectURL(file);
    createImageHTML(blob);
  });

  //プレビューの削除ボタンを押すと、プレビューを削除する
  window.deleteId = function deleteId(element) {
    const ID = element.id.slice(-1);
    document.getElementById(`car-image-${ID}`).remove();
    document.getElementById(`image-element-${ID}`).remove();
    oldElementIds = oldElementIds.filter(a => a !== Number(ID));
    document.getElementById('old-image-ids').value = oldElementIds;
  }
}

if (document.URL.match( /new/ ) || document.URL.match( /edit/ ) || document.URL.match( /cars/ )) {
  document.addEventListener('DOMContentLoaded',preview);
}