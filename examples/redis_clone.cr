require "../src/resp"

server = RESP::Server.new
memory = {} of String => String
puts "Listening..."

# Listen for commands...
server.listen do |conn|
  operation, args = conn.parse
  if operation && operation.is_a?(String) && args
    if operation.upcase == "GET"
      conn.send_string(memory[args[0]]?)
    elsif operation.upcase == "SET"
      key = args[0]
      value = args[1]
      memory[key.as(String)] = value.as(String)

      conn.send_string("OK")
    end
  else
    conn.send_error("Error!")
  end
end
