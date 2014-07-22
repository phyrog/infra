// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery.ui.core
//= require jquery.ui.widget
//= require jquery.ui.position
//= require jquery.ui.autocomplete
//= require jquery_ujs
//= require jquery-fileupload/basic
//= require jquery-fileupload/vendor/tmpl
//= require jquery.timeago
//= require jquery.autosize
//= require tag-it
//= require foundation
//= require turbolinks
//= require_tree .

var ready = function(){
  $(document).foundation();
  $("time").timeago();
  $("#torrent_tags_string").tagit({
    singleFieldDelimiter: " "
  });

  $(".tagit").on('focusin', function() {
    $(this).addClass("focus");
  }).on('focusout', function() {
    $(this).removeClass("focus");
  });
};

$(document).ready(ready);
$(document).on('page:load', ready);
