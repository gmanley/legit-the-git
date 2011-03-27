# Copyright (c) 2011 Grayson Manley
# Licensed under the MIT license: http://www.opensource.org/licenses/mit-license

require 'grit'
require 'legit-the-git/command'

module LegitGit
  module Accurev
    class Commit

      def initialize(repository, commit_object)
        @command = Command.new
        commit!(commit_object, repository)
      end

      def commit!(commit_object, repository)
        commit_object.each do |commit|
          $stdout.puts "\e[\033[0;36mSyncing Commit \e[\033[0;32m#{commit.id_abbrev}\e[0m\n\e[\033[0;33m#{commit.message}\e[0m"
          commit.show.each do |diff|
            case
            when diff.new_file # Accurev add, then keep
              puts "New file detected"
              @command.add("#{repository.working_dir}/#{diff.a_path}")
              @command.keep("#{repository.working_dir}/#{diff.a_path}", commit.message)
            when diff.deleted_file # accurev defunct
              puts "Deleted file detected"
              @command.defunct("#{repository.working_dir}/#{diff.a_path}", commit.message)
            when diff.renamed_file # accurev defunct a_path, then add b_path (then keep)
              puts "Renamed file detected"
              @command.defunct("#{repository.working_dir}/#{diff.a_path}", commit.message)
              @command.add("#{repository.working_dir}/#{diff.b_path}")
              @command.keep("#{repository.working_dir}/#{diff.b_path}", commit.message)
            else # Accurev regular keep
              puts "Modified file detected"
              @command.keep("#{repository.working_dir}/#{diff.a_path}", commit.message)
            end
          end
        end
      end
    end
  end
end