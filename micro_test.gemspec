require 'rake'
require File.join(File.dirname(__FILE__), "lib", "micro_test", "version")

Gem::Specification.new do |spec|
  spec.name = 'micro_test'
  spec.version = MicroTest::VERSION
  spec.license = 'MIT'
  spec.homepage = 'http://hopsoft.github.com/micro_test/'
  spec.summary = "The Sinatra of testing frameworks."
  spec.description = <<-DESC
    Testing frameworks often lose their focus and become an end unto themselves.
    MicroTest avoids this pitfall with a relentless focus on simplicity.
  DESC

  spec.authors = ['Nathan Hopkins']
  spec.email = ['natehop@gmail.com']

  spec.required_ruby_version = '>= 1.9'
  spec.extensions = 'ext/mkrf_conf.rb'
  spec.add_dependency 'celluloid'

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
