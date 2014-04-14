class AddFileFieldsToTorrent < ActiveRecord::Migration
  def change
    add_column :torrents, :file_uid, :string
    add_column :torrents, :file_name, :string
  end
end
