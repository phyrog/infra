class PropertyValue < ActiveRecord::Base
  belongs_to :property
  belongs_to :torrent

  def typed_value
    case self.property.value_type
      when 'Integer'
        self.value.to_i
      else
        self.value
    end
  end

  def to_s
    self.value.to_s
  end
end
