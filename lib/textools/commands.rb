require 'thor'
require 'thor/group'

module Textools

  class App < Thor
    include Thor::Actions

    desc 'create PROJECT_NAME', 'create a new LaTeX project'
    method_options :working_directory => '.'
    def create(name)
      parent_directory = options[:working_directory] || '.'

      # create containing directory
      inside File.join(parent_directory,name) do |folder|
        ['clean.bat','clean.rb','clean.sh'].each do |file|
          copy_file "templates/#{file}", File.join(folder, file)
        end
      end
    end

    private

    # set the starting point of the templates search to the lib/textools/templates folder
    def self.source_root
      File.dirname(__FILE__)
    end

  end

end