# hetzner API client for Nim
#
# Auto-generated from OpenAPI 3.x specification
# Nimbase CLI https://github.com/nimbase/nimbase
#
# Generated at: 2026-08-09T00:17:48+00:00
# License: MIT
import std/[strformat, options, json]
import ./private/metaclient

type
  GetDatacentersResponse* = object
    datacenters: seq[JsonNode]
    recommendation: float64
      ## The Datacenter which is recommended to be used to create new Servers.
  GetDatacentersIdResponse* = object
    datacenter: JsonNode

proc getDatacenters*(client: HetznerClient, name: string = default(string)): Future[GetDatacentersResponse] {.async.} =
  ## Returns all Datacenter objects.

  var q = initOrderedTable[string, string]()
  q["name"] = $name
  let res = await client.httpGET("/datacenters", q)
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, GetDatacentersResponse)
  else:
    raise newException(HetznerClientError, body)

proc getDatacentersId*(client: HetznerClient, id: int64): Future[GetDatacentersIdResponse] {.async.} =
  ## Returns a specific Datacenter object.

  let res = await client.httpGET(fmt"/datacenters/{id}")
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, GetDatacentersIdResponse)
  else:
    raise newException(HetznerClientError, body)
