$(document).ready(function() {
  var submit_action;
  var url;
  var data;

  $('.other-function-container').hide();

  $('.student-icon').click(function() {
      $(this).toggleClass('active');
  });

  $('.submit-button').click(function() {
    clicked = $('.active').text();
    submit_param = $(this).attr('id');
    
    data = clicked //but do something to it to separate?
    url = ('/live_class/' + submit_param);

    console.log(clicked); 
    console.log(url);

    // submit ajax post
    $('.student-icon').removeClass('active');
  });

  $('#other').click(function() {
    clicked = $('.active').text();

    $('.grid-container').hide();
    $('.other-function-container').show();

    $('.other-function').click(function(){
      $('.other-function-container').hide();
      $('.grid-container').show();
      
      submit_param = $(this).attr('id');
      url = ('/live_class/' + submit_param);
      
      console.log(clicked);
      console.log(url);

      // submit ajax post
      $('.student-icon').removeClass('active');

    });
  });
});