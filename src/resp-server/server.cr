require "socket"

module RESP
  class Server
    def initialize(@port = 6379)
      @server = TCPServer.new("127.0.0.1", @port)
    end

    def listen(&block : RESP::Connection ->)
      loop do
        socket = @server.accept
        spawn do
          connection = Connection.new(socket)
          loop do
            begin
              block.call(connection)
            rescue ex
              puts ex
              break
            end
          end
        end
      end
    end

    def process(socket, &block)
    end
  end
end
