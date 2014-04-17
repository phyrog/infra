class Property < ActiveRecord::Base
  has_many :property_values

  def to_sym
    self.name.downcase.to_sym
  end

  def to_s
    self.name.capitalize
  end
end
