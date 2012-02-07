$(function() {
  $("#authenticate").click(function() {
    navigator.id.get(function(assertion) {
        if (assertion) {
          $.post("/home/login", { assertion: assertion },
             function(data) {
                window.location = "/sessions";
          });
        }
    });
  });
});
