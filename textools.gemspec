# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "textools/version"

Gem::Specification.new do |s|
  s.name        = "textools"
  s.version     = Textools::VERSION
  s.authors     = ["Simon Harrer"]
  s.email       = ["simon.harrer@gmail.com"]
  s.homepage    = "https://github.com/simonharrer/textools"
  s.summary     = %q{Command Line Tools for Generating and Maintaining LaTeX Projects.}
  s.description = s.summary

  s.rubyforge_project = "textools"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_runtime_dependency "thor"
end
