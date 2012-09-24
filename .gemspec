require 'rake'

Gem::Specification.new do |spec|
  spec.name = 'micro_test'
  spec.version = '0.0.1'
  spec.license = 'MIT'
  spec.homepage = 'https://github.com/hopsoft/micro_test'
  spec.summary = 'A tiny testing script.'
  spec.description = <<-DESC
    A testing "framework" in 45 lines.
  DESC

  spec.authors = ['Nathan Hopkins']
  spec.email = ['natehop@gmail.com']

  spec.files = FileList['lib/**/*.rb', 'bin/*', '[A-Z]*', 'spec/**/*.rb'].to_a
end
