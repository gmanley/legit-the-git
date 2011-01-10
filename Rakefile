begin; require 'rubygems'; rescue LoadError; end
require 'rake'
require 'rake/gempackagetask'

spec = eval(File.read(File.join(File.dirname(__FILE__),'legit-the-git.gemspec')))
Rake::GemPackageTask.new(spec) do |p|
  p.gem_spec = spec
end