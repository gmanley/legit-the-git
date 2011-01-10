# Copyright (c) 2011 Grayson Manley
# Licensed under the MIT license: http://www.opensource.org/licenses/mit-license

Gem::Specification.new do |s|
  s.name                = "Legit-the-Git"
  s.version             = "0.0.2"

  s.summary             = "Git accurev bridge"
  s.description         = "Git hooks to help keep accurev and git in sync"
  s.homepage            = "http://github.com/gmanley/Legit-the-Git"
  s.license             = "MIT"
  s.authors             = ["Grayson Manley"]
  s.email               = "gray.manley@gmail.com"
  s.default_executable  = "accuhook"
  s.executables         = ["accuhook"]
  s.files               = [
    "LICENSE.txt",
    "legit-the-git.gemspec",
    "bin/accuhook",
    "lib/accuhook.rb",
    "lib/accuhook/command.rb",
    "lib/accuhook/command_line.rb",
    "lib/accuhook/commit.rb",
    "lib/accuhook/hooks/post-commit",
    "lib/accuhook/hooks/pre-commit"
  ]
  s.add_runtime_dependency("grit", ["~> 2.3.0"])
end