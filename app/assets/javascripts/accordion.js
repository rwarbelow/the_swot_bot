$(document).ready(function(){
  $(function() {
    $( "#accordion" ).accordion({
      collapsible: true
    });
  });
  $(function() {
    $( "#tabs" ).tabs();
  });
  $(".flash").fadeOut(2000, function () {
  $(this).remove();
  });
});

