module TorrentsHelper
  def html_file_list(nodes)
    files = []
    files << "<ul>"
    nodes.each do |n|
      files << "<li><span>#{formatted_file_name(n)}</span>#{extension_label(n)}#{size_label(n)}</li>"
      files += html_file_list(n[:children]) if n[:children]
    end
    files << "</ul>"
  end

  def formatted_file_name(file)
    h(file[:label])
  end

  def formatted_file_list(torrent)
    html_file_list(torrent.tree_of_files).join.html_safe
  end

  def size_label(file)
    "<span class='label'>#{Filesize.from("#{file[:length]} B").pretty}</span>".html_safe if file[:length]
  end

  def extension_label(file)
    parts = file[:label].split(".")
    if parts.length > 1
      "<span class='label'>#{parts.last.upcase[0..2]}</span>" 
    elsif file[:children]
      "<span></span><span class='label'>DIR</span>"
    end
  end
end
