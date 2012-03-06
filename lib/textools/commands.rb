require "thor"

module Textools

  class App < Thor
    include Thor::Actions

    desc "create PROJECT_NAME", "create a new LaTeX project"
    def generate(name)
      # create containing directory
      inside name do |folder|
        copy_file ".gitignore",File.join(folder,".gitignore")
      end
    end


    # set the starting point of the templates search to the lib/textools/templates folder
    def self.source_root
      File.join(File.dirname(__FILE__),"templates")
    end

end