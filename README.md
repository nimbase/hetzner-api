# hetzner

This is the official API documentation for the Public Hetzner Cloud.

## Installation

```bash
nimble install hetzner
```

## Usage

```nim
import hetzner

proc main() {.async.} =
  var client = initHetznerClient("your-api-key")
  let servers = await client.getServers()
  echo servers

waitFor main()
```

## License

MIT
