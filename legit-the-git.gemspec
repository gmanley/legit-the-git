# Copyright (c) 2011 Grayson Manley
# Licensed under the MIT license: http://www.opensource.org/licenses/mit-license

Gem::Specification.new do |s|
  s.name                = "legit-the-git"
  s.version             = "0.0.5"

  s.summary             = "Git accurev bridge"
  s.description         = "Git hooks to help keep accurev and git in sync"
  s.homepage            = "http://github.com/gmanley/legit-the-git"
  s.license             = "MIT"
  s.authors             = ["Grayson Manley"]
  s.email               = "gray.manley@gmail.com"
  s.default_executable  = "legit-the-git"
  s.executables         = ["legit-the-git"]
  s.files               = [
    "LICENSE.txt",
    "legit-the-git.gemspec",
    "bin/legit-the-git",
    "lib/legit-the-git.rb",
    "lib/legit-the-git/command.rb",
    "lib/legit-the-git/command_line.rb",
    "lib/legit-the-git/commit.rb",
    "lib/legit-the-git/hooks/post-commit",
    "lib/legit-the-git/hooks/pre-receive"
  ]
  s.add_runtime_dependency("grit", ["~> 2.3.0"])
end