# Copyright (c) 2011 Grayson Manley
# Licensed under the MIT license: http://www.opensource.org/licenses/mit-license

Gem::Specification.new do |s|
  s.name                = "Legit-the-Git"
  s.version             = "0.0.1"

  s.summary             = "Git hooks to help keep accurev and git in sync."
  s.description         = "Git hooks to help keep accurev and git in sync."
  s.homepage            = "http://github.com/gmanley/Legit-the-Git"
  s.license             = "MIT"
  s.authors             = ["Grayson Manley"]
  s.email               = "gray.manley@gmail.com"
  s.default_executable  = "accuhook"
  s.executables         = ["accuhook"]
  s.files               = [
    "LICENSE.txt",
    "legit-the-git.gemspec",
    "bin/*",
    "lib/**/*"
  ]
  s.add_runtime_dependency "grit", "~> 2.3.0"
end