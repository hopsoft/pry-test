require 'rake'
require File.join(File.dirname(__FILE__), "lib", "micro_test", "version")

Gem::Specification.new do |spec|
  spec.name = 'micro_test'
  spec.version = MicroTest::VERSION
  spec.license = 'MIT'
  spec.homepage = 'http://hopsoft.github.com/micro_test/'
  spec.summary = "MicroTest is Ruby's no-nonsense testing framework. Its also known as microtest, micro test, & micro_test."
  spec.description = <<-DESC
    The Sinatra of testing frameworks.

    Give MicroTest a try and discover the following.

    * simplicity - a tiny API with only 4 methods
    * pry integration - debugging tests is a cinch
    * asynchronous - faster multithreaded test runs

    Happy testing.
  DESC

  spec.authors = ['Nathan Hopkins']
  spec.email = ['natehop@gmail.com']

  spec.required_ruby_version = '>= 1.9.2'
  spec.extensions = 'ext/mkrf_conf.rb'
  spec.add_dependency 'os'

  # spec.add_dependency 'pry'
  # spec.add_dependency 'pry-stack_explorer'
  # see: ext/mkrf_conf.rb for how we install the pry dependencies.
  # also see:
  # http://en.wikibooks.org/wiki/Ruby_Programming/RubyGems#How_to_install_different_versions_of_gems_depending_on_which_version_of_ruby_the_installee_is_using

  spec.files = FileList[
    'ext/mkrf_conf.rb',
    'lib/**/*.rb',
    'bin/*',
    'test/**/*.rb',
    'LICENSE.txt',
    'README.md'
  ].to_a
  spec.executables << "mt"
end
