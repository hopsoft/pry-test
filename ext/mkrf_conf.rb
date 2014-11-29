# based on instructions here:
# http://en.wikibooks.org/wiki/Ruby_Programming/RubyGems#How_to_install_different_versions_of_gems_depending_on_which_version_of_ruby_the_installee_is_using
require "rubygems"
require "rubygems/command.rb"
require "rubygems/dependency_installer.rb"

begin
  Gem::Command.build_args = ARGV
  rescue NoMethodError
end

installer = Gem::DependencyInstaller.new

begin
  if RUBY_ENGINE =~ /jruby/i
    puts "Engine is jruby... skip installation of pry gems."
  else
    puts "Installing pry gems..."
    installer.install "pry"
    installer.install "pry-stack_explorer"
    installer.install "pry-rescue"
  end
rescue Exception => e
  puts e.message
  puts e.backtrace.join("\n")
  exit 1
end

# create dummy rakefile to indicate success
File.open(File.expand_path("../Rakefile", __FILE__), "w") do |file|
  file.write("task :default\n")
end

exit 0
