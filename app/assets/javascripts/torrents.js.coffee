# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

plotData = (nodes, vis, xscale, yscale, color) ->
  lx = nodes.reduce (l, n) ->
    if l.last
      {last: n, lines: l.lines.concat([{origin: l.last, target: n}])}
    else
      {last: n, lines: [{origin: l, target: n}]}
  lines = lx.lines
  vis.selectAll(".line")
    .data(lines)
    .enter()
    .append("line")
    .attr("x1", (d) -> xscale(d.origin.x.getTime()))
    .attr("y1", (d) -> yscale(d.origin.y))
    .attr("x2", (d) -> xscale(d.target.x.getTime()))
    .attr("y2", (d) -> yscale(d.target.y))
    .style("stroke", color)
  node = vis.selectAll("circle.node").data(nodes).enter().append("g").attr("class", "node")
  node.append("line")
    .attr("x1", (d) -> xscale(d.x.getTime()))
    .attr("x2", (d) -> xscale(d.x.getTime()))
    .attr("y1", (d) -> yscale(d.y))
    .attr("y2", "170")
    .style("stroke", "#ccc")
    .style("stroke-dasharray", "5,5")
  node.append("circle")
    .attr("cx", (d) -> xscale(d.x.getTime()))
    .attr("cy", (d) -> yscale(d.y))
    .attr("r", "0.3em")
    .attr("fill", color)
    .attr("onmouseover", "this.setAttribute('r', '0.45em');")
    .attr("onmouseout", "this.setAttribute('r', '0.3em');")
    .style("stroke", "#f4f4f4")
    .style("stroke-width", "4")
  node.append("text")
    .attr("x", (d) -> xscale(d.x.getTime()) - 30)
    .attr("y", (d) -> yscale(d.y) + 30)
    .text((d) -> ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'][d.x.getDay()])

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
  vis = d3.select("#graph").append("svg")
  height = 200
  width = $("#graph > svg").width() - 30
  now = new Date()
  xscale = d3.scale.linear().domain([now.getTime() - 604800000, now.getTime()]).range([30, width])
  yscale = d3.scale.linear().domain([0, 100]).range([height - 30, 0])
  nodes = [{x: new Date(2014, 6, 13), y: 30},
           {x: new Date(2014, 6, 14), y: 60},
           {x: new Date(2014, 6, 15), y: 80},
           {x: new Date(2014, 6, 16), y: 90},
           {x: new Date(2014, 6, 17), y: 60},
           {x: new Date(2014, 6, 18), y: 50},
           {x: new Date(2014, 6, 19), y: 80},
           {x: new Date(2014, 6, 20), y: 100},
           {x: new Date(2014, 6, 21), y: 70},
           {x: new Date(2014, 6, 22), y: 50},
           {x: new Date(), y: 47}]
  nodes2 = nodes.slice().map (e) -> {x: e.x, y: e.y - 20}
  nodes3 = nodes.slice().map (e) -> {x: e.x, y: e.y - 30}
  nodes3[8].y = 80
  nodes2[8].y = 20
  plotData(nodes, vis, xscale, yscale, "#000")
  plotData(nodes2, vis, xscale, yscale, "#f00")
  plotData(nodes3, vis, xscale, yscale, "#0f0")

jQuery(document).ready(ready)
jQuery(document).on('page:load', ready)
