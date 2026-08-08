# hetzner

This is the official API documentation for the Public Hetzner Cloud.

> [!NOTE]
> Auto-generated Nim client for the Hetzner Cloud API, generated from the
> [Hetzner Cloud OpenAPI 3.x spec](https://api.apis.guru/v2/specs/hetzner.cloud/1.0.0/openapi.json)
> using the [Nimbase](https://github.com/nimbase/nimbase) CLI and released by
> the [NimbaseBot](https://github.com/nimbase/nimbase-bot) GitHub Action.

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

## Regeneration

Clients are regenerated automatically from the upstream spec by the
[`nimbase.yml`](.github/workflows/nimbase.yml) workflow: it checks for spec
changes on a nightly schedule (or via manual dispatch), regenerates `src/` and
`tests/`, runs `nimble test`, bumps the patch version, and commits/tags/releases
the update. If the tests fail, the bot files a GitHub issue with the errors
instead of releasing.

## License

MIT
