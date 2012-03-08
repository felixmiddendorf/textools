require 'test/unit'
require 'textools/commands'
require 'tmpdir'

module Textools

  class TestApp < Test::Unit::TestCase

    def test_create
      Dir.mktmpdir do |dir|

        project = 'test'

        App.new([],{:working_directory => dir}).create(project)

        assert Dir.exists?(File.join(dir,project)), "no project directory named #{project}"
        %W{.gitignore README header.tex content.tex clean.bat clean.sh #{project}.tex}.each do |file|
          assert File.exists?(File.join(dir,project,file)), "no #{file} file"
        end

        %w{images includes .git}.each do|folder|
          assert Dir.exists?(File.join(dir,project,folder)), "no #{folder} folder"
        end

      end
    end

    def test_create_texclipse
      Dir.mktmpdir do |dir|

        project = 'test'

        App.new([],{:working_directory => dir, 'texlipse' => true}).create(project)

        assert Dir.exists?(File.join(dir,project)), "no project directory named #{project}"
        %W{.gitignore README header.tex content.tex clean.bat clean.sh #{project}.tex .project .texlipse}.each do |file|
          assert File.exists?(File.join(dir,project,file)), "no #{file} file"
        end

        %w{images includes .git}.each do|folder|
          assert Dir.exists?(File.join(dir,project,folder)), "no #{folder} folder"
        end

      end
    end

    def test_create_texniccenter
      Dir.mktmpdir do |dir|

        project = 'test'

        App.new([],{:working_directory => dir, 'texniccenter' => true}).create(project)

        assert Dir.exists?(File.join(dir,project)), "no project directory named #{project}"
        %W{.gitignore README header.tex content.tex clean.bat clean.sh #{project}.tex #{project}.tcp}.each do |file|
          assert File.exists?(File.join(dir,project,file)), "no #{file} file"
        end

        %w{images includes .git}.each do|folder|
          assert Dir.exists?(File.join(dir,project,folder)), "no #{folder} folder"
        end

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

  end

end