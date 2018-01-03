exports.addToBody = function(node) {
  return function() {
    document.body.appendChild(node);
  }
}

exports.replaceView = function(view) {
  return function(newView) {
    return function() {
      view.parentNode.replaceChild(newView, view);
    }
  }
}
