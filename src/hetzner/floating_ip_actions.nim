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
  GetFloatingIpsIdActionsResponse* = object
    actions: seq[JsonNode]
  PostFloatingIpsIdActionsAssignRequest = object
    server: int64
  PostFloatingIpsIdActionsAssignResponse* = object
    action: JsonNode
  PostFloatingIpsIdActionsChangeDnsPtrRequest = object
    dns_ptr: Option[string]
    ip: string
  PostFloatingIpsIdActionsChangeDnsPtrResponse* = object
    action: JsonNode
  PostFloatingIpsIdActionsChangeProtectionRequest = object
    delete: Option[bool]
  PostFloatingIpsIdActionsChangeProtectionResponse* = object
    action: JsonNode
  PostFloatingIpsIdActionsUnassignResponse* = object
    action: JsonNode
  GetFloatingIpsIdActionsActionIdResponse* = object
    action: JsonNode
  FloatingIpActionSortOption* = enum
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

  FloatingIpActionStatusOption* = enum
    statusRunning = "running"
    statusSuccess = "success"
    statusError = "error"


proc getFloatingIpsIdActions*(client: HetznerClient, id: int64,
                              sort: set[FloatingIpActionSortOption] = {},
                              status: set[FloatingIpActionStatusOption] = {}): Future[GetFloatingIpsIdActionsResponse] {.async.} =
  ## Returns all Action objects for a Floating IP. You can sort the results by using
  ## the `sort` URI parameter, and filter them with the `status` parameter.

  var q = initOrderedTable[string, string]()
  for v in sort: q["sort"] = $v
  for v in status: q["status"] = $v
  let res = await client.httpGET(fmt"/floating_ips/{id}/actions", q)
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, GetFloatingIpsIdActionsResponse)
  else:
    raise newException(HetznerClientError, body)

proc postFloatingIpsIdActionsAssign*(client: HetznerClient, id: int64,
                                     body: PostFloatingIpsIdActionsAssignRequest): Future[PostFloatingIpsIdActionsAssignResponse] {.async.} =
  ## Assigns a Floating IP to a Server.

  let res = await client.httpPOST(fmt"/floating_ips/{id}/actions/assign", body)
  let body = await res.body
  case res.code
  of Http201:
    result = fromJson(body, PostFloatingIpsIdActionsAssignResponse)
  else:
    raise newException(HetznerClientError, body)

proc postFloatingIpsIdActionsChangeDnsPtr*(client: HetznerClient, id: int64,
                                           body: PostFloatingIpsIdActionsChangeDnsPtrRequest): Future[PostFloatingIpsIdActionsChangeDnsPtrResponse] {.async.} =
  ## Changes the hostname that will appear when getting the hostname belonging to
  ## this Floating IP.

  let res = await client.httpPOST(fmt"/floating_ips/{id}/actions/change_dns_ptr", body)
  let body = await res.body
  case res.code
  of Http201:
    result = fromJson(body, PostFloatingIpsIdActionsChangeDnsPtrResponse)
  else:
    raise newException(HetznerClientError, body)

proc postFloatingIpsIdActionsChangeProtection*(client: HetznerClient, id: int64,
                                               body: PostFloatingIpsIdActionsChangeProtectionRequest): Future[PostFloatingIpsIdActionsChangeProtectionResponse] {.async.} =
  ## Changes the protection configuration of the Floating IP.

  let res = await client.httpPOST(fmt"/floating_ips/{id}/actions/change_protection", body)
  let body = await res.body
  case res.code
  of Http201:
    result = fromJson(body, PostFloatingIpsIdActionsChangeProtectionResponse)
  else:
    raise newException(HetznerClientError, body)

proc postFloatingIpsIdActionsUnassign*(client: HetznerClient, id: int64): Future[PostFloatingIpsIdActionsUnassignResponse] {.async.} =
  ## Unassigns a Floating IP, resulting in it being unreachable. You may assign it to
  ## a Server again at a later time.

  let res = await client.httpPOST(fmt"/floating_ips/{id}/actions/unassign")
  let body = await res.body
  case res.code
  of Http201:
    result = fromJson(body, PostFloatingIpsIdActionsUnassignResponse)
  else:
    raise newException(HetznerClientError, body)

proc getFloatingIpsIdActionsActionId*(client: HetznerClient, id: int64,
                                      actionId: int64): Future[GetFloatingIpsIdActionsActionIdResponse] {.async.} =
  ## Returns a specific Action object for a Floating IP.

  let res = await client.httpGET(fmt"/floating_ips/{id}/actions/{actionId}")
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, GetFloatingIpsIdActionsActionIdResponse)
  else:
    raise newException(HetznerClientError, body)
