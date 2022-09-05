require_relative "lib/notable_web/version"

Gem::Specification.new do |spec|
  spec.name          = "notable_web"
  spec.version       = NotableWeb::VERSION
  spec.summary       = "A web interface for Notable"
  spec.homepage      = "https://github.com/ankane/notable_web"
  spec.license       = "MIT"

  spec.author        = "Andrew Kane"
  spec.email         = "andrew@ankane.org"

  spec.files         = Dir["*.{md,txt}", "{app,config,lib}/**/*"]
  spec.require_path  = "lib"

  spec.required_ruby_version = ">= 2.7"

  spec.add_dependency "railties", ">= 6"
  spec.add_dependency "notable"
  spec.add_dependency "groupdate"
  spec.add_dependency "chartkick", ">= 4"
  spec.add_dependency "kaminari"
  spec.add_dependency "public_suffix"
end
