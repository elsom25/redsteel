namespace :test do
  Rails::TestTask.new(specs: 'test:prepare') do |t|
    t.pattern = 'test/**/*_spec.rb'
  end
end
Rake::Task[:test].enhance{ Rake::Task['test:specs'].invoke }
