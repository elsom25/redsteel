require 'reek/rake/task'
Reek::Rake::Task.new do |t|
  t.source_files = 'app'
  t.verbose = false
  t.fail_on_error = false
end

namespace :quality do
  desc 'run all code analyzing tools (reek, flog, flay, rails_best_practices)'
  task :all => ['reek', 'flog', 'flay', 'rails_best_practices'] do
    message :info, 'have been running all code analyzing tools'
  end

  desc 'run reek and find code smells'
  task :reek do
    message :info, 'Running reek and find code smells `rake quality:reek`'
    Rake::Task['reek'].invoke
  end

  desc 'run rails_best_practices and inform about found issues `rake quality:rails_best_practices`'
  task :rails_best_practices do
    message :info, 'Running rails_best_practices and inform about found issues'
    app_root = Rake.application.original_dir
    output_file = File.join(app_root, 'tmp', 'rails_best_practices.html')
    analyzer = RailsBestPractices::Analyzer.new(app_root, {
      'format' => 'html',
      'with-textmate' => true,
      'output-file' => output_file
    })
    analyzer.analyze
    analyzer.output
    `open #{output_file}`
    message :error, 'Bad practices found in Rails app' if analyzer.runner.errors.size > 0
  end

  namespace :flog do
    require 'flog_cli'
    options = { continue: true, details: true, group: true }
    dirs = %w(app)

    desc 'Analyze total code complexity with flog'
    task :total do
      message :info, 'Running flog total complexity `rake quality:flog`'
      threshold = 1000
      flog = FlogCLI.new options
      flog.flog dirs

      score = flog.total_score
      flog.report # wipes everything

      message :error, "OMG What a confusing pile of crap! (#{score} > #{threshold})" if score > threshold
    end

    desc "Analyze for average code complexity"
    task :average do
      message(:info, 'Running flog average complexity')
      threshold = 25
      flog = FlogCLI.new options
      flog.flog dirs

      message :error, "Flog total too high! #{flog.average} > #{threshold}" if flog.average > threshold
    end

    desc "Analyze for individual code complexity"
    task :each do
      message(:info, 'Running flog individual complexity')
      threshold = 40
      flog = FlogCLI.new options
      flog.flog dirs

      bad_methods = flog.method_scores.select{ |name, score| score > threshold }
      bad_methods.sort{ |a,b| a[1] <=> b[1] }.each do |name, score|
        puts "%8.1f: %s" % [score, name]
      end

       message :error, "#{bad_methods.size} methods have a flog complexity > #{threshold}" unless bad_methods.empty?
    end
  end
  task flog: ['flog:total'] do
  end

  desc 'run flay and analyze code for structural similarities'
  task :flay do
    message :info, 'Running flay and and analyze code for structural similarities `rake quality:flay`'
    output = `flay #{FileList['lib/**/*.rb', 'app/**/*.rb'].join(' ')}`
    message :error, "Error #{$?}: #{output}" unless $? == 0
    message :info, output
  end
end
task quality: ['quality:all'] do
end

def message(type, message)
  set_color(type)
  puts message
  reset_color
end

def set_color(type)
  term = Term::ANSIColor
  colors = {info: term.green, error: term.red}
  puts colors[type]
end

def reset_color
  puts Term::ANSIColor.reset
end
