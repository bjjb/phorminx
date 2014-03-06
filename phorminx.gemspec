# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'phorminx/version'

Gem::Specification.new do |spec|
  spec.name          = "phorminx"
  spec.version       = Phorminx::VERSION
  spec.authors       = ["JJ Buckley"]
  spec.email         = ["jj@bjjb.org"]
  spec.summary       = "PHunky ORM INspector/eXtractor"
  spec.summary       = <<-DESC
Helps you to poke around in a bloated Rails app and extract the important
parts of it.
  DESC
  spec.homepage      = "http://github.com/bjjb/phorminx"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest"
  spec.add_development_dependency "sqlite3"

  spec.add_dependency "activerecord"
end
