# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )

Rails.application.config.tap do |config|
  config.assets.precompile += %w(*.png *.jpg *.jpeg *.gif *.svg *.eot *.woff *.ttf *.ico)
  config.assets.precompile += %w(sb-admin/admin.css sb-admin/admin.js)

  config.assets.paths << Rails.root.join('vendor', 'assets', 'fonts')
end
