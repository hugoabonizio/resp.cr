require "./spec_helper"
require "resp"

describe RESP::Connection do
  it "should parse commands" do
    commands = {
      Resp.encode("ping")                => ["ping", [] of String],
      Resp.encode("get", "key")          => ["get", ["key"]],
      Resp.encode("set", "key", "value") => ["set", ["key", "value"]],
    }

    commands.each do |cmd, result|
      input = IO::Memory.new(cmd)
      connection = RESP::Connection.new(input)
      connection.parse.should eq(result)
    end
  end
end
