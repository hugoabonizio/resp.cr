require "./spec_helper"
require "resp"

describe RESP::Connection do
  context "Helper" do
    it "parse commands" do
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

  context "Raw" do
    it "parse raw commands" do
      input = <<-HERE
*3
$3
SET
$3
abc
$3
123
HERE
      reader = IO::Memory.new(input)
      connection = RESP::Connection.new(reader)
      connection.parse.should eq(["SET", ["abc", "123"]])
    end
  end
end
