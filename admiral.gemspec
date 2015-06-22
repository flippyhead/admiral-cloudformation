# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "admiral-cloudformation"
  spec.version       = '0.0.4'
  spec.authors       = ["Peter T. Brown"]
  spec.email         = ["p@ptb.io"]
  spec.description   = %q{An Admiral module that implements tasks for wielding AWS CloudFormation templates. Use it to manage CloudFormation templates and their parameters.}
  spec.summary       = %q{A command line tool for wielding cloudformation templates.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"

  spec.add_dependency 'aws-sdk', '< 2'
  spec.add_dependency 'thor', '~> 0.19'
  spec.add_dependency 'admiral'
end
