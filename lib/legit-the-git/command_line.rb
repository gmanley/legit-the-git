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
        installation = LegitGit::Installation.new(Dir.pwd)
        installation.install
        puts 'Successfully installed!'
        puts "Run #{File.basename $0} --help for usage."
        exit 0
      when "uninstall"
        installation = LegitGit::Installation.new(Dir.pwd)
        installation.uninstall
        puts 'Successfully uninstalled!'
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
    # Refactor!

    def initialize(repo_path)
      @repository = Grit::Repo.new(repo_path)
      @accurev_repo = File.join(repo_path, '.git', 'accurev.git')

      @accurev_hooks = File.join(repo_path, '.git', 'accurev.git', 'hooks')
      @repo_hooks = File.join(repo_path, '.git', 'accurev.git', 'hooks')
    end

    def install
      @repository do |repo|
        repo.fork_bare(@accurev_repo, :shared => false, :mirror => true)
        repo.remote_add("accurev", @accurev_repo)
      end

      FileUtils.mkdir_p(@accurev_hooks, @repo_hooks)

      FileUtils.install(File.join(File.dirname(__FILE__), "hooks", "post-commit"), @repo_hooks, :mode => 0755)
      FileUtils.install(File.join(File.dirname(__FILE__), "hooks", "pre-receive"), @accurev_hooks, :mode => 0755)
    end

    def uninstall(repo_path)
      unless repository.remotes.select {|r| r.name =~ /accurev/}.empty?
        git = Grit::Git.new(Dir.pwd)
        git.native("remote rm accurev")
      end

      FileUtils.rm_rf(@accurev_repo, File.join(@repo_hooks, "hooks", "post-commit"))
    end
  end
end