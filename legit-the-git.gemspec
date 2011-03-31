# -*- encoding: utf-8 -*-
require File.expand_path("../lib/legit-the-git/version", __FILE__)

Gem::Specification.new do |s|
  s.name                = "legit-the-git"
  s.version             = LegitGit::VERSION
  s.platform            = Gem::Platform::RUBY

  s.authors             = ["Grayson Manley"]
  s.email               = ["gray.manley@gmail.com"]

  s.homepage            = "http://github.com/gmanley/legit-the-git"
  s.summary             = "Git accurev bridge"
  s.description         = "Git hooks to help keep accurev and git in sync"
  s.license             = "MIT"

  s.files               = `git ls-files`.split("\n")
  s.default_executable  = "legit-the-git"
  s.executables         = ["legit-the-git"]
  s.require_paths       = ["lib"]

  s.add_runtime_dependency("grit", ["~> 2.3.0"])
end