exports.addToBody = function(html) {
  return function() {
    document.body.innerHTML = html;
  }
}
