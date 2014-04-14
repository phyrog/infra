require 'dragonfly'

# Configure
Dragonfly.app.configure do
  plugin :imagemagick

  protect_from_dos_attacks true
  secret "3e2a317c239b725b146a9e616492938ee44504a2798039ddf698249b37b14821"

  url_format "/media/:job/:name"

  processor :personalize do |content|
    hash = content.data.bdecode
    token = "some_token"
    hash["announce"] = "http://localhost:3000/some_token/announce"
    content.update(hash.bencode)
  end

  datastore :file,
    root_path: Rails.root.join('public/system/dragonfly', Rails.env),
    server_root: Rails.root.join('public')
end

# Logger
Dragonfly.logger = Rails.logger

# Mount as middleware
Rails.application.middleware.use Dragonfly::Middleware

# Add model functionality
if defined?(ActiveRecord::Base)
  ActiveRecord::Base.extend Dragonfly::Model
  ActiveRecord::Base.extend Dragonfly::Model::Validations
end
