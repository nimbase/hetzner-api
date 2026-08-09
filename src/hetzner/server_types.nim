# hetzner API client for Nim
#
# Auto-generated from OpenAPI 3.x specification
# Nimbase CLI https://github.com/nimbase/nimbase
#
# Generated at: 2026-08-09T04:08:19+00:00
# License: MIT
import std/[strformat, options, json]
import ./private/metaclient

type
  GetServerTypesResponse* = object
    server_types: seq[JsonNode]
  GetServerTypesIdResponse* = object
    server_type: JsonNode

proc getServerTypes*(client: HetznerClient, name: string = default(string)): Future[GetServerTypesResponse] {.async.} =
  ## Gets all Server type objects.

  var q = initOrderedTable[string, string]()
  q["name"] = $name
  let res = await client.httpGET("/server_types", q)
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, GetServerTypesResponse)
  else:
    raise newException(HetznerClientError, body)

proc getServerTypesId*(client: HetznerClient, id: int64): Future[GetServerTypesIdResponse] {.async.} =
  ## Gets a specific Server type object.

  let res = await client.httpGET(fmt"/server_types/{id}")
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, GetServerTypesIdResponse)
  else:
    raise newException(HetznerClientError, body)
