CarrierWave.configure do |config|
  config.fog_credentials = {
    provider: 'AWS',
    aws_access_key_id: 'xxx',
    aws_secret_access_key: 'mxxx',
    region: 'eu-central-1'
  }
  config.fog_directory = 'prograils-com-cibea-dev'
  config.fog_public = true
end
