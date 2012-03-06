require 'test/unit'
require 'textools/commands'

module Textools

  class TestApp < Test::Unit::TestCase

    def test_create
      App.new([],{'working_directory' => '/c/dev/tmp'}).create('test')

      assert Directory.exists?('test')
      assert File.exists?('test/.gitignore')
      assert File.exists?('test/clean.sh')
      assert File.exists?('test/clean.bat')
      assert File.exists?('test/clean.rb')
    end

  end

end