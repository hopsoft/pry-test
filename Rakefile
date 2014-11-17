require "bundler/gem_tasks"

task :default => [:test]

desc "Runs the test suite."
task :test do
  exec File.expand_path("../bin/pry-test", __FILE__)
end

