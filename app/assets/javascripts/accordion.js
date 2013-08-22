$(document).ready(function(){
  $(function() {
    $( "#accordion" ).accordion({
      collapsible: true
    });
  });
  $(function() {
    $( "#tabs" ).tabs();
  });
  $(".flash").fadeOut(1500, function () {
  $(this).remove();
  });
  $("#collapse").collapse({
  // options...
});
});

