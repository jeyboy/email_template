# -*- encoding: utf-8 -*-
require File.expand_path('../lib/email-template/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Jenua Boiko"]
  gem.email         = ["jeyboy1985@gmail.com"]
  gem.description   = %Q{Emails templating}
  gem.summary       = %Q{Emails templating}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "email_template"
  gem.require_paths = ["lib"]
  gem.version       = EmailTemplate::VERSION
  gem.rubygems_version = %q{1.8.6}

  gem.add_dependency("rails", ">= 3.0.0")
end

