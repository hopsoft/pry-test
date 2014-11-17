require File.expand_path("../lib/pry-test/version", __FILE__)

Gem::Specification.new do |spec|
  spec.name                  = "pry-test"
  spec.version               = PryTest::VERSION
  spec.license               = "MIT"
  spec.homepage              = "https://github.com/hopsoft/pry-test"
  spec.summary               = "A testing framework that supports debugging test failures and errors when they happen."
  spec.description           = "A testing framework that supports debugging test failures and errors when they happen."

  spec.authors               = ["Nathan Hopkins"]
  spec.email                 = ["natehop@gmail.com"]

  spec.required_ruby_version = ">= 1.9.2"
  spec.extensions            = "ext/mkrf_conf.rb"
  spec.add_dependency "os"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "coveralls"

  # spec.add_dependency "pry"
  # spec.add_dependency "pry-stack_explorer"
  # spec.add_dependency "pry-rescue"
  # see: ext/mkrf_conf.rb for how we install the pry dependencies.
  # also see:
  # http://en.wikibooks.org/wiki/Ruby_Programming/RubyGems#How_to_install_different_versions_of_gems_depending_on_which_version_of_ruby_the_installee_is_using

  spec.files = Dir[
    "ext/mkrf_conf.rb",
    "lib/**/*.rb",
    "lib/**/*.erb",
    "bin/*",
    "[A-Z].*"
  ]
  spec.test_files = Dir["test/**/*.rb"]
  spec.executables << "pry-test"
end
