# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'active_admin/duplicatable/version'

Gem::Specification.new do |spec|
  spec.name          = "active_admin-duplicatable"
  spec.version       = Activeadmin::Duplicatable::VERSION
  spec.authors       = ["Charles Maresh"]
  spec.email         = ["charles.maresh@orm-tech.com"]
  spec.summary       = %q{Simple duplication of ActiveAdmin resources}
  spec.description   = <<DESC
Allow user duplication of ActiveAdmin resources using the power of the Amoeba
gem. Resource duplication can be performed by either persisting the model and its
relations, or by pre-filling a new resource's form fields.
DESC
  spec.homepage      = "https://github.com/zorab47/active_admin-duplicatable"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "activeadmin"
  spec.add_dependency "amoeba", ">= 2.0.0"

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"

  # required for active admin
  spec.add_development_dependency "sass-rails"
end
