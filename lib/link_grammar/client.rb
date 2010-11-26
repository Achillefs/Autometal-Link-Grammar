require "socket"
=begin rdoc
= Example Usage
  c = LinkParserClient.new("localhost",1211)
  r = c.parse("Only way to feel the noise is when it's coming loud.")
  puts r.inspect
=end
module LinkGrammar
  class Client
    attr_reader :server, :response, :port
    def initialize(server,port)
      @server, @port = server, port
    end
  
    def parse sentence
      t = TCPSocket.new(server,port)
      t.puts(sentence)
      @response = t.gets(nil)
      @response.to_i
    end
  end
end