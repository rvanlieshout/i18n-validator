# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "i18n-validator/version"

Gem::Specification.new do |s|
  s.name        = "i18n-validator"
  s.version     = I18n::Validator::VERSION
  s.authors     = ["Rene van Lieshout"]
  s.email       = ["rene@bluerail.nl"]
  s.homepage    = "http://www.bluerail.nl"
  s.summary     = %q{I18n completeness validator}
  s.description = %q{Validats your I18n completness}

  s.rubyforge_project = "i18n-validator"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_runtime_dependency "i18n"
  s.add_development_dependency "rspec"
end
