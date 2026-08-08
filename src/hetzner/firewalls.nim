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
  GetFirewallsResponse* = object
    firewalls: seq[JsonNode]
    meta: JsonNode
  PostFirewallsRequest = object
    apply_to: Option[seq[JsonNode]]
    labels: Option[JsonNode]
    name: string
    rules: Option[seq[JsonNode]]
  PostFirewallsResponse* = object
    actions: seq[JsonNode]
    firewall: JsonNode
  GetFirewallsIdResponse* = object
    firewall: JsonNode
  PutFirewallsIdRequest = object
    labels: Option[JsonNode]
    name: Option[string]
  PutFirewallsIdResponse* = object
    firewall: JsonNode
  FirewallSortOption* = enum
    sortId = "id"
    sortIdAsc = "id:asc"
    sortIdDesc = "id:desc"
    sortName = "name"
    sortNameAsc = "name:asc"
    sortNameDesc = "name:desc"
    sortCreated = "created"
    sortCreatedAsc = "created:asc"
    sortCreatedDesc = "created:desc"


proc getFirewalls*(client: HetznerClient, sort: set[FirewallSortOption] = {},
                   name: string = default(string),
                   labelSelector: string = default(string)): Future[GetFirewallsResponse] {.async.} =
  ## Returns all Firewall objects.

  var q = initOrderedTable[string, string]()
  for v in sort: q["sort"] = $v
  q["name"] = $name
  q["label_selector"] = $labelSelector
  let res = await client.httpGET("/firewalls", q)
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, GetFirewallsResponse)
  else:
    raise newException(HetznerClientError, body)

proc postFirewalls*(client: HetznerClient, body: PostFirewallsRequest): Future[PostFirewallsResponse] {.async.} =
  ## Creates a new Firewall.
  ##
  ## #### Call specific error codes
  ##
  ## | Code                          | Description
  ## |
  ## |------------------------------
  ## |-------------------------------------------------------------- |
  ## | `server_already_added`        | Server added more than one time to resource
  ## |
  ## | `incompatible_network_type`   | The Network type is incompatible for the given
  ## resource       |
  ## | `firewall_resource_not_found` | The resource the Firewall should be attached
  ## to was not found |

  let res = await client.httpPOST("/firewalls", body)
  let body = await res.body
  case res.code
  of Http201:
    result = fromJson(body, PostFirewallsResponse)
  else:
    raise newException(HetznerClientError, body)

proc getFirewallsId*(client: HetznerClient, id: int64): Future[GetFirewallsIdResponse] {.async.} =
  ## Gets a specific Firewall object.

  let res = await client.httpGET(fmt"/firewalls/{id}")
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, GetFirewallsIdResponse)
  else:
    raise newException(HetznerClientError, body)

proc putFirewallsId*(client: HetznerClient, id: int64,
                     body: PutFirewallsIdRequest): Future[PutFirewallsIdResponse] {.async.} =
  ## Updates the Firewall.
  ##
  ## Note that when updating labels, the Firewall's current set of labels will be
  ## replaced with the labels provided in the request body. So, for example, if you
  ## want to add a new label, you have to provide all existing labels plus the new
  ## label in the request body.
  ##
  ## Note: if the Firewall object changes during the request, the response will be a
  ## “conflict” error.

  let res = await client.httpPUT(fmt"/firewalls/{id}", body)
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, PutFirewallsIdResponse)
  else:
    raise newException(HetznerClientError, body)

proc deleteFirewallsId*(client: HetznerClient, id: int64): Future[AsyncResponse] {.async.} =
  ## Deletes a Firewall.
  ##
  ## #### Call specific error codes
  ##
  ## | Code                 | Description                               |
  ## |--------------------- |-------------------------------------------|
  ## | `resource_in_use`    | Firewall must not be in use to be deleted |

  let res = await client.httpDELETE(fmt"/firewalls/{id}")
  return res
