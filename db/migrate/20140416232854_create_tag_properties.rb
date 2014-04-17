class CreateTagProperties < ActiveRecord::Migration
  def change
    create_table :tag_properties do |t|
      t.references :tag, index: true
      t.references :property, index: true
    end
  end
end
