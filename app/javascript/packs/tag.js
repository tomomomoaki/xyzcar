function tag_search () {
  const searchForm = document.getElementById("keyword-search-form");
  searchForm.addEventListener('keyup', () => {
    let keyword = searchForm.value;
    if (keyword.match( /#/ )) {
      keyword = keyword.replace("#", "%23");
    }
    const XHR = new XMLHttpRequest();
    XHR.open("GET", `cars/search_tag/?keyword=${keyword}`, true);
    XHR.responseType = "json";
    XHR.send();

    XHR.onload = () => {
      const searchResult = document.getElementById('search-result');
      searchResult.innerHTML = "";
      if (XHR.response) {
        const tagName = XHR.response.keyword;
        for(let i = 0;i < 5;i++) {
          const childElement = document.createElement("div");
          childElement.setAttribute("class", "child");
          childElement.setAttribute("id", tagName[i].id );
          childElement.innerHTML = tagName[i].name;
          searchResult.appendChild(childElement);

          const clickElement = document.getElementById( tagName[i].id );
          clickElement.addEventListener('click', () => {
            document.getElementById("keyword-search-form").value = clickElement.textContent;
            clickElement.remove();
          });
        };
      };
    };
  });
};

document.addEventListener('DOMContentLoaded', tag_search);