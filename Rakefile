require 'rake'
require 'rspec/core/rake_task'
 
RSpec::Core::RakeTask.new(:spec) do |t|
    t.pattern = Dir.glob('spec/**/*_spec.rb')
    t.rspec_opts = '--format documentation'
    # t.rspec_opts << ' more options'
    # t.rcov = true
end

task default: %w[spec]

desc "Start the tests"
task :test do
  rspec
end

desc "Run the desired code version with the given datafile"
task run: %w[version filename] do
end

desc "Runs the benchmarks on all code version with all data files in data folder"
task :benchmark do
end

desc "Generate sample test files in default format"
task :generate do
end

