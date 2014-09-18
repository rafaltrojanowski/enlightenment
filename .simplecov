SimpleCov.use_merging true
SimpleCov.start 'rails' do

  # Filters
  add_filter 'lib/keys' # Don't count api keys and stuff
  add_filter 'lib/tasks' # Don't count rake tasks

 # Groups
  add_group 'Controllers', 'app/controllers'
  add_group 'Models', 'app/models'
  add_group 'Helpers', 'app/helpers'
  add_group 'Mailers', 'app/mailers'
  add_group 'Uploaders', 'app/uploaders'
  add_group 'Libraries', 'lib'

  merge_timeout 3600
end
