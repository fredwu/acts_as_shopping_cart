# -*- encoding: utf-8 -*-
require File.dirname(__FILE__) + "/lib/acts_as_shopping_cart/version"
require "date"

Gem::Specification.new do |s|
  s.name              = "acts_as_shopping_cart"
  s.version           = ActsAsShoppingCart::VERSION
  s.date              = Date.today.to_s
  s.authors           = ["David Padilla", "Fred Wu"]
  s.email             = ["david.padilla@crowdint.com", "ifredwu@gmail.com"]
  s.summary           = %q{A simple shopping cart implementation for Rails.}
  s.description       = %q{A simple shopping cart implementation for Rails.}
  s.homepage          = %q{http://github.com/dabit/acts_as_shopping_cart}
  s.extra_rdoc_files  = ["README.md"]
  s.rdoc_options      = ["--charset=UTF-8"]
  s.require_paths     = ["lib"]
  s.rubyforge_project = s.name

  s.files         = `git ls-files --  lib/* README.md LICENSE`.split("\n")
  s.require_paths = ["lib"]

  s.add_runtime_dependency(%q<activerecord>, ["~> 3.0.0"])

  s.add_development_dependency(%q<sqlite3>, [">= 0"])
  s.add_development_dependency(%q<rspec>, ["~> 2.1.0"])
end