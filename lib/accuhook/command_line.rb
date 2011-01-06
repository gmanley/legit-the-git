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

    rescue Grit::InvalidGitRepositoryError
      puts "Invalid Git repository:\n#{@options.path}"
      exit 1
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
    def install(path_or_repo)
      repo = parse_path path_or_repo

      repo_hooks_dir = File.join(repo.path,'hooks')
      FileUtils.mkdir hooks_dir unless File.exist? hooks_dir

      FileUtils.install(File.join(File.dirname(__FILE__), "hooks", "post-commit"), repo_hooks_dir, :mode => 0600)
    end

    def installed? (path_or_repo)
      File.file?(hooks_file(path_or_repo))
    end

    private
    def prompt(message)
      while true
        puts message+' [yn]'
        return 'yY'.include?($1) ? true : false if $stdin.gets.strip =~ /([yYnN])/
      end
    end
  end
end