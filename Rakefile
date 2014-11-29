require "bundler/gem_tasks"

task :default => [:test]

desc "Runs the test suite."
task :test do
  env = ENV.to_hash.merge("PRY_TEST_COVERAGE" => "true")
  exec env, File.expand_path("../bin/pry-test --disable-pry", __FILE__)
end

