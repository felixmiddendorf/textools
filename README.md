# Textools

[![Build Status](https://secure.travis-ci.org/simonharrer/textools.png)](http://travis-ci.org/simonharrer/textools)
[![Dependency Status](https://gemnasium.com/simonharrer/textools.png)](https://gemnasium.com/simonharrer/textools)

## Installation

    $> gem install textools

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

For creating the texniccenter project file, too:

    $ textools create test --texniccenter
    $ textools create test -tc # short version

For creating the texlipse project files, too:

    $ textools create test --texlipse
    $ textools create test -t # short version

To specific the working directory explicitly:

    $ textools create test --working_directory="/tmp" # creates /tmp/muh as the project directory
    $ textools create test -wd="/tmp" # short version

Inside a LaTeX project, you can remove any temporary files like this:

    $ textools clean
           remove  test.pdf

The version number can be printed like this:

    $ textools version
    Textools v0.0.2

## URLs

* https://github.com/simonharrer/textools