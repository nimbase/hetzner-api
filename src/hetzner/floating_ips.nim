# hetzner API client for Nim
#
# Auto-generated from OpenAPI 3.x specification
# Nimbase CLI https://github.com/nimbase/nimbase
#
# Generated at: 2026-08-08T23:31:24+03:00
# License: MIT
import std/[strformat, options, json]
import ./private/metaclient

type
  GetFloatingIpsResponse* = object
    floating_ips: seq[JsonNode]
    meta: JsonNode
  PostFloatingIpsRequest = object
    description: Option[string]
    home_location: Option[string]
    labels: Option[JsonNode]
    name: Option[string]
    server: Option[int64]
    `type`: string
  PostFloatingIpsResponse* = object
    action: JsonNode
    floating_ip: JsonNode
  GetFloatingIpsIdResponse* = object
    floating_ip: JsonNode
  PutFloatingIpsIdRequest = object
    description: Option[string]
    labels: Option[JsonNode]
    name: Option[string]
  PutFloatingIpsIdResponse* = object
    floating_ip: JsonNode
  FloatingIpSortOption* = enum
    sortId = "id"
    sortIdAsc = "id:asc"
    sortIdDesc = "id:desc"
    sortCreated = "created"
    sortCreatedAsc = "created:asc"
    sortCreatedDesc = "created:desc"


proc getFloatingIps*(client: HetznerClient, name: string = default(string),
                     labelSelector: string = default(string),
                     sort: set[FloatingIpSortOption] = {}): Future[GetFloatingIpsResponse] {.async.} =
  ## Returns all Floating IP objects.

  var q = initOrderedTable[string, string]()
  q["name"] = $name
  q["label_selector"] = $labelSelector
  for v in sort: q["sort"] = $v
  let res = await client.httpGET("/floating_ips", q)
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, GetFloatingIpsResponse)
  else:
    raise newException(HetznerClientError, body)

proc postFloatingIps*(client: HetznerClient, body: PostFloatingIpsRequest): Future[PostFloatingIpsResponse] {.async.} =
  ## Creates a new Floating IP assigned to a Server. If you want to create a Floating
  ## IP that is not bound to a Server, you need to provide the `home_location` key
  ## instead of `server`. This can be either the ID or the name of the Location this
  ## IP shall be created in. Note that a Floating IP can be assigned to a Server in
  ## any Location later on. For optimal routing it is advised to use the Floating IP
  ## in the same Location it was created in.

  let res = await client.httpPOST("/floating_ips", body)
  let body = await res.body
  case res.code
  of Http201:
    result = fromJson(body, PostFloatingIpsResponse)
  else:
    raise newException(HetznerClientError, body)

proc getFloatingIpsId*(client: HetznerClient, id: int64): Future[GetFloatingIpsIdResponse] {.async.} =
  ## Returns a specific Floating IP object.

  let res = await client.httpGET(fmt"/floating_ips/{id}")
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, GetFloatingIpsIdResponse)
  else:
    raise newException(HetznerClientError, body)

proc putFloatingIpsId*(client: HetznerClient, id: int64,
                       body: PutFloatingIpsIdRequest): Future[PutFloatingIpsIdResponse] {.async.} =
  ## Updates the description or labels of a Floating IP.
  ## Also note that when updating labels, the Floating IP’s current set of labels
  ## will be replaced with the labels provided in the request body. So, for example,
  ## if you want to add a new label, you have to provide all existing labels plus the
  ## new label in the request body.

  let res = await client.httpPUT(fmt"/floating_ips/{id}", body)
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, PutFloatingIpsIdResponse)
  else:
    raise newException(HetznerClientError, body)

proc deleteFloatingIpsId*(client: HetznerClient, id: int64): Future[AsyncResponse] {.async.} =
  ## Deletes a Floating IP. If it is currently assigned to a Server it will
  ## automatically get unassigned.

  let res = await client.httpDELETE(fmt"/floating_ips/{id}")
  return res
