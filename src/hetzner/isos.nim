# hetzner API client for Nim
#
# Auto-generated from OpenAPI 3.x specification
# Nimbase CLI https://github.com/nimbase/nimbase
#
# License: MIT
import std/[strformat, json]
import ./private/metaclient

type
  GetIsosResponse* = object
    isos: seq[JsonNode]
    meta: JsonNode
  GetIsosIdResponse* = object
    iso: JsonNode

proc getIsos*(client: HetznerClient, name: string = default(string)): Future[GetIsosResponse] {.async.} =
  ## Returns all available ISO objects.

  var q = initOrderedTable[string, string]()
  q["name"] = $name
  let res = await client.httpGET("/isos", q)
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, GetIsosResponse)
  else:
    raise newException(HetznerClientError, body)

proc getIsosId*(client: HetznerClient, id: int64): Future[GetIsosIdResponse] {.async.} =
  ## Returns a specific ISO object.

  let res = await client.httpGET(fmt"/isos/{id}")
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, GetIsosIdResponse)
  else:
    raise newException(HetznerClientError, body)
