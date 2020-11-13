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
        tagName.forEach((tag) => {
          const childElement = document.createElement("div");
          childElement.setAttribute("class", "child");
          childElement.setAttribute("id", tag.id );
          childElement.innerHTML = tag.name;
          searchResult.appendChild(childElement);

          const clickElement = document.getElementById( tag.id );
          clickElement.addEventListener('click', () => {
            document.getElementById("keyword-search-form").value = clickElement.textContent;
            clickElement.remove();
          });
        });
      };
    };
  });
};

document.addEventListener('DOMContentLoaded', tag_search);