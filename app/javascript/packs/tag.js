function tag_search () {
  const searchForm = document.getElementById("keyword-search-form");
  searchForm.addEventListener('keyup', () => {
    const keyword = document.getElementById("keyword-search-form").value;
    const XHR = new XMLHttpRequest();
    XHR.open("GET", `search/?keyword=${keyword}`, true);
    XHR.responseType = "json";
    XHR.send();

    XHR.onload = () => {
      const searchResult = document.getElementById("search-result");
      searchResult.innerHTML = "";
      if (XHR.response) {
        const tagName = XHR.response.keyword;
        tagName.foreach((tag) => {
          const childElement = document.getElementById("div");
          childElement.setAttribute("class","child");
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

window.addEventListener('load', tag_search);