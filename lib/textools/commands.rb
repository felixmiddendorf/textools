require 'thor'
require 'thor/group'
require "fileutils"

module Textools

  class App < Thor
    include Thor::Actions

    desc 'create PROJECT_NAME', 'create a new LaTeX project'
    method_options %w{working_directory -wd} => :string, %w{texlipse -t} => :boolean, %w{texniccenter -tc} => :boolean
    def create(name)
      # workaround as default options does not work
      parent_directory = options[:working_directory]
      if parent_directory
        directory = File.join(parent_directory,name)
      else
        directory = name
      end

      # create project directory
      empty_directory(directory)

      # copy required files
      ['.gitignore', 'clean.bat', 'clean.sh', "README"].each do |file|
        copy_file file,File.join(directory,file)
      end

      # directories
      empty_directory(File.join(directory, "images"))
      empty_directory(File.join(directory, "includes"))

      template("main.tex.erb",File.join(directory,"#{name}.tex"))
      template("header.tex.erb",File.join(directory,"header.tex"))
      template("content.tex.erb",File.join(directory,"content.tex"))

      if options.texlipse?
        @name = name
        template(".project.erb",File.join(directory,".project"))
        template(".texlipse.erb",File.join(directory,".texlipse"))
      elsif options.texniccenter?
        @name = name
        template("main.tcp.erb",File.join(directory,"#{name}.tcp"))
      end

      # create containing directory
      inside(directory, :verbose => true) do |folder|

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

      %w{*~ *.aux *.bbl *.blg *.lof *.log *.lot *.out *.pgf *.dvi *.synctex*
         *.tdo *.toc *.tps *.lol *.bak *.pdf}.each do |pattern|
        Dir.glob(File.join(parent_directory,pattern)).each do |file|
          remove_file file
        end
      end
    end

    desc 'version','prints the version of textools'
    def version
      say "Textools v#{Textools::VERSION}"
    end

    private

    # set the starting point of the templates search to the lib/textools/templates folder
    def self.source_root
      File.join(File.dirname(__FILE__),'templates')
    end

  end

end
