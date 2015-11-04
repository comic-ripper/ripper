module ParserLibrary
  class LibraryConfig
    attr_accessor :parsers
    def initialize
      @parsers = []
    end

    def configure
      yield self
    end

    def get_parser(url)
      parsers.find { |parser| parser.applies? url }
    end

    def add(parser)
      if parser.respond_to? :parsers
        @parsers += parser.parsers
      else
        @parsers << parser
      end
    end
  end

  def self.config
    @config ||= LibraryConfig.new
  end

  def self.configure(&block)
    config.configure(&block)
  end

  def self.get_parser(url)
    config.get_parser(url)
  end
end
