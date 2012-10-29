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

  spec.add_dependency 'slop'
  spec.add_dependency 'pry'
  spec.add_dependency 'pry-stack_explorer'

  spec.files = FileList['lib/**/*.rb', 'bin/*', 'test/**/*.rb', '[A-Z]*', 'LICENSE.txt', 'README.md'].to_a
  spec.executables << "mt"
end
