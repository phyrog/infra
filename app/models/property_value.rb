class PropertyValue < ActiveRecord::Base
  belongs_to :property
  belongs_to :torrent

  def to_s
    self.value.to_s
  end
end
