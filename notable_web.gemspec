# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'notable_web/version'

Gem::Specification.new do |spec|
  spec.name          = "notable_web"
  spec.version       = NotableWeb::VERSION
  spec.authors       = ["Andrew Kane"]
  spec.email         = ["andrew@chartkick.com"]
  spec.summary       = %q{A web interface for Notable}
  spec.description   = %q{A web interface for Notable}
  spec.homepage      = "https://github.com/ankane/notable_web"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "notable"
  spec.add_dependency "groupdate"
  spec.add_dependency "chartkick"
  spec.add_dependency "kaminari"
  spec.add_dependency "public_suffix"

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
