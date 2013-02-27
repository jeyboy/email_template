# -*- encoding: utf-8 -*-
require File.expand_path('../lib/email-template/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Jenua Boiko"]
  gem.email         = ["jeyboy1985@gmail.com"]
  gem.description   = %Q{Allows your users to edit e-mail templates}
  gem.summary       = %Q{Allows your users to edit e-mail templates. With Devise and Active Admin support (but you don't need them to start using email_template).}
  gem.homepage      = "https://github.com/jeyboy/email_template"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "email_template"
  gem.require_paths = ["lib"]
  gem.version       = EmailTemplate::VERSION
  gem.rubygems_version = %q{1.8.6}

  gem.add_dependency("rails", ">= 3.0.0")
end

