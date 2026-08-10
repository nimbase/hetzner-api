# hetzner API client for Nim
#
# Auto-generated from OpenAPI 3.x specification
# Nimbase CLI https://github.com/nimbase/nimbase
#
# Generated at: 2026-08-10T04:22:05+00:00
# License: MIT
import std/[strformat, options, json]
import ./private/metaclient

type
  GetNetworksResponse* = object
    meta: JsonNode
    networks: seq[JsonNode]
  PostNetworksRequest = object
    ip_range: string
    labels: Option[JsonNode]
    name: string
    routes: Option[seq[JsonNode]]
    subnets: Option[seq[JsonNode]]
  PostNetworksResponse* = object
    network: JsonNode
  GetNetworksIdResponse* = object
    network: JsonNode
  PutNetworksIdRequest = object
    labels: Option[JsonNode]
    name: Option[string]
  PutNetworksIdResponse* = object
    network: JsonNode

proc getNetworks*(client: HetznerClient, name: string = default(string),
                  labelSelector: string = default(string)): Future[GetNetworksResponse] {.async.} =
  ## Gets all existing networks that you have available.

  var q = initOrderedTable[string, string]()
  q["name"] = $name
  q["label_selector"] = $labelSelector
  let res = await client.httpGET("/networks", q)
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, GetNetworksResponse)
  else:
    raise newException(HetznerClientError, body)

proc postNetworks*(client: HetznerClient, body: PostNetworksRequest): Future[PostNetworksResponse] {.async.} =
  ## Creates a network with the specified `ip_range`.
  ##
  ## You may specify one or more `subnets`. You can also add more Subnets later by
  ## using the [add subnet
  ## action](https://docs.hetzner.cloud/#network-actions-add-a-subnet-to-a-network).
  ## If you do not specify an `ip_range` in the subnet we will automatically pick the
  ## first available /24 range for you.
  ##
  ## You may specify one or more routes in `routes`. You can also add more routes
  ## later by using the [add route
  ## action](https://docs.hetzner.cloud/#network-actions-add-a-route-to-a-network).

  let res = await client.httpPOST("/networks", body)
  let body = await res.body
  case res.code
  of Http201:
    result = fromJson(body, PostNetworksResponse)
  else:
    raise newException(HetznerClientError, body)

proc getNetworksId*(client: HetznerClient, id: int64): Future[GetNetworksIdResponse] {.async.} =
  ## Gets a specific network object.

  let res = await client.httpGET(fmt"/networks/{id}")
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, GetNetworksIdResponse)
  else:
    raise newException(HetznerClientError, body)

proc putNetworksId*(client: HetznerClient, id: int64, body: PutNetworksIdRequest): Future[PutNetworksIdResponse] {.async.} =
  ## Updates the network properties.
  ##
  ## Note that when updating labels, the network’s current set of labels will be
  ## replaced with the labels provided in the request body. So, for example, if you
  ## want to add a new label, you have to provide all existing labels plus the new
  ## label in the request body.
  ##
  ## Note: if the network object changes during the request, the response will be a
  ## “conflict” error.

  let res = await client.httpPUT(fmt"/networks/{id}", body)
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, PutNetworksIdResponse)
  else:
    raise newException(HetznerClientError, body)

proc deleteNetworksId*(client: HetznerClient, id: int64): Future[AsyncResponse] {.async.} =
  ## Deletes a network. If there are Servers attached they will be detached in the
  ## background.
  ##
  ## Note: if the network object changes during the request, the response will be a
  ## “conflict” error.

  let res = await client.httpDELETE(fmt"/networks/{id}")
  return res
