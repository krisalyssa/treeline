# treeline.gemspec
# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "treeline/version"

Gem::Specification.new do |s|
  s.name        = "treeline"
  s.version     = Treeline::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Craig S. Cottingham"]
  s.email       = ["craig.cottingham@gmail.com"]
  s.homepage    = "https://github.com/CraigCottingham/treeline"
  s.summary     = %q{Turns indented-line input into a tree structure.}
  s.description = %q{Turns indented-line input into a tree structure.}
  
  # s.add_development_dependency "rspec"

  # s.rubyforge_project = ""

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
