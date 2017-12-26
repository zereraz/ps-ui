exports.addToBody = function(node) {
  console.log(node);
  return function() {
    document.body.appendChild(node);
  }
}
