# -*- encoding: utf-8 -*-
require File.expand_path('../lib/cap_share/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["andyl"]
  gem.email         = ["andy@r210.com"]
  gem.description   = %q{Reusable capistrano recipes}
  gem.summary       = %q{Basic tasks, package installations}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "cap_share"
  gem.require_paths = ["lib"]
  gem.version       = CapShare::VERSION
  gem.add_dependency('capistrano_colors')
end
