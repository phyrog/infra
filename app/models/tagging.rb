class Tagging < ActiveRecord::Base
  belongs_to :torrent
  belongs_to :tag
end
