class Torrent < ActiveRecord::Base
  dragonfly_accessor :file

  validates :name, presence: true
  validates :description, presence: true
  validates :file, presence: true
end
