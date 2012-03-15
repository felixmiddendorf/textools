require 'test/unit'
require 'textools/commands'
require 'tmpdir'

module Textools

  class TestApp < Test::Unit::TestCase

    def test_create
      Dir.mktmpdir do |dir|

        project = 'test'

        App.new([],{:working_directory => dir}).create(project)

        project_folder = File.join(dir, project)

        # normal files
        assert_project_files project, project_folder
      end
    end

    def test_create_custom_template
      Dir.mktmpdir do |dir|

        custom_template = File.join(dir,"template.rb")
        additional_directory = "example_dir"
        File.open(custom_template,"w") do |f|
          f << "empty_directory File.join(@directory,'#{additional_directory}')"
        end

        project = 'test'

        App.new([],{:working_directory => dir, :template => custom_template}).create(project)

        project_folder = File.join(dir, project)

        # normal files
        assert_project_files project, project_folder

        assert_existence_of_folders %W{#{additional_directory}}, project_folder
      end
    end

    def test_create_texclipse
      Dir.mktmpdir do |dir|

        project = 'test'

        App.new([],{:working_directory => dir, 'texlipse' => true}).create(project)

        project_folder = File.join(dir, project)

        # normal files
        assert_project_files project, project_folder

        # additional tests
        assert_existence_of_files %w{.project .texlipse}, project_folder
        assert_existence_of_folders %w{tmp}, project_folder
      end
    end

    def test_create_texniccenter
      Dir.mktmpdir do |dir|

        project = 'test'

        App.new([],{:working_directory => dir, 'texniccenter' => true}).create(project)

        project_folder = File.join(dir, project)

        # normal files
        assert_project_files project, project_folder

        # additional files
        assert_existence_of_files %W{#{project}.tcp}, project_folder
      end
    end


    def test_clean
      Dir.mktmpdir do |dir|
        File.open(File.join(dir,"test.pdf"), "w") do |f|
          f << "asdf"
        end

        App.new([],{:working_directory => dir}).clean
        assert !File.exists?(File.join(dir,"test.pdf")),"test.pdf should be deleted"
      end
    end

    def test_version
      assert App.new.respond_to?(:version)
    end

    private

    def assert_project_files(project, project_folder)
      assert_existence_of_files %W{.gitignore README header.tex content.tex clean.bat clean.sh #{project}.tex #{project}.bib}, project_folder
      assert_existence_of_folders %w{. images includes .git}, project_folder
    end

    def assert_existence_of_files(files, folder)
      files.each do |file|
        assert File.exists?(File.join(folder,file)), "no #{file} file in #{folder}"
      end
    end

    def assert_existence_of_folders(folders, parent)
      folders.each do |folder|
        assert Dir.exists?(File.join(parent,folder)), "no #{folder} folder in #{parent}"
      end
    end

  end

end