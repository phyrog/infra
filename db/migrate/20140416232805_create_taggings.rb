class CreateTaggings < ActiveRecord::Migration
  def change
    create_table :taggings do |t|
      t.references :torrent, index: true
      t.references :tag, index: true
    end
  end
end
