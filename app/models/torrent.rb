class Torrent < ActiveRecord::Base
  dragonfly_accessor :file

  validates :name, presence: true
  validates :description, presence: true
  validates :file, presence: true

  fuzzily_searchable :name, :description

  def to_h
    @hash ||= file.data.bdecode
  end

  def size
    h = self.to_h
    @size ||= h["info"]["length"] if not h["info"]["files"]
    @size ||= h["info"]["files"].map { |f| f["length"] }.reduce(:+)
  end

  def formatted_size
    Filesize.from("#{self.size} B").pretty
  end

  def no_files
    h = self.to_h
    if h["info"]["files"]
      h["info"]["files"].length
    else
      1
    end
  end

  def list_of_files
    h = self.to_h
    if h["info"]["files"]
      h["info"]["files"].map do |file|
        File.join(h["info"]["name"], file["path"])
      end
    else
      [h["info"]["name"]]
    end
  end

  def tree_of_files
    h = self.to_h
    if h["info"]["files"]
      tree = [{ label: h["info"]["name"], children: [] }]
      h["info"]["files"].map do |file|
        t = tree
        file["path"].unshift(h["info"]["name"]).each do |path|
          c = t.detect { |p| p[:label] == path }
          if c
            t = c[:children]
          else
            if path == file["path"].last
              t << { label: path, length: file["length"] }
              t = t.detect { |p| p[:label] == path }
            else
              t << { label: path, children: [] }
              t = t.detect { |p| p[:label] == path }[:children]
            end
          end
        end
      end
    else
      tree = [{ label: h["info"]["name"], length: h["info"]["length"] }]
    end
    tree
  end
end
