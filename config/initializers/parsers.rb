require 'parser_library'

ParserLibrary.configure do |pl|
  pl.add BatotoRipper
  pl.add ImgurRipper
  pl.add MangaEdenRipper
end
