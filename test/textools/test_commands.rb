require 'test/unit'
require 'textools/commands'
require 'tmpdir'

module Textools

  class TestApp < Test::Unit::TestCase

    def test_create
      Dir.mktmpdir do |dir|

        project = 'test'

        App.new([],{'working_directory' => dir}).create(project)

        assert Dir.exists?(File.join(dir,project))
        assert File.exists?(File.join(dir,project,'.gitignore')), "no .gitignore"
        assert File.exists?(File.join(dir,project,'README')), "no README"
        assert File.exists?(File.join(dir,project,"#{project}.tex")), "no project tex file"
        assert File.exists?(File.join(dir,project,'header.tex')), "no header file"
        assert File.exists?(File.join(dir,project,'content.tex')), "no content file"
        assert File.exists?(File.join(dir,project,'clean.bat')), "no clean.bat file"
        assert !File.exists?(File.join(dir,project,'clean.rb')), "no clean.rb file"
        assert File.exists?(File.join(dir,project,'clean.sh')), "no clean.sh file"
        assert Dir.exists?(File.join(dir,project,'images')), "no images folder"
        assert Dir.exists?(File.join(dir,project,'includes')), "no includes folder"
        assert Dir.exists?(File.join(dir,project,'.git')), "no git folder"
      end
    end

    def test_clean

      Dir.mktmpdir do |dir|
        File.open(File.join(dir,"test.pdf"), "w") do |f|
          f << "asdf"
        end

        App.new([],{'working_directory' => dir}).clean
        assert !File.exists?(File.join(dir,"test.pdf")),"test.pdf should be deleted"
      end
    end

  end

end