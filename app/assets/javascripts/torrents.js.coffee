# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->
  $("#torrent_file").fileupload
    dataType: 'json'
    add: (e, data) ->
      data.context = $(tmpl("template-upload", data.files[0]))
      $("#new_torrent").append(data.context)
      data.submit()
    progress: (e, data) ->
      if data.context
        progress = parseInt(data.loaded / data.total * 100, 10)
        data.context.find('.meter').css('width', progress + '%')
    done: (e, data) ->
      $("#torrent_file_uid").val(data.result.file_uid)
      $("#new_torrent").submit()
  $("#filelist li:even").css('background-color', '#ffffff')
  $("#filelist ul > ul").each () ->
    bc = 'rgb(255, 255, 255)'
    pb = $(this).parent().css 'border-color'
    if pb == bc
      $(this).css 'border-color', 'transparent'
    else
      $(this).css 'border-color', bc


jQuery(document).ready(ready)
jQuery(document).on('page:load', ready)
