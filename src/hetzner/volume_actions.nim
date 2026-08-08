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
  GetVolumesIdActionsResponse* = object
    actions: seq[JsonNode]
    meta: JsonNode
  PostVolumesIdActionsAttachRequest = object
    automount: Option[bool]
    server: int64
  PostVolumesIdActionsAttachResponse* = object
    action: JsonNode
  PostVolumesIdActionsChangeProtectionRequest = object
    delete: Option[bool]
  PostVolumesIdActionsChangeProtectionResponse* = object
    action: JsonNode
  PostVolumesIdActionsDetachResponse* = object
    action: JsonNode
  PostVolumesIdActionsResizeRequest = object
    size: float64
  PostVolumesIdActionsResizeResponse* = object
    action: JsonNode
  GetVolumesIdActionsActionIdResponse* = object
    action: JsonNode
  VolumeActionSortOption* = enum
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

  VolumeActionStatusOption* = enum
    statusRunning = "running"
    statusSuccess = "success"
    statusError = "error"


proc getVolumesIdActions*(client: HetznerClient, id: int64,
                          sort: set[VolumeActionSortOption] = {},
                          status: set[VolumeActionStatusOption] = {}): Future[GetVolumesIdActionsResponse] {.async.} =
  ## Returns all Action objects for a Volume. You can `sort` the results by using the
  ## sort URI parameter, and filter them with the `status` parameter.

  var q = initOrderedTable[string, string]()
  for v in sort: q["sort"] = $v
  for v in status: q["status"] = $v
  let res = await client.httpGET(fmt"/volumes/{id}/actions", q)
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, GetVolumesIdActionsResponse)
  else:
    raise newException(HetznerClientError, body)

proc postVolumesIdActionsAttach*(client: HetznerClient, id: int64,
                                 body: PostVolumesIdActionsAttachRequest): Future[PostVolumesIdActionsAttachResponse] {.async.} =
  ## Attaches a Volume to a Server. Works only if the Server is in the same Location
  ## as the Volume.

  let res = await client.httpPOST(fmt"/volumes/{id}/actions/attach", body)
  let body = await res.body
  case res.code
  of Http201:
    result = fromJson(body, PostVolumesIdActionsAttachResponse)
  else:
    raise newException(HetznerClientError, body)

proc postVolumesIdActionsChangeProtection*(client: HetznerClient, id: int64,
                                           body: PostVolumesIdActionsChangeProtectionRequest): Future[PostVolumesIdActionsChangeProtectionResponse] {.async.} =
  ## Changes the protection configuration of a Volume.

  let res = await client.httpPOST(fmt"/volumes/{id}/actions/change_protection", body)
  let body = await res.body
  case res.code
  of Http201:
    result = fromJson(body, PostVolumesIdActionsChangeProtectionResponse)
  else:
    raise newException(HetznerClientError, body)

proc postVolumesIdActionsDetach*(client: HetznerClient, id: int64): Future[PostVolumesIdActionsDetachResponse] {.async.} =
  ## Detaches a Volume from the Server it’s attached to. You may attach it to a
  ## Server again at a later time.

  let res = await client.httpPOST(fmt"/volumes/{id}/actions/detach")
  let body = await res.body
  case res.code
  of Http201:
    result = fromJson(body, PostVolumesIdActionsDetachResponse)
  else:
    raise newException(HetznerClientError, body)

proc postVolumesIdActionsResize*(client: HetznerClient, id: int64,
                                 body: PostVolumesIdActionsResizeRequest): Future[PostVolumesIdActionsResizeResponse] {.async.} =
  ## Changes the size of a Volume. Note that downsizing a Volume is not possible.

  let res = await client.httpPOST(fmt"/volumes/{id}/actions/resize", body)
  let body = await res.body
  case res.code
  of Http201:
    result = fromJson(body, PostVolumesIdActionsResizeResponse)
  else:
    raise newException(HetznerClientError, body)

proc getVolumesIdActionsActionId*(client: HetznerClient, id: int64,
                                  actionId: int64): Future[GetVolumesIdActionsActionIdResponse] {.async.} =
  ## Returns a specific Action for a Volume.

  let res = await client.httpGET(fmt"/volumes/{id}/actions/{actionId}")
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, GetVolumesIdActionsActionIdResponse)
  else:
    raise newException(HetznerClientError, body)
