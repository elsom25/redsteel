guard :bundler do
  watch('Gemfile')
end

guard :rails do
  watch('Gemfile.lock')
  watch(%r{^(config|lib)/.*})
end

guard :sidekiq, environment: :development do
  watch(%r{^workers/(.+)\.rb$})
end

guard :minitest do
  watch(%r{^test/test_helper\.rb$}) { 'test' }
  watch(%r{^app/controllers/application_controller\.rb$}) { 'test/controllers' }

  # *_test
  watch(%r{^app/(.+)\.rb$})                               { |m| "test/#{m[1]}_test.rb" }
  watch(%r{^app/controllers/(.+)_controller\.rb$})        { |m| "test/integration/#{m[1]}_test.rb" }
  watch(%r{^app/views/(.+)_mailer/.+})                    { |m| "test/mailers/#{m[1]}_mailer_test.rb" }
  watch(%r{^lib/(.+)\.rb$})                               { |m| "test/lib/#{m[1]}_test.rb" }
  watch(%r{^test/.+_test\.rb$})

  # *_spec
  watch(%r{^app/(.+)\.rb$})                               { |m| "test/#{m[1]}_spec.rb" }
  watch(%r{^app/controllers/(.+)_controller\.rb$})        { |m| "test/integration/#{m[1]}_spec.rb" }
  watch(%r{^app/views/(.+)_mailer/.+})                    { |m| "test/mailers/#{m[1]}_mailer_spec.rb" }
  watch(%r{^lib/(.+)\.rb$})                               { |m| "test/lib/#{m[1]}_spec.rb" }
  watch(%r{^test/.+_spec\.rb$})
end
