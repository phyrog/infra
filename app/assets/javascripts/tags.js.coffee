# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->
  $("input[type=text]#property_name")
    .change(() ->
      $("#new_property input[type=hidden]#property_name").val($(this).val()))
  $("input[type=text]#property_postfix")
    .change () ->
      $("#new_property input[type=hidden]#property_postfix").val($(this).val())
  $("select#property_value_type")
    .change () ->
      $("#new_property input[type=hidden]#property_value_type").val($(this).val())
  $("table").on 'submit', "form", (e) ->
    e.preventDefault()
    val = $(this).children("#property_act").val()
    self = this
    $.post $(this).attr("action"), $(this).serialize(), (data) ->
      if val == "rem"
        $("#property_" + data.id).remove()
      else
        $(self).parents("tr").before(data)
        $(self).children("input#property_name, input#property_postfix, input#property_value_type").val("")
        $("input[type=text]#property_name, input[type=text]#property_postfix").val("")
      console.log(data)
      

jQuery(document).ready(ready)
jQuery(document).on('page:load', ready)
