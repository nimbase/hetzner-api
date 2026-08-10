# hetzner API client for Nim
#
# Auto-generated from OpenAPI 3.x specification
# Nimbase CLI https://github.com/nimbase/nimbase
#
# License: MIT
import std/[strformat, json]
import ./private/metaclient

type
  GetLocationsResponse* = object
    locations: seq[JsonNode]
  GetLocationsIdResponse* = object
    location: JsonNode

proc getLocations*(client: HetznerClient, name: string = default(string)): Future[GetLocationsResponse] {.async.} =
  ## Returns all Location objects.

  var q = initOrderedTable[string, string]()
  q["name"] = $name
  let res = await client.httpGET("/locations", q)
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, GetLocationsResponse)
  else:
    raise newException(HetznerClientError, body)

proc getLocationsId*(client: HetznerClient, id: int64): Future[GetLocationsIdResponse] {.async.} =
  ## Returns a specific Location object.

  let res = await client.httpGET(fmt"/locations/{id}")
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, GetLocationsIdResponse)
  else:
    raise newException(HetznerClientError, body)
