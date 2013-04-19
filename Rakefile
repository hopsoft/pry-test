require "bundler/gem_tasks"

task :default => [:test]

desc "Runs the test suite."
task :test do
  exec File.join(File.expand_path("../bin", __FILE__), "mt")
end

