$(function() {
  $("#authenticate").click(function() {
    navigator.id.get(function(assertion) {
        if (assertion) {
          $("#assertion").text(assertion);
        }
    });
  });
});
