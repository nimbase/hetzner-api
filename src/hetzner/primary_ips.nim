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
  GetPrimaryIpsResponse* = object
    meta: JsonNode
    primary_ips: seq[JsonNode]
  PostPrimaryIpsRequest = object
    assignee_id: Option[int64]
    assignee_type: string
    auto_delete: Option[bool]
    datacenter: Option[string]
    labels: Option[JsonNode]
    name: string
    `type`: string
  PostPrimaryIpsResponse* = object
    action: JsonNode
    primary_ip: JsonNode
  GetPrimaryIpsIdResponse* = object
    primary_ip: JsonNode
  PutPrimaryIpsIdRequest = object
    auto_delete: Option[bool]
    labels: Option[JsonNode]
    name: Option[string]
  PutPrimaryIpsIdResponse* = object
    primary_ip: JsonNode
  PrimaryIpSortOption* = enum
    sortId = "id"
    sortIdAsc = "id:asc"
    sortIdDesc = "id:desc"
    sortCreated = "created"
    sortCreatedAsc = "created:asc"
    sortCreatedDesc = "created:desc"


proc getPrimaryIps*(client: HetznerClient, name: string = default(string),
                    labelSelector: string = default(string),
                    ip: string = default(string),
                    sort: set[PrimaryIpSortOption] = {}): Future[GetPrimaryIpsResponse] {.async.} =
  ## Returns all Primary IP objects.

  var q = initOrderedTable[string, string]()
  q["name"] = $name
  q["label_selector"] = $labelSelector
  q["ip"] = $ip
  for v in sort: q["sort"] = $v
  let res = await client.httpGET("/primary_ips", q)
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, GetPrimaryIpsResponse)
  else:
    raise newException(HetznerClientError, body)

proc postPrimaryIps*(client: HetznerClient, body: PostPrimaryIpsRequest): Future[PostPrimaryIpsResponse] {.async.} =
  ## Creates a new Primary IP, optionally assigned to a Server.
  ##
  ## If you want to create a Primary IP that is not assigned to a Server, you need to
  ## provide the `datacenter` key instead of `assignee_id`. This can be either the ID
  ## or the name of the Datacenter this Primary IP shall be created in.
  ##
  ## Note that a Primary IP can only be assigned to a Server in the same Datacenter
  ## later on.
  ##
  ## #### Call specific error codes
  ##
  ## | Code                          | Description
  ## |
  ## |------------------------------
  ## |-------------------------------------------------------------- |
  ## | `server_not_stopped`          | The specified server is running, but needs to
  ## be powered off  |
  ## | `server_has_ipv4`             | The server already has an ipv4 address
  ## |
  ## | `server_has_ipv6`             | The server already has an ipv6 address
  ## |

  let res = await client.httpPOST("/primary_ips", body)
  let body = await res.body
  case res.code
  of Http201:
    result = fromJson(body, PostPrimaryIpsResponse)
  else:
    raise newException(HetznerClientError, body)

proc getPrimaryIpsId*(client: HetznerClient, id: int64): Future[GetPrimaryIpsIdResponse] {.async.} =
  ## Returns a specific Primary IP object.

  let res = await client.httpGET(fmt"/primary_ips/{id}")
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, GetPrimaryIpsIdResponse)
  else:
    raise newException(HetznerClientError, body)

proc putPrimaryIpsId*(client: HetznerClient, id: int64,
                      body: PutPrimaryIpsIdRequest): Future[PutPrimaryIpsIdResponse] {.async.} =
  ## Updates the Primary IP.
  ##
  ## Note that when updating labels, the Primary IP's current set of labels will be
  ## replaced with the labels provided in the request body. So, for example, if you
  ## want to add a new label, you have to provide all existing labels plus the new
  ## label in the request body.
  ##
  ## If the Primary IP object changes during the request, the response will be a
  ## “conflict” error.

  let res = await client.httpPUT(fmt"/primary_ips/{id}", body)
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, PutPrimaryIpsIdResponse)
  else:
    raise newException(HetznerClientError, body)

proc deletePrimaryIpsId*(client: HetznerClient, id: int64): Future[AsyncResponse] {.async.} =
  ## Deletes a Primary IP.
  ##
  ## The Primary IP may be assigned to a Server. In this case it is unassigned
  ## automatically. The Server must be powered off (status `off`) in order for this
  ## operation to succeed.

  let res = await client.httpDELETE(fmt"/primary_ips/{id}")
  return res
