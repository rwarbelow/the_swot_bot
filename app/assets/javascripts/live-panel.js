$(document).ready(function() {

  $('.other-function-container').hide();
  $('.attendance-container').hide();

  $('.behavior-container .student-icon').click(function() {
      $(this).toggleClass('active');
  });

  $('.submit-button').click(function(event) {
    var submit_action = $(this).attr('id'); 
    var data = [];
    var clicked = $('.active').each(function(){
      data.push($(this).attr('id')); // Student ID
    });

    var course_id = $('data').attr('id');
    var url = ('/live_class');
    var dataToSend = {action_name: submit_action,
                  student_ids : data, 
                  course_id: course_id}
           
    $.post(url, dataToSend);
    $('.student-icon').removeClass('active');
    data = [];
  });


  $('#other').click(function() {
    var clicked = $('.active').text();
    
    $('.grid-container').hide();
    $('.other-function-container').show();

    $('.other-function').click(function(){
      var submit_action = $(this).attr('id');
      var data = [];
      
      $('.active').each(function(){
        data.push($(this).attr('id'));
      });
     
      var url = ('/live_class');
      var course_id = $('data').attr('id');
      var dataToSend = { action_name: submit_action,
                   student_ids : data,
                   course_id: course_id }

      $.post(url, dataToSend);

      $('.other-function-container').hide();
      $('.grid-container').show();
      $('.student-icon').removeClass('active');
      data = [];
    });
  });

  $('#attendance').click(function(){
    $('.behavior-container').hide();
    $('.attendance-container').show();
    // todo: get current class attendance from db
    // instead of setting all the classes to present as below
    // default attendance should be 'present' in migration
  
    $('.attendance-container .student-icon').addClass('present');
    
    var currentIcon;

    function toggleAttendance(){
      if($(currentIcon).hasClass('present')){
        $(currentIcon).removeClass('present');
        $(currentIcon).addClass('tardy');
      }
      else if($(currentIcon).hasClass('tardy')){
        $(currentIcon).removeClass('tardy');
        $(currentIcon).addClass('absent');
      }
      else if($(currentIcon).hasClass('absent')){
        $(currentIcon).removeClass('absent');
        $(currentIcon).addClass('present');
      }
    }

    $('.student-icon').click(function() {
      console.log("clicked");
      currentIcon = this;
      toggleAttendance();  
    });

    $('#submit').click(function(){
      var data = [];
      var tardy = [];
      var absent = [];
      var present = [];

      var submit_action = $(this).attr('id');

      $('.tardy').each(function(){
        tardy.push($(this).attr('id')); // Student ID
      });

      $('.absent').each(function(){
        absent.push($(this).attr('id')); // Student ID
      });

      $('.present').each(function(){
        present.push($(this).attr('id')); // Student ID
      });

      var course_id = $('data').attr('id');
      url = ('/live_class');
      dataToSend =  {
                    tardy : tardy,
                    absent : absent,
                    present : present,
                    course_id : course_id
                    }

      $.post(url, dataToSend);
      $('.attendance-container').hide();
      $('.behavior-container').show();
    });
  });
});






