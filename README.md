# RESP

[![Build Status](https://travis-ci.org/hugoabonizio/resp.cr.svg?branch=master)](https://travis-ci.org/hugoabonizio/resp.cr) [![Dependency Status](https://shards.rocks/badge/github/hugoabonizio/resp.cr/status.svg)](https://shards.rocks/github/hugoabonizio/resp.cr) [![devDependency Status](https://shards.rocks/badge/github/hugoabonizio/resp.cr/dev_status.svg)](https://shards.rocks/github/hugoabonizio/resp.cr)

Lightweight [RESP](https://redis.io/topics/protocol) server and parser written in Crystal. It can be used to implement a [Redis clone](https://github.com/hugoabonizio/resp.cr/blob/master/examples/redis_clone.cr) or a Redis load balancer, for exemple.

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  resp:
    github: hugoabonizio/resp.cr
```

## Usage

```crystal
require "resp"
server = RESP::Server.new
server.listen do |conn|
  # Returns the command followed by a list of arguments
  operation, args = conn.parse
  puts "op: #{operation}, args: #{args}"
end
```

## Contributing

1. Fork it ( https://github.com/hugoabonizio/resp/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [hugoabonizio](https://github.com/hugoabonizio) Hugo Abonizio - creator, maintainer
