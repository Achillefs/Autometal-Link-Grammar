%W{ rubygems gserver linkparser }.each { |r| require r }
=begin rdoc
= Requirements
  ruby 1.9.x (way, way faster than 1.8.x, but server will still work with 1.8)
  link-grammar (see Installation)
  linkparser gem (see Installation)
  json gem (unless you decide to only return integers or booleans)

  
= Installation
  cd tmp
  wget http://www.abisource.com/downloads/link-grammar/4.7.0/link-grammar-4.7.0.tar.gz
  tar -xzvf link-grammar-4.7.0.tar.gz
  cd link-grammar-4.7.0
  ./configure && make && sudo make install
  cd ..
  wget http://deveiate.org/code/linkparser-1.0.6.gem
  sudo env ARCHFLAGS="-arch i386" gem install linkparser-1.0.6.gem --no-ri --no-rdoc (on osx)
  sudo gem install linkparser-1.0.6.gem --no-ri --no-rdoc (on linux)
  sudo gem install json --no-ri --no-rdoc

= Example Server Script
  server = LinkParserServer.new(1211)
  server.audit = true
  puts "LinkParserServer version #{LinkGrammar::VERSION} starting at port #{server.port}"
  puts "copyright 2010 Achillefs Charmpilas - Humbucker Ltd"
  server.start
  server.join
=end
module LinkGrammar
  class Server < GServer
    attr_reader :dict
    def initialize(*args)
      super(*args)
      @dict = LinkParser::Dictionary.new( :screen_width => 100 )
    end
  
    def serve(io)
      line = io.readline
      begin
        response = dict.parse(line)
        io.puts(response.num_valid_linkages)
      rescue Exception => e
        io.puts("Error: #{e.message}")
      end
    end
  end
end