class Torrent < ActiveRecord::Base

  has_many :taggings
  has_many :tags, through: :taggings
  has_many :tag_properties, through: :tags
  has_many :properties, through: :tag_properties
  has_many :property_values

  dragonfly_accessor :file

  validates :name, presence: true
  validates :description, presence: true
  validates :file, presence: true

  fuzzily_searchable :name

  def self.find_by_query(query)
    queries = (query.split " ").map { |e| e.strip }
    (has_tags, queries) = queries.select_and_delete { |query| /^\+.+/.match(query) }
    (has_tags_not, queries) = queries.select_and_delete { |query| /^-.+/.match(query) }

    all_torrents = Torrent.all

    if has_tags.empty?
      torrents_by_tags = all_torrents
    else
      torrents_by_tags = has_tags.map do |tag|
        tag = Tag.find_by(name: tag[1..-1].strip)
        tag ? tag.torrents : []
      end.reduce(&:&)
    end

    if has_tags_not.empty?
      torrents_by_tags_not = all_torrents
    else
      torrents_by_tags_not = all_torrents - has_tags_not.map do |tag|
        tag = Tag.find_by(name: tag[1..-1].strip)
        tag ? tag.torrents : []
      end.reduce(&:+)
    end

    if queries.join(" ").strip.empty?
      torrents_by_fuzzy_name = all_torrents
    else
      torrents_by_fuzzy_name = Torrent.find_by_fuzzy_name(queries.join " ") + Torrent.find_by_fuzzy_description(queries.join " ")
    end

    torrents_by_tags & torrents_by_tags_not & torrents_by_fuzzy_name
  end

  def tags_string
    self.tags.map(&:name).join(" ")
  end

  def tags_string=(tags)
    self.tags = tags.split(" ").map { |t| Tag.find_or_create_by(name: t.downcase) }
  end

  def value_of_property(prop)
    self.property_values.find_by(property_id: prop.id)
  end

  def to_h
    @hash ||= file.data.bdecode
  end

  def size
    h = self.to_h
    if h
      @size ||= h["info"]["length"] if not h["info"]["files"]
      @size ||= h["info"]["files"].map { |f| f["length"] }.reduce(:+)
    else
      0
    end
  end

  def formatted_size
    Filesize.from("#{self.size} B").pretty
  end

  def no_files
    h = self.to_h
    if h
      if h["info"]["files"]
        h["info"]["files"].length
      else
        1
      end
    else
      0
    end
  end

  def tree_of_files
    h = self.to_h
    if h
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
    else
      []
    end
  end
end
