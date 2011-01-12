# Copyright (c) 2011 Grayson Manley
# Licensed under the MIT license: http://www.opensource.org/licenses/mit-license

module AccuHook
  module Accurev
    class Commit
      require File.dirname(__FILE__) + "/command"

      def initialize(repository, commit_object)
        @command = AccuHook::Accurev::Command.new
        puts commit_object.inspect
        commit!(commit_object)
      end

      def commit!(commit_object)
        commit_object.each do |commit|
          commit.show.each do |diff|
            case
            when diff.new_file # Accurev add, then keep
              @command.add(diff.a_path)
              @command.keep(diff.a_path, commit.message)
            when diff.deleted_file # accurev defunct
              @command.defunct(diff.a_path, commit.message)
            when diff.renamed_file # accurev defunct a_path, then add b_path (then keep)
              puts "Renamed file detected"
              @command.defunct(diff.a_path, commit.message)
              @command.add(diff.b_path)
              @command.keep(diff.b_path, commit.message)
            else # Accurev regular keep
              puts "Modified file detected"
              @command.keep(diff.a_path, commit.message)
            end
          end
        end
      end
    end
  end
end