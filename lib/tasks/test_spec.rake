namespace :spec do
  Rails::TestTask.new(:all) do |t|
    t.libs << 'test'
    t.pattern = 'test/**/*_spec.rb'
  end

  namespace :all do
    desc 'Run tests quickly, but also reset db'
    task :db => %w[db:test:prepare spec:all]
  end

  # specs in sub-folders
  Rails::SubTestTask.new(models: 'test:prepare') do |t|
    t.libs << 'test'
    t.pattern = 'test/models/**/*_spec.rb'
  end

  Rails::SubTestTask.new(helpers: 'test:prepare') do |t|
    t.libs << 'test'
    t.pattern = 'test/helpers/**/*_spec.rb'
  end

  Rails::SubTestTask.new(units: 'test:prepare') do |t|
    t.libs << 'test'
    t.pattern = 'test/{models,helpers,unit}/**/*_spec.rb'
  end

  Rails::SubTestTask.new(controllers: 'test:prepare') do |t|
    t.libs << 'test'
    t.pattern = 'test/controllers/**/*_spec.rb'
  end

  Rails::SubTestTask.new(mailers: 'test:prepare') do |t|
    t.libs << 'test'
    t.pattern = 'test/mailers/**/*_spec.rb'
  end

  Rails::SubTestTask.new(functionals: 'test:prepare') do |t|
    t.libs << 'test'
    t.pattern = 'test/{controllers,mailers,functional}/**/*_spec.rb'
  end

  Rails::SubTestTask.new(integration: 'test:prepare') do |t|
    t.libs << 'test'
    t.pattern = 'test/integration/**/*_spec.rb'
  end
end
Rake::Task[:test].enhance{ Rake::Task['spec:all'].invoke }
