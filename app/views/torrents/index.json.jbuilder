json.array!(@torrents) do |torrent|
  json.extract! torrent, :id, :name, :description
  json.url torrent_url(torrent, format: :json)
end
