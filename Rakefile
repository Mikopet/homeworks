require 'rake'
require 'rspec/core/rake_task'

libdir = File.expand_path(File.dirname(__FILE__))
["#{libdir}/src", "#{libdir}/lib"].each do |dir|
  $LOAD_PATH.unshift(dir) unless $LOAD_PATH.include?(dir)
end

RSpec::Core::RakeTask.new(:spec) do |t|
    t.pattern = Dir.glob('spec/**/*_spec.rb')
    t.rspec_opts = '--format documentation'
    # t.rspec_opts << ' more options'
    # t.rcov = true
end

desc "Start the tests"
task default: %w[spec]

desc "Run the desired code version with the given datafile"
task :run, %i[version filename] do |t, args|
  require 'pp'

  if args.version == 'v1'
    require 'v1/sensor_evaluator'

    log = File.read("data/#{args.filename}.txt")
    se = SensorEvaluator.new(log)

    pp se.evaluate
  end
end

desc "Generate sample test files in default format"
task :generate, %i[sensor_count line_count] do |t, args|
  sensors, lines = args.sensor_count.to_i || 5, args.line_count.to_i || 100

  out_file = File.new("data/#{sensors}_#{lines}.txt", "w")

  require 'parser'
  require 'securerandom'

  refs = {
    thermometer: rand(-100..100.0).round(2),
    humidity: rand(1..100.0).round(2),
    monoxide: rand(4..10).round(2)
  }
  out_file.puts("reference #{refs[:thermometer]} #{refs[:humidity]} #{refs[:monoxide]}")

  sensors.times do
    sensor = Parser::SENSOR_TYPES.sample
    out_file.puts("#{sensor} #{sensor[0..3]}-#{SecureRandom.uuid[0..7]}")
    sensor_precisity = refs[sensor]-rand(0..5)..refs[sensor]+rand(0..5)

    lines.times do
      value = rand(sensor_precisity).round(2)
      out_file.puts("#{DateTime.now.iso8601} #{value}")
    end
  end

  out_file.close
end

desc "Runs the benchmarks on all code version with all data files in data folder"
task :benchmark do
end
