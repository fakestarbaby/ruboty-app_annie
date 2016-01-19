# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ruboty/app_annie/version'

Gem::Specification.new do |spec|
  spec.name          = "ruboty-app_annie"
  spec.version       = Ruboty::AppAnnie::VERSION
  spec.authors       = ["fakestarbaby"]
  spec.email         = ["fakestarbaby@gmail.com"]
  spec.summary       = %q{Manage App Annie via Ruboty.}
  spec.description   = spec.summary
  spec.homepage      = "https://github.com/fakestarbaby/ruboty-app_annie"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency "ruboty"
  spec.add_dependency "anego"

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
end
