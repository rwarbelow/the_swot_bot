$(document).ready(function() {

  $('.other-function-container').hide();
  $('.attendance-container').hide();

  $('.behavior-container .student-icon').click(function() {
      $(this).toggleClass('active');
  });

// ==============FRONT PAGE BEHAVIOR ACTIONS=====================

  $('.behavior-container .submit-button').click(function(event) {
    var submit_action = $(this).attr('id'); 
    var data = [];

    $('.active').each(function(){
      data.push($(this).data('id')); // Student ID
    });

    console.log(data);
    var course_id = $('#course-id data').attr('id');
    var url = ('/live_class');
    var dataToSend = {action_name: submit_action,
                      student_ids : data, 
                      course_id: course_id}
           
    $.post(url, dataToSend);
    $('.student-icon').removeClass('active');
    data = [];
  });

// ==================OTHER BEHAVIOR ACTIONS========================

  $('#other').click(function() {
    var clicked = $('.active').text();
    
    $('.grid-container').hide();
    $('.behavior-container').hide();
    $('.other-function-container').show();

    $('.other-function').click(function(){
      var submit_action = $(this).attr('id');
      var data = [];
      
      $('.active').each(function(){
        data.push($(this).data('id'));
      });
      console.log(data);
      var url = ('/live_class');
      var course_id = $('#course-id data').attr('id');
      var dataToSend = {action_name: submit_action,
                        student_ids : data,
                        course_id: course_id }

      $.post(url, dataToSend);

      $('.other-function-container').hide();
      $('.grid-container').show();
      $('behavior-container').show();
      $('.student-icon').removeClass('active');
      data = [];
    });
  });

// ===============ATTENDANCE ACTIONS===================

  $('#attendance').click(function(){

    $('.behavior-container').hide();
    $('.attendance-container').show().find('.student-icon').addClass('on_time');
   
    var course_id = $('#course-id data').attr('id');
    var get_url = '/teachers/courses/'+course_id+'/liveclass'
    var on_time;
    var tardy;
    var absent;
    // var currentIcon;

    // get the current attendance from db (json)
    //set the classes for each icon to the attendance status
    $.get(get_url, function(response){
      // console.log(response);
      on_time = response.on_time
      tardy = response.tardy
      absent = response.absent
      
      function set_class(status_array, class_name){
        $.each(status_array, function(i, v){
          // icon = $('li .attendance-container').find("[data-id='" + v + "']");
          icon = $(".attendance-container [data-id='" + v + "']");
          icon.removeClass();
          icon.addClass('student-icon '+class_name+'')
        });
      }

      set_class(on_time, "on_time");
      set_class(tardy, "tardy");
      set_class(absent, "absent");
    }, 'json');


    function toggleAttendance(currentIcon){
      // console.log(currentIcon);
      if($(currentIcon).hasClass('on_time')){
        $(currentIcon).removeClass('on_time');
        $(currentIcon).addClass('tardy');
      }
      else if($(currentIcon).hasClass('tardy')){
        $(currentIcon).removeClass('tardy');
        $(currentIcon).addClass('absent');
      }
      else if($(currentIcon).hasClass('absent')){
        $(currentIcon).removeClass('absent');
        $(currentIcon).addClass('on_time');
      }
    }
    
    $('.attendance-container .student-icon').click(function() {
      // console.log("clicked");
      toggleAttendance(this);  
    });

    $('#submit').click(function(){
      var data = [];
      var tardy_posts = [];
      var absent_posts = [];
      var on_time_posts = [];

      var submit_action = $(this).attr('id');

      $('.tardy').each(function(){
        tardy_posts.push($(this).data('id')); // Student ID
      });

      $('.absent').each(function(){
        absent_posts.push($(this).data('id')); // Student ID
      });

      $('.on_time').each(function(){
        on_time_posts.push($(this).data('id')); // Student ID
      });

      var course_id = $('#course-id data').attr('id');
      url = ('/live_class');
      dataToSend =  {
                    tardy : tardy_posts,
                    absent : absent_posts,
                    on_time : on_time_posts,
                    course_id : course_id
                    }

      $.post(url, dataToSend);
      $('.attendance-container').hide();
      $('.behavior-container').show();
    });
  });

// =====================MASTERY ACTIONS======================

});






