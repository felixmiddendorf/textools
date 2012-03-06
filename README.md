# Textools

## Installation

    $> gem install textools

## Usage

Creating a new LaTeX project works like this:

    $> textools create test
         create  test
         create  test/.gitignore
         create  test/clean.bat
         create  test/clean.sh
         create  test/images
         create  test/includes
         inside  test
            run    git init
            run    git add .

Inside a LaTeX project, you can remove any temporary files like this:

    $> textools clean
           remove  test.pdf

## URLs

* https://github.com/simonharrer/textools