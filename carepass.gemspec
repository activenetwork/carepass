# -*- encoding: utf-8 -*-
require File.expand_path('../lib/carepass/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["john ramos"]
  gem.email         = ["john.ramos@active.com"]
  gem.description   = %q{provides an interface with the carepass synch API}
  gem.summary       = %q{interfaces with the carepass synch API}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "carepass"
  gem.require_paths = ["lib"]
  gem.version       = Carepass::VERSION

  gem.add_runtime_dependency 'httparty'
end
