$(document).ready(function() {
  var todoTemplate = $.trim($('#todo_template').html());

function addToDo() {
  var task = $('.todo').val();
   var built_task = buildTodo(task);
    $('.todo_list').append(built_task);
};

function deleteToDo() {
  var task_to_delete = $(this).closest('.todo');
  task_to_delete.remove();
};

function complete() {
  var task_to_complete = $(this).closest('.todo');
  task_to_complete.addClass("complete");
};

function bindEvents() {
  $('.todo_list').on('click', '.delete', deleteToDo);
  $('.todo_list').on('click', '.complete', complete);
  $('button').click(addToDo);
};
  
function buildTodo(todoName) {
  var $todo = $(todoTemplate);
  $todo.find('h2').text(todoName);
  return $todo;
}
  
  bindEvents();
});
