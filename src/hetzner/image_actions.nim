# hetzner API client for Nim
#
# Auto-generated from OpenAPI 3.x specification
# Nimbase CLI https://github.com/nimbase/nimbase
#
# Generated at: 2026-08-09T00:17:48+00:00
# License: MIT
import std/[strformat, options, json]
import ./private/metaclient

type
  GetImagesIdActionsResponse* = object
    actions: seq[JsonNode]
    meta: JsonNode
  PostImagesIdActionsChangeProtectionRequest = object
    delete: Option[bool]
  PostImagesIdActionsChangeProtectionResponse* = object
    action: JsonNode
  GetImagesIdActionsActionIdResponse* = object
    action: JsonNode
  ImageActionSortOption* = enum
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

  ImageActionStatusOption* = enum
    statusRunning = "running"
    statusSuccess = "success"
    statusError = "error"


proc getImagesIdActions*(client: HetznerClient, id: int64,
                         sort: set[ImageActionSortOption] = {},
                         status: set[ImageActionStatusOption] = {}): Future[GetImagesIdActionsResponse] {.async.} =
  ## Returns all Action objects for an Image. You can sort the results by using the
  ## `sort` URI parameter, and filter them with the `status` parameter.

  var q = initOrderedTable[string, string]()
  for v in sort: q["sort"] = $v
  for v in status: q["status"] = $v
  let res = await client.httpGET(fmt"/images/{id}/actions", q)
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, GetImagesIdActionsResponse)
  else:
    raise newException(HetznerClientError, body)

proc postImagesIdActionsChangeProtection*(client: HetznerClient, id: int64,
                                          body: PostImagesIdActionsChangeProtectionRequest): Future[PostImagesIdActionsChangeProtectionResponse] {.async.} =
  ## Changes the protection configuration of the Image. Can only be used on
  ## snapshots.

  let res = await client.httpPOST(fmt"/images/{id}/actions/change_protection", body)
  let body = await res.body
  case res.code
  of Http201:
    result = fromJson(body, PostImagesIdActionsChangeProtectionResponse)
  else:
    raise newException(HetznerClientError, body)

proc getImagesIdActionsActionId*(client: HetznerClient, id: int64,
                                 actionId: int64): Future[GetImagesIdActionsActionIdResponse] {.async.} =
  ## Returns a specific Action for an Image.

  let res = await client.httpGET(fmt"/images/{id}/actions/{actionId}")
  let body = await res.body
  case res.code
  of Http200:
    result = fromJson(body, GetImagesIdActionsActionIdResponse)
  else:
    raise newException(HetznerClientError, body)
