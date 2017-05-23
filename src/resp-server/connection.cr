module RESP
  class Connection
    CRLF = "\r\n"
    LF   = "\n"

    getter socket

    def initialize(@socket : IO)
    end

    forward_missing_to @socket

    def parse
      first = @socket.read_char
      operation = nil
      arguments = Array(String).new

      return [nil, arguments] if first.nil?

      if first == '*'
        array = parse_array
        if array.size > 0
          operation = array[0]
          arguments = array[1..-1]
        end
      end
      @socket.skip(2)
      [operation, arguments]
    end

    def parse_array
      size = @socket.gets
      array = Array(String).new
      if size
        size.to_i.times do |i|
          a = parse_bulk_string.not_nil!
          array << a
        end
      end
      array
    end

    def parse_bulk_string
      size = @socket.gets
      string = ""
      if size && size[0] == '$'
        string = @socket.gets
      end
      string
    end

    def send_integer(integer)
      @socket.puts(":#{integer}#{CRLF}")
    end

    def send_string(string)
      return @socket.puts("$-1#{CRLF}") unless string
      @socket.puts("+#{string}#{CRLF}")
    end

    def send_error(error)
      @socket.puts("-#{error}#{CRLF}")
    end
  end
end
