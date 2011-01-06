begin
  require 'rubygems'
  require 'grit'
  require 'highline/import'
rescue LoadError
  require File.dirname(__FILE__) + "/../vendor/grit/lib/grit"
  require File.dirname(__FILE__) + "/../vendor/highline/lib/highline"
end
require File.dirname(__FILE__) + '/accuhook/command_line'
require File.dirname(__FILE__) + '/accuhook/hook'