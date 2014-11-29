require File.expand_path("../lib/pry-test/version", __FILE__)

Gem::Specification.new do |gem|
  gem.name                  = "pry-test"
  gem.version               = PryTest::VERSION
  gem.license               = "MIT"
  gem.homepage              = "https://github.com/hopsoft/pry-test"
  gem.summary               = "A testing framework that supports debugging test failures and errors when they happen."
  gem.description           = "A testing framework that supports debugging test failures and errors when they happen."

  gem.authors               = ["Nathan Hopkins"]
  gem.email                 = ["natehop@gmail.com"]

  gem.required_ruby_version = ">= 1.9.2"
  gem.extensions            = "ext/mkrf_conf.rb"
  gem.add_dependency "os"
  gem.add_development_dependency "rake"
  gem.add_development_dependency "simplecov"
  gem.add_development_dependency "coveralls"

  # gem.add_dependency "pry"
  # gem.add_dependency "pry-stack_explorer"
  # gem.add_dependency "pry-rescue"
  # see: ext/mkrf_conf.rb for how we install the pry dependencies.
  # also see:
  # http://en.wikibooks.org/wiki/Ruby_Programming/RubyGems#How_to_install_different_versions_of_gems_depending_on_which_version_of_ruby_the_installee_is_using

  gem.files = Dir[
    "ext/mkrf_conf.rb",
    "lib/**/*.rb",
    "lib/**/*.erb",
    "bin/*",
    "[A-Z].*"
  ]
  gem.test_files = Dir["test/**/*.rb"]
  gem.executables << "pry-test"
end
