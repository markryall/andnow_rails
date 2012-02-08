$(function() {
  $("#authenticate").click(function() {
    navigator.id.get(function(assertion) {
        if (assertion) {
          $.post("/home/verify", { assertion: assertion },
             function(data) { window.location = "/"; }
          );
        }
    });
  });
});
