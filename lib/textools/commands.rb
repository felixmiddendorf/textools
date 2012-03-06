require "thor"
require 'thor/group'

module Textools

  class App < Thor
    include Thor::Actions

    desc "create PROJECT_NAME", "create a new LaTeX project"
    def create(name)
      # create containing directory
      inside name do |folder|
        [".gitignore","clean.bat","clean.rb","clean.sh"].each do |file|
          copy_file file, File.join(folder, file)
        end
      end
    end

    private

    # set the starting point of the templates search to the lib/textools/templates folder
    def self.source_root
      File.join(File.dirname(__FILE__),"templates")
    end

  end

end