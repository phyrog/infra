class CreatePropertyValues < ActiveRecord::Migration
  def change
    create_table :property_values do |t|
      t.string :value
      t.references :property, index: true
      t.references :torrent, index: true
    end
  end
end
