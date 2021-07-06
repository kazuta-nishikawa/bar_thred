CarrierWave.configure do |config|
  config.fog_credentials = {
    provider: 'AWS',
    aws_access_key_id: 'AKIAWBFUSNG4HI6A2VZS',
    aws_secret_access_key: '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',
    region: 'ap-northeast-1'
  }

  config.fog_directory  = 'rails-photo-123'
  config.asset_host = "https://s3.ap-northeast-1.amazonaws.com/cocktialpad"
  config.fog_public = false
  config.cache_storage = :fog
end