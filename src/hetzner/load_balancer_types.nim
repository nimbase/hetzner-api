# hetzner API client for Nim
#
# Auto-generated from OpenAPI 3.x specification
# Nimbase CLI https://github.com/nimbase/nimbase
#
# License: MIT
import std/[strformat, json]
import ./private/metaclient

type
  GetLoadBalancerTypesResponse* = object
    load_balancer_types: seq[JsonNode]
  GetLoadBalancerTypesIdResponse* = object
    load_balancer_type: JsonNode

proc getLoadBalancerTypes*(client: HetznerClient, name: string = default(string)): Future[GetLoadBalancerTypesResponse] {.async.} =
  ## Gets all Load Balancer type objects.

  var q = initOrderedTable[string, string]()
  q["name"] = $name
  let res = await client.httpGET("/load_balancer_types", q)
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, GetLoadBalancerTypesResponse)
  else:
    raise newException(HetznerClientError, body)

proc getLoadBalancerTypesId*(client: HetznerClient, id: int64): Future[GetLoadBalancerTypesIdResponse] {.async.} =
  ## Gets a specific Load Balancer type object.

  let res = await client.httpGET(fmt"/load_balancer_types/{id}")
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, GetLoadBalancerTypesIdResponse)
  else:
    raise newException(HetznerClientError, body)
