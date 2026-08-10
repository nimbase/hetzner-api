# hetzner API client for Nim
#
# Auto-generated from OpenAPI 3.x specification
# Nimbase CLI https://github.com/nimbase/nimbase
#
# License: MIT
import std/[strformat, options, json]
import ./private/metaclient

type
  GetNetworksIdActionsResponse* = object
    actions: seq[JsonNode]
    meta: JsonNode
  PostNetworksIdActionsAddRouteRequest = object
    destination: string
    gateway: string
  PostNetworksIdActionsAddRouteResponse* = object
    action: JsonNode
  PostNetworksIdActionsAddSubnetRequest = object
    ip_range: Option[string]
    network_zone: string
    `type`: string
    vswitch_id: Option[int64]
  PostNetworksIdActionsAddSubnetResponse* = object
    action: JsonNode
  PostNetworksIdActionsChangeIpRangeRequest = object
    ip_range: string
  PostNetworksIdActionsChangeIpRangeResponse* = object
    action: JsonNode
  PostNetworksIdActionsChangeProtectionRequest = object
    delete: Option[bool]
  PostNetworksIdActionsChangeProtectionResponse* = object
    action: JsonNode
  PostNetworksIdActionsDeleteRouteRequest = object
    destination: string
    gateway: string
  PostNetworksIdActionsDeleteRouteResponse* = object
    action: JsonNode
  PostNetworksIdActionsDeleteSubnetRequest = object
    ip_range: string
  PostNetworksIdActionsDeleteSubnetResponse* = object
    action: JsonNode
  GetNetworksIdActionsActionIdResponse* = object
    action: JsonNode
  NetworkActionSortOption* = enum
    sortId = "id"
    sortIdAsc = "id:asc"
    sortIdDesc = "id:desc"
    sortCommand = "command"
    sortCommandAsc = "command:asc"
    sortCommandDesc = "command:desc"
    sortStatus = "status"
    sortStatusAsc = "status:asc"
    sortStatusDesc = "status:desc"
    sortProgress = "progress"
    sortProgressAsc = "progress:asc"
    sortProgressDesc = "progress:desc"
    sortStarted = "started"
    sortStartedAsc = "started:asc"
    sortStartedDesc = "started:desc"
    sortFinished = "finished"
    sortFinishedAsc = "finished:asc"
    sortFinishedDesc = "finished:desc"

  NetworkActionStatusOption* = enum
    statusRunning = "running"
    statusSuccess = "success"
    statusError = "error"


proc getNetworksIdActions*(client: HetznerClient, id: int64,
                           sort: set[NetworkActionSortOption] = {},
                           status: set[NetworkActionStatusOption] = {}): Future[GetNetworksIdActionsResponse] {.async.} =
  ## Returns all Action objects for a Network. You can sort the results by using the
  ## `sort` URI parameter, and filter them with the `status` parameter.

  var q = initOrderedTable[string, string]()
  for v in sort: q["sort"] = $v
  for v in status: q["status"] = $v
  let res = await client.httpGET(fmt"/networks/{id}/actions", q)
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, GetNetworksIdActionsResponse)
  else:
    raise newException(HetznerClientError, body)

proc postNetworksIdActionsAddRoute*(client: HetznerClient, id: int64,
                                    body: PostNetworksIdActionsAddRouteRequest): Future[PostNetworksIdActionsAddRouteResponse] {.async.} =
  ## Adds a route entry to a Network.
  ##
  ## Note: if the Network object changes during the request, the response will be a
  ## “conflict” error.

  let res = await client.httpPOST(fmt"/networks/{id}/actions/add_route", body)
  let body = await res.body
  case res.code
  of Http201:
    result = fromJson(body, PostNetworksIdActionsAddRouteResponse)
  else:
    raise newException(HetznerClientError, body)

proc postNetworksIdActionsAddSubnet*(client: HetznerClient, id: int64,
                                     body: PostNetworksIdActionsAddSubnetRequest): Future[PostNetworksIdActionsAddSubnetResponse] {.async.} =
  ## Adds a new subnet object to the Network. If you do not specify an `ip_range` for
  ## the subnet we will automatically pick the first available /24 range for you if
  ## possible.
  ##
  ## Note: if the parent Network object changes during the request, the response will
  ## be a “conflict” error.

  let res = await client.httpPOST(fmt"/networks/{id}/actions/add_subnet", body)
  let body = await res.body
  case res.code
  of Http201:
    result = fromJson(body, PostNetworksIdActionsAddSubnetResponse)
  else:
    raise newException(HetznerClientError, body)

