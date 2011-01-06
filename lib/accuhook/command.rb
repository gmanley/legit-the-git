module AccuHook
  module Accurev
    class Command
      require "shellwords"

      def login
        begin
          username = ask("Accurev username:  ")
          password = ask("Accurev password:  ") { |q| q.echo = "*" }
          execute("login -n #{username} #{password}")
          if Dir["#{ENV['HOME']}/.accurev/session_*"].empty?
            raise
          end
        rescue
          login
        end
      end

      def add(file_path)
        if File.directory?(file_path) # Recursively add directory (`accurev add -x -R {Dir}`)
          execute("add -x -R #{file_path}")
        else  # Add single file (`accurev add {File}`)
          execute("accurev add #{file_path}")
        end
      end

      def keep(file_path, message)
        execute("accurev keep -c #{message} #{file_path}")
      end

      def defunct(file_path, message)
        execute("accurev defunct -c #{@last_commit_message} #{diff.a_path}")
      end

      private
      def execute(command)
        args = Shellwords.split(command)
        escaped_args = args.map {|arg| Shellwords.escape(arg)}
        sub_command = Shellwords.join(escaped_args)
        system("accurev #{sub_command}")
      end
    end
  end
end