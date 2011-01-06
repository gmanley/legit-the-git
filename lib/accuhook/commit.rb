module Accuhook
  module Accurev
    class Commit
      require "command"

      def initialize(repository)
        @command = Command.new
        last_git_commit = repository.commits.first
        @command.login if Dir["#{ENV['HOME']}/.accurev/session_*"].empty?
        commit(last_git_commit)
      end

      def commit(last_git_commit)
        last_git_commit.show.each do |diff|
          case
          when diff.new_file # Accurev add, then keep
            @commmand.add(diff.a_path)
            @command.keep(diff.a_path, last_git_commit.message)
          when diff.deleted_file # accurev defunct
            @command.defunct(diff.a_path, last_git_commit.message)
          when diff.renamed_file # accurev defunct a_path, then add b_path (then keep)
            puts "Renamed file detected"
            @command.defunct(diff.a_path, last_git_commit.message)
            @command.add(diff.b_path)
            @command.keep(diff.b_path, last_git_commit.message)
          else # Accurev regular keep
            puts "Modified file detected"
            @command.keep(diff.a_path, last_git_commit.message)
          end
        end
      end
    end
  end
end