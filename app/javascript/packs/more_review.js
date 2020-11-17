function review () {
  const reviewLists = document.getElementById('review-lists');
  const moreReview = document.getElementById('more-review');
  const Render = escape_javascript("<%= render 'cars', object: @cars %>")
  reviewLists.append(Render);
  moreReview.replaceWith("<%= link_to_next_page @cars, 'もっと見る', remote: true, class:'more-review, id:'more-review' %>");
}

if (document.URL.match( /search/ ) || document.URL.match( /type/ ) || location.pathname == "/" ) {
  document.addEventListener('DOMContentLoaded', review);
}
