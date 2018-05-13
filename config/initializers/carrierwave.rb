CarrierWave.configure do |config|
  config.storage = :file
  config.permissions = 0600
  config.directory_permissions = 0700
  config.cache_dir = "#{Rails.root}/tmp/uploads"
  config.root = Rails.root
end
