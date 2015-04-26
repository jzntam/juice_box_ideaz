$(document).ready(function() {

  $('#pin').sortable({
    update: function() {
      var ids = $('#pin').sortable('serialize');
      $.post('/pins/sort', ids);
    }
  });

});
