# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
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
