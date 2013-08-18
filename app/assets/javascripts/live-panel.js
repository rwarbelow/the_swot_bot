$(document).ready(function() {
  var submit_action;
  var url;
  var data;
  var clicked;
  var data = [];
  var dataToSend;
  var json_data;

  $('.other-function-container').hide();

  // The student icons toggle when clicked
  $('.student-icon').click(function() {
      $(this).toggleClass('active');
  });

  // When a submission button is clicked
  // the student id's are put into an array (data)
  $('.submit-button').click(function(event) {
    submit_action = $(this).attr('id'); 

    clicked = $('.active').each(function(){
      data.push($(this).attr('id')); // Student ID
    });

    // Set the url and data to post
    url = ('/live_class');
    dataToSend = { submission: submit_action,
                   student_ids : data }

    // Post to the student_actions_controller
    // Reset the student icons
    // Clear the data array             
    $.post(url, dataToSend);
    $('.student-icon').removeClass('active');
    data = [];
  });


  $('#other').click(function() {
    clicked = $('.active').text();
    // Hide the main screen and show the other action div
    $('.grid-container').hide();
    $('.other-function-container').show();

    // When a submission is clicked:
    $('.other-function').click(function(){
      submit_action = $(this).attr('id');

    // Student ID's are put into array (id's)
    $('.active').each(function(){
      data.push($(this).attr('id'));
    });
    
    // Set the URL and create a data object to post  
    url = ('/live_class');
    dataToSend = { submission: submit_action,
                 student_ids : data }

    console.log(clicked);
    console.log(url);
    // Post to the student_actions_controller
    $.post(url, dataToSend);
    // Reset the student icons
    // Clear the data array
    $('.other-function-container').hide();
    $('.grid-container').show();
    $('.student-icon').removeClass('active');
    data = [];
    });
  });
});