require 'rake'

Gem::Specification.new do |spec|
  spec.name = 'micro_test'
  spec.version = '0.1.7'
  spec.license = 'MIT'
  spec.homepage = 'http://hopsoft.github.com/micro_test/'
  spec.summary = "Ruby's no-nonsense testing framework."
  spec.description = <<-DESC
    Testing frameworks often lose their focus and become an end unto themselves.
    MicroTest avoids this pitfall with a relentless focus on simplicity.
  DESC

  spec.authors = ['Nathan Hopkins']
  spec.email = ['natehop@gmail.com']

  spec.add_dependency 'slop'
  spec.add_dependency 'pry'
  spec.add_dependency 'pry-stack_explorer'

  spec.files = FileList['lib/**/*.rb', 'bin/*', 'test/**/*.rb', '[A-Z]*'].to_a
  spec.executables << "mt"
end
