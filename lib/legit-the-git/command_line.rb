# Copyright (c) 2011 Grayson Manley
# Licensed under the MIT license: http://www.opensource.org/licenses/mit-license

require 'rubygems'
require 'legit-the-git'
require 'fileutils'

module LegitGit
  class CommandLine

    # Parse command line options and execute
    def self.execute(args)

      help = <<-EOS
Usage #{File.basename $0} [--version] [--help] <command>

Commands:
  install      Install the Accurev Git hook into the current directory

Workflow:
  Once installed commit your changes like usual. When you would like to push
  those changes to accurev, just run `git push accurev`. This will sync new
  commits from the current branch to the accurev server. Just make sure you
  are logged into accurev!

EOS

      case args
      when "install"
        ret_val = LegitGit::Installation.new(Dir.pwd)
        exit 0
      when "--version"
        puts "0.0.4"
        exit 0
      else
        puts help
      end
    end
  end

  class Installation

    def initialize(repo)
      install(repo)
    end

    def install(repo_path)
      repository = Grit::Repo.new(repo_path)

      repo_hooks = File.join(repo_path, '.git', 'hooks')
      accurev_repo = File.join(repo_path, '.git', 'accurev.git')
      accurev_hooks = File.join(repo_path, '.git', 'accurev.git', 'hooks')

      repository.fork_bare(accurev_repo, :shared => false, :mirror => true)
      repository.remote_add("accurev", accurev_repo)

      FileUtils.mkdir accurev_hooks unless File.exist? accurev_hooks
      FileUtils.mkdir repo_hooks unless File.exist? repo_hooks

      FileUtils.install(File.join(File.dirname(__FILE__), "hooks", "post-commit"), repo_hooks, :mode => 0755)
      FileUtils.install(File.join(File.dirname(__FILE__), "hooks", "pre-receive"), accurev_hooks, :mode => 0755)
    end
  end
end