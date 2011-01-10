# Copyright (c) 2011 Grayson Manley
# Licensed under the MIT license: http://www.opensource.org/licenses/mit-license

module AccuHook
  module Accurev
    class Command
      require "shellwords"

      def add(file_path)
        if File.directory?(file_path) # Recursively add directory (`accurev add -x -R {Dir}`)
          execute("add -x -R \"#{file_path}\"")
        else  # Add single file (`accurev add {File}`)
          execute("add \"#{file_path}\"")
        end
      end

      def keep(file_path, message)
        execute("keep -c \"#{message}\" \"#{file_path}\"")
      end

      def defunct(file_path, message)
        execute("defunct -c \"#{@last_commit_message}\" \"#{diff.a_path}\"")
      end

      private
      def execute(command)
        args = Shellwords.split(command)
        escaped_args = args.map {|arg| Shellwords.escape(arg)}
        sub_command = Shellwords.join(escaped_args)
        #puts "Running accurev #{sub_command}"
        system("accurev #{sub_command}")
      end
    end
  end
end