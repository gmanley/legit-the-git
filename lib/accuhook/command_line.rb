# Copyright (c) 2011 Grayson Manley
# Licensed under the MIT license: http://www.opensource.org/licenses/mit-license

require 'optparse'
require 'ostruct'
require 'fileutils'

module AccuHook
  class CommandLine
    # Parse command line options and execute
    def self.execute(args)
      options = parse_options(args)

      case options.command
      when :install
        ret_val = AccuHook::Installation.new(options.path)
        exit 0
      when :version
        puts 'Version 0.0.1'
        exit 0
      end
    end

    private
    def self.parse_options(args)
      options = OpenStruct.new
      options.command = :help
      options.path = Dir.pwd

      opts = OptionParser.new do |opts|
        opts.banner = "Usage #{File.basename $0} [options]"
        opts.on_head("-i","--install", "Install Accurev Git hook in current dir") { options.command = :install }
        opts.on("-p","--path=[path]", "Install Accurev Git hook to specified path") { |path| options.path = path }
        opts.on_tail("--version", "Print current version and exit") {options.command = :version }
        opts.on_tail("-h","--help", "Print help message")
      end
      opts.parse!(args)
      (puts opts and exit 0) if options.command == :help
      options
    end
  end

  class Installation

    def initialize(repo)
      install(repo)
    end

    def install(repo)
      repo_hooks_dir = File.join(repo, '.git', 'hooks')
      FileUtils.mkdir repo_hooks_dir unless File.exist? repo_hooks_dir

      FileUtils.install(File.join(File.dirname(__FILE__), "hooks", "post-commit"), repo_hooks_dir, :mode => 0755)
      FileUtils.install(File.join(File.dirname(__FILE__), "hooks", "pre-commit"), repo_hooks_dir, :mode => 0755)
    end
  end
end