# Textools

[![Build Status](https://secure.travis-ci.org/simonharrer/textools.png)](http://travis-ci.org/simonharrer/textools)
[![Dependency Status](https://gemnasium.com/simonharrer/textools.png)](https://gemnasium.com/simonharrer/textools)

## Installation

    $ gem install textools

## Usage

Creating a new LaTeX project works like this:

    $ textools create test
          create  test
          create  test/.gitignore
          create  test/clean.bat
          create  test/clean.sh
          create  test/README
          create  test/images
          create  test/includes
          create  test/test.tex
          create  test/header.tex
          create  test/content.tex
          inside  test
             run    git init from "./test"
    Initialized empty Git repository in c:/dev/tmp/test/.git/
             run    git add . from "./test"

Add the `--texniccenter` flag to create a [TeXnicCenter](http://www.texniccenter.org/) project file:

    $ textools create test --texniccenter
    $ textools create test -tc # short version

Add the `--texlipse` flag to create [TeXlipse](http://texlipse.sourceforge.net/) project files:

    $ textools create test --texlipse
    $ textools create test -t # short version

Use the `--working-directory` flag to explicitly specify the working directory:

    $ textools create test --working-directory="/tmp" # creates /tmp/test as the project directory
    $ textools create test -wd="/tmp" # short version

Use the `--template PATH_TO_RUBY_FILE` parameter to specifiy additional [tasks](https://github.com/wycats/thor/wiki/Actions) to be executed during project creation:

    custom_template.rb:
        empty_directory "example_dir"

    $ textools create test --template="custom_template.rb" # executes custom_template.rb adding test/example_dir
    $ textools create test -m="custom_template.rb" # short version

Inside a LaTeX project, you can remove any temporary files like this:

    $ textools clean
           remove  test.pdf

The version number can be printed like this:

    $ textools version
    Textools v0.0.2

## URLs

* https://github.com/simonharrer/textools
