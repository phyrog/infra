class Tag < ActiveRecord::Base
  has_many :tag_properties
  has_many :taggings
  has_many :properties, through: :tag_properties
  has_many :torrents, through: :taggings
end