proc postNetworksIdActionsChangeIpRange*(client: HetznerClient, id: int64,
                                         body: PostNetworksIdActionsChangeIpRangeRequest): Future[PostNetworksIdActionsChangeIpRangeResponse] {.async.} =
  ## Changes the IP range of a Network. IP ranges can only be extended and never
  ## shrunk. You can only add IPs at the end of an existing IP range. This means that
  ## the IP part of your existing range must stay the same and you can only change
  ## its netmask.
  ##
  ## For example if you have a range `10.0.0.0/16` you want to extend then your new
  ## range must also start with the IP `10.0.0.0`. Your CIDR netmask `/16` may change
  ## to a number that is smaller than `16` thereby increasing the IP range. So valid
  ## entries would be `10.0.0.0/15`, `10.0.0.0/14`, `10.0.0.0/13` and so on.
  ##
  ## After changing the IP range you will have to adjust the routes on your connected
  ## Servers by either rebooting them or manually changing the routes to your private
  ## Network interface.
  ##
  ## Note: if the Network object changes during the request, the response will be a
  ## “conflict” error.

  let res = await client.httpPOST(fmt"/networks/{id}/actions/change_ip_range", body)
  let body = await res.body
  case res.code
  of Http201:
    result = fromJson(body, PostNetworksIdActionsChangeIpRangeResponse)
  else:
    raise newException(HetznerClientError, body)

proc postNetworksIdActionsChangeProtection*(client: HetznerClient, id: int64,
                                            body: PostNetworksIdActionsChangeProtectionRequest): Future[PostNetworksIdActionsChangeProtectionResponse] {.async.} =
  ## Changes the protection configuration of a Network.
  ##
  ## Note: if the Network object changes during the request, the response will be a
  ## “conflict” error.

  let res = await client.httpPOST(fmt"/networks/{id}/actions/change_protection", body)
  let body = await res.body
  case res.code
  of Http201:
    result = fromJson(body, PostNetworksIdActionsChangeProtectionResponse)
  else:
    raise newException(HetznerClientError, body)

proc postNetworksIdActionsDeleteRoute*(client: HetznerClient, id: int64,
                                       body: PostNetworksIdActionsDeleteRouteRequest): Future[PostNetworksIdActionsDeleteRouteResponse] {.async.} =
  ## Delete a route entry from a Network.
  ##
  ## Note: if the Network object changes during the request, the response will be a
  ## “conflict” error.

  let res = await client.httpPOST(fmt"/networks/{id}/actions/delete_route", body)
  let body = await res.body
  case res.code
  of Http201:
    result = fromJson(body, PostNetworksIdActionsDeleteRouteResponse)
  else:
    raise newException(HetznerClientError, body)

proc postNetworksIdActionsDeleteSubnet*(client: HetznerClient, id: int64,
                                        body: PostNetworksIdActionsDeleteSubnetRequest): Future[PostNetworksIdActionsDeleteSubnetResponse] {.async.} =
  ## Deletes a single subnet entry from a Network. You cannot delete subnets which
  ## still have Servers attached. If you have Servers attached you first need to
  ## detach all Servers that use IPs from this subnet before you can delete the
  ## subnet.
  ##
  ## Note: if the Network object changes during the request, the response will be a
  ## “conflict” error.

  let res = await client.httpPOST(fmt"/networks/{id}/actions/delete_subnet", body)
  let body = await res.body
  case res.code
  of Http201:
    result = fromJson(body, PostNetworksIdActionsDeleteSubnetResponse)
  else:
    raise newException(HetznerClientError, body)

proc getNetworksIdActionsActionId*(client: HetznerClient, id: int64,
                                   actionId: int64): Future[GetNetworksIdActionsActionIdResponse] {.async.} =
  ## Returns a specific Action for a Network.

  let res = await client.httpGET(fmt"/networks/{id}/actions/{actionId}")
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, GetNetworksIdActionsActionIdResponse)
  else:
    raise newException(HetznerClientError, body)
