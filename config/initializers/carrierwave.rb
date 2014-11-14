CarrierWave.configure do |config|
  if Rails.env.test?
    config.storage :file
  elsif Rails.env.development?
    config.storage :fog

    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: ENV['ENLIGHTENMENT_S3_ID_DEV'],
      aws_secret_access_key: ENV['ENLIGHTENMENT_S3_KEY_DEV'],
      region: 'eu-central-1'
    }
    config.fog_directory = ENV['ENLIGHTENMENT_S3_BUCKETS_DEV']
  elsif Rails.env.production?
    config.storage :fog

    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: ENV['ENLIGHTENMENT_S3_ID'],
      aws_secret_access_key: ENV['ENLIGHTENMENT_S3_KEY'],
      region: 'eu-central-1'
    }
    config.fog_directory = ENV['ENLIGHTENMENT_S3_BUCKETS']
  end
  config.fog_public = true
end
