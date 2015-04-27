// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require best_in_place
//= require jquery-ui
//= require best_in_place.jquery-ui
//= require jquery.purr
//= require best_in_place.purr
//= require bootstrap-sprockets
//= require_tree .

console.log('js loaded');

$(document).ready(function() {
   $('#filter-library').on("keyup", function(e){
    var searchTerm = $('#filter-library').val();
    if(e.keyCode == 8) {
    $(".title:not(:contains("+searchTerm+"))").parent().fadeOut();
    $(".title:contains("+searchTerm+")").parent().fadeIn();
    } else {
    $(".title:not(:contains("+searchTerm+"))").parent().fadeOut();
    }
  })})  ;

$(document).ready(function() {
  /* Activating Best In Place */
  jQuery(".best_in_place").best_in_place();
});
