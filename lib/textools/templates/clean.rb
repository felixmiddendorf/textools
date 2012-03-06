require "fileutils"

%w{*.aux *.bbl *.log *.pdf *.pgf *.dvi *.synctex* *.toc *.blg}.each do |pattern|
  FileUtils.rm Dir.glob(pattern)
end