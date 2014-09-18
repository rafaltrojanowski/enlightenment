require 'active_support/inflector'

guard 'minitest', spring: true, all_on_start: false do
  # with Minitest::Unit
  watch(%r|^test/(.*)\/?test_(.*)\.rb|)
  watch(%r|^lib/(.*)([^/]+)\.rb|)     { |m| "test/#{m[1]}test_#{m[2]}.rb" }
  watch(%r|^test/test_helper\.rb|)    { "test" }

  # with Minitest::Spec
  watch(%r|^test/(.*)_test\.rb|)
  watch(%r|^lib/(.*)([^/]+)\.rb|)     { |m| "test/#{m[1]}#{m[2]}_test.rb" }
  watch(%r|^test/test_helper\.rb|)    { "test" }

  # Rails 3.2
  watch(%r|^app/controllers/(.*)\.rb|) { |m| "test/controllers/#{m[1]}_test.rb" }
  watch(%r|^app/helpers/(.*)\.rb|)     { |m| "test/helpers/#{m[1]}_test.rb" }
  watch(%r|^app/models/(.*)\.rb|)      { |m| "test/models/#{m[1]}_test.rb" }

  watch(%r{^app/views/(.+)/.*\.(erb|haml)$})          { |m| "test/features/#{m[1]}_test.rb" }

  # Factory girl
  watch(%r{^test/factories/(.+)\.rb$}) do |m|
    %W[
      test/models/#{m[1].singularize}_test.rb
      test/controllers/#{m[1]}_controller_test.rb
      test/requests/#{m[1]}_test.rb
    ]
  end

  # Rails
  # watch(%r|^app/controllers/(.*)\.rb|) { |m| "test/functional/#{m[1]}_test.rb" }
  # watch(%r|^app/helpers/(.*)\.rb|)     { |m| "test/helpers/#{m[1]}_test.rb" }
  # watch(%r|^app/models/(.*)\.rb|)      { |m| "test/unit/#{m[1]}_test.rb" }
end
