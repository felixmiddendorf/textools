require 'thor'
require 'thor/group'

module Textools

  class App < Thor
    include Thor::Actions

    desc 'create PROJECT_NAME', 'create a new LaTeX project'
    method_options :working_directory => '.'
    def create(name)
      # workaround as default options does not work
      parent_directory = options[:working_directory] || '.'

      directory = File.join(parent_directory,name)

      # create project directory
      empty_directory(directory)

      # copy required files
      ['.gitignore', 'clean.bat', 'clean.sh'].each do |file|
        copy_file file,File.join(directory,file)
      end

      # directories
      empty_directory(File.join(directory, "images"))
      empty_directory(File.join(directory, "includes"))

      # create containing directory
      inside(File.join(parent_directory,name), :verbose => true) do |folder|

        # initialize git repository
        run("git init")
        # add all files to the staging area
        run("git add .")

      end
    end

    desc 'clean','cleans the current LaTeX project'
    method_options :working_directory => "."
    def clean
      # workaround as default options does not work
      parent_directory = options[:working_directory] || '.'

      require "fileutils"
      %w{*.aux *.bbl *.log *.pdf *.pgf *.dvi *.synctex* *.toc *.blg}.each do |pattern|
        Dir.glob(File.join(parent_directory,pattern)).each do |file|
          remove_file file
        end
      end
    end

    private

    # set the starting point of the templates search to the lib/textools/templates folder
    def self.source_root
      File.join(File.dirname(__FILE__),'templates')
    end

  end

end